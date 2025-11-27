// Preconfigured storage helpers for Manus WebDev templates
// Uses the Biz-provided storage proxy (Authorization: Bearer <token>)

import fs from "fs/promises";
import path from "path";
import { PutObjectCommand, S3Client } from "@aws-sdk/client-s3";

import { ENV } from "./_core/env";

type StorageConfig = { baseUrl: string; apiKey: string };
type B2Config = {
  endpoint: string;
  bucketName: string;
  accessKeyId: string;
  secretAccessKey: string;
  region: string;
};

const UPLOADS_DIR = path.join(process.cwd(), "public/uploads");

let cachedB2Client: S3Client | null = null;

function getStorageConfig(): StorageConfig | null {
  const baseUrl = ENV.forgeApiUrl;
  const apiKey = ENV.forgeApiKey;

  if (!baseUrl || !apiKey) {
    return null;
  }

  return { baseUrl: baseUrl.replace(/\/+$/, ""), apiKey };
}

function getB2Config(): B2Config | null {
  if (
    !ENV.b2Endpoint ||
    !ENV.b2BucketName ||
    !ENV.b2AccessKeyId ||
    !ENV.b2SecretAccessKey
  ) {
    return null;
  }

  return {
    endpoint: ENV.b2Endpoint,
    bucketName: ENV.b2BucketName,
    accessKeyId: ENV.b2AccessKeyId,
    secretAccessKey: ENV.b2SecretAccessKey,
    region: ENV.b2Region || "us-east-005",
  };
}

function buildUploadUrl(baseUrl: string, relKey: string): URL {
  const url = new URL("v1/storage/upload", ensureTrailingSlash(baseUrl));
  url.searchParams.set("path", normalizeKey(relKey));
  return url;
}

async function buildDownloadUrl(
  baseUrl: string,
  relKey: string,
  apiKey: string
): Promise<string> {
  const downloadApiUrl = new URL(
    "v1/storage/downloadUrl",
    ensureTrailingSlash(baseUrl)
  );
  downloadApiUrl.searchParams.set("path", normalizeKey(relKey));
  const response = await fetch(downloadApiUrl, {
    method: "GET",
    headers: buildAuthHeaders(apiKey),
  });
  return (await response.json()).url;
}

function ensureTrailingSlash(value: string): string {
  return value.endsWith("/") ? value : `${value}/`;
}

function normalizeKey(relKey: string): string {
  return relKey.replace(/^\/+/, "");
}

function normalizeBuffer(data: Buffer | Uint8Array | string): Buffer {
  if (typeof data === "string") {
    return Buffer.from(data);
  }

  if (Buffer.isBuffer(data)) {
    return data;
  }

  return Buffer.from(data);
}

function buildB2Client(config: B2Config): S3Client {
  if (!cachedB2Client) {
    cachedB2Client = new S3Client({
      region: config.region,
      endpoint: ensureProtocol(config.endpoint),
      forcePathStyle: true,
      credentials: {
        accessKeyId: config.accessKeyId,
        secretAccessKey: config.secretAccessKey,
      },
    });
  }

  return cachedB2Client;
}

function ensureProtocol(endpoint: string): string {
  if (/^https?:\/\//i.test(endpoint)) {
    return endpoint;
  }
  return `https://${endpoint}`;
}

function buildB2PublicUrl(config: B2Config, relKey: string): string {
  const base = ensureTrailingSlash(ensureProtocol(config.endpoint));
  return new URL(`${config.bucketName}/${normalizeKey(relKey)}`, base).toString();
}

async function saveLocally(key: string, data: Buffer | Uint8Array | string) {
  const targetPath = path.join(UPLOADS_DIR, normalizeKey(key));
  await fs.mkdir(path.dirname(targetPath), { recursive: true });
  const buffer = normalizeBuffer(data);
  await fs.writeFile(targetPath, buffer);

  return `/uploads/${normalizeKey(key)}`;
}

function toFormData(
  data: Buffer | Uint8Array | string,
  contentType: string,
  fileName: string
): FormData {
  const blob =
    typeof data === "string"
      ? new Blob([data], { type: contentType })
      : new Blob([data as any], { type: contentType });
  const form = new FormData();
  form.append("file", blob, fileName || "file");
  return form;
}

function buildAuthHeaders(apiKey: string): HeadersInit {
  return { Authorization: `Bearer ${apiKey}` };
}

export async function storagePut(
  relKey: string,
  data: Buffer | Uint8Array | string,
  contentType = "application/octet-stream"
): Promise<{ key: string; url: string }> {
  const key = normalizeKey(relKey);
  const config = getStorageConfig();
  const b2Config = getB2Config();

  if (config) {
    const { baseUrl, apiKey } = config;
    const uploadUrl = buildUploadUrl(baseUrl, key);
    const formData = toFormData(data, contentType, key.split("/").pop() ?? key);
    const response = await fetch(uploadUrl, {
      method: "POST",
      headers: buildAuthHeaders(apiKey),
      body: formData,
    });

    if (!response.ok) {
      const message = await response.text().catch(() => response.statusText);
      throw new Error(
        `Storage upload failed (${response.status} ${response.statusText}): ${message}`
      );
    }
    const url = (await response.json()).url;
    return { key, url };
  }

  if (b2Config) {
    const client = buildB2Client(b2Config);
    const buffer = normalizeBuffer(data);

    await client.send(
      new PutObjectCommand({
        Bucket: b2Config.bucketName,
        Key: key,
        Body: buffer,
        ContentType: contentType,
        ACL: "public-read",
      })
    );

    return { key, url: buildB2PublicUrl(b2Config, key) };
  }

  const url = await saveLocally(key, data);
  return { key, url };
}

export async function storageGet(relKey: string): Promise<{ key: string; url: string; }> {
  const key = normalizeKey(relKey);
  const config = getStorageConfig();
  const b2Config = getB2Config();

  if (config) {
    const { baseUrl, apiKey } = config;
    return { key, url: await buildDownloadUrl(baseUrl, key, apiKey) };
  }

  if (b2Config) {
    return { key, url: buildB2PublicUrl(b2Config, key) };
  }

  return { key, url: `/uploads/${key}` };
}
