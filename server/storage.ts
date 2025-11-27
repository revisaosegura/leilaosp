// Preconfigured storage helpers for Manus WebDev templates
// Uses the Biz-provided storage proxy (Authorization: Bearer <token>)

import fs from "fs/promises";
import path from "path";
import { PutObjectCommand, S3Client } from "@aws-sdk/client-s3";

import { ENV } from "./_core/env";

type StorageConfig = { baseUrl: string; apiKey: string };
export class StorageConfigError extends Error {
  status: number;

  constructor(message: string, status = 400) {
    super(message);
    this.status = status;
  }
}

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
  const endpoint = ENV.b2Endpoint.trim();
  const bucketName = ENV.b2BucketName.trim();
  const accessKeyId = ENV.b2AccessKeyId.trim();
  const secretAccessKey = ENV.b2SecretAccessKey.trim();
  const region = ENV.b2Region.trim();

  if (!endpoint || !bucketName || !accessKeyId || !secretAccessKey) {
    return null;
  }

  const endpointRegion = extractRegionFromEndpoint(endpoint);

  if (!endpointRegion) {
    throw new StorageConfigError(
      "B2_ENDPOINT deve ser o endpoint S3 do Backblaze (ex.: s3.us-east-005.backblazeb2.com)"
    );
  }

  if (region && region !== endpointRegion) {
    throw new StorageConfigError(
      `B2_REGION (${region}) deve corresponder à região do endpoint (${endpointRegion}). Ajuste para evitar falhas de assinatura.`
    );
  }

  const parsedRegion = region || endpointRegion || "us-east-005";

  return {
    endpoint,
    bucketName,
    accessKeyId,
    secretAccessKey,
    region: parsedRegion,
  };
}

function validateB2AccessKeyId(accessKeyId: string): string | null {
  const trimmed = accessKeyId.trim();

  // Application Key IDs for the S3 API are typically 25 chars (account IDs are 12).
  if (trimmed.length < 20) {
    return "Use o Application Key ID (25+ caracteres), não o Account ID curto mostrado em 'keyID'. Copie o 'applicationKeyId' completo ao criar a chave S3 no Backblaze.";
  }

  if (!/^\w+$/.test(trimmed)) {
    return "O B2_ACCESS_KEY_ID contém caracteres inválidos ou espaços. Copie e cole exatamente o Application Key ID.";
  }

  return null;
}

function isLikelyAccountId(accessKeyId: string): boolean {
  return /^[0-9a-f]{12}$/i.test(accessKeyId) || accessKeyId.length <= 16;
}

function validateB2Config(config: B2Config): void {
  const invalidKeyMessage = validateB2AccessKeyId(config.accessKeyId);
  if (invalidKeyMessage) {
    throw new StorageConfigError(invalidKeyMessage);
  }

  if (/\s/.test(config.bucketName)) {
    throw new StorageConfigError(
      "B2_BUCKET_NAME deve ser exatamente o nome do bucket (sem espaços). Ex.: copart"
    );
  }

  if (!/backblazeb2\.com/i.test(config.endpoint)) {
    throw new StorageConfigError(
      "B2_ENDPOINT deve ser o endpoint S3 do Backblaze (ex.: s3.us-east-005.backblazeb2.com)"
    );
  }
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

function extractRegionFromEndpoint(endpoint: string): string | null {
  const normalized = endpoint.trim();
  const match = normalized.match(/s3\.([^.]+)\.backblazeb2\.com/i);
  return match?.[1] ?? null;
}

function buildB2PublicUrl(config: B2Config, relKey: string): string {
  const base = ensureTrailingSlash(ensureProtocol(config.endpoint));
  return new URL(`${config.bucketName}/${normalizeKey(relKey)}`, base).toString();
}

function buildAccessKeyHint(accessKeyId: string): string | undefined {
  if (isLikelyAccountId(accessKeyId)) {
    return "Confirme se B2_ACCESS_KEY_ID é o Application Key ID (não o Account ID), sem espaços ou quebras de linha.";
  }

  if (/\s/.test(accessKeyId)) {
    return "Remova espaços ou quebras de linha do B2_ACCESS_KEY_ID.";
  }

  return undefined;
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

type StoragePutOptions = {
  /**
   * Expected payload length (in bytes). When provided, the upload will fail fast if
   * the provided buffer does not match this size, preventing Backblaze from
   * returning "request body was too small" due to mismatched lengths.
   */
  expectedLength?: number;
};

export async function storagePut(
  relKey: string,
  data: Buffer | Uint8Array | string,
  contentType = "application/octet-stream",
  options?: StoragePutOptions
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
    validateB2Config(b2Config);

    const client = buildB2Client(b2Config);
    const buffer = normalizeBuffer(data);
    const contentLength = options?.expectedLength ?? buffer.byteLength;

    if (contentLength <= 0 || buffer.byteLength === 0) {
      throw new StorageConfigError(
        "O arquivo enviado está vazio (0 bytes). Verifique o envio antes de tentar novamente.",
        400
      );
    }

    if (
      typeof options?.expectedLength === "number" &&
      options.expectedLength !== buffer.byteLength
    ) {
      throw new StorageConfigError(
        `Tamanho do arquivo inconsistente: esperado ${options.expectedLength} bytes, recebido ${buffer.byteLength} bytes.`,
        400
      );
    }

    try {
      await client.send(
        new PutObjectCommand({
          Bucket: b2Config.bucketName,
          Key: key,
          Body: buffer,
          ContentType: contentType,
          ContentLength: contentLength,
        })
      );
    } catch (error) {
      const message =
        error instanceof Error && error.message
          ? error.message
          : "Backblaze B2 upload failed";

      const isMalformedKey =
        message.includes("MalformedAccessKeyId") ||
        message.includes("Malformed Access Key Id") ||
        message.includes("InvalidAccessKeyId");
      const isSignatureError =
        message.toLowerCase().includes("signature") ||
        message.includes("SignatureDoesNotMatch");
      const hint = isMalformedKey
        ? buildAccessKeyHint(b2Config.accessKeyId)
        : isSignatureError
          ? `Confirme se B2_ENDPOINT e B2_REGION usam a mesma região (${b2Config.region}).`
          : undefined;

      throw new Error(hint ? `${message}. ${hint}` : message);
    }

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
