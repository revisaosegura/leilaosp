// Preconfigured storage helpers for Manus WebDev templates
// Uses the Biz-provided storage proxy (Authorization: Bearer <token>)

import fs from "fs/promises";
import path from "path";

import { ENV } from "./_core/env";
import { uploadToCloudinary } from "./cloudinary";

type StorageConfig = { baseUrl: string; apiKey: string };

const UPLOADS_DIR = path.join(process.cwd(), "public/uploads");

function getStorageConfig(): StorageConfig | null {
  const baseUrl = ENV.forgeApiUrl;
  const apiKey = ENV.forgeApiKey;

  if (!baseUrl || !apiKey) {
    return null;
  }

  return { baseUrl: baseUrl.replace(/\/+$/, ""), apiKey };
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

async function saveLocally(key: string, data: Buffer | Uint8Array | string) {
  const targetPath = path.join(UPLOADS_DIR, normalizeKey(key));
  await fs.mkdir(path.dirname(targetPath), { recursive: true });
  const buffer =
    typeof data === "string"
      ? Buffer.from(data)
      : Buffer.isBuffer(data)
        ? data
        : Buffer.from(data);
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

  // Try Cloudinary first
  if (ENV.cloudinaryCloudName && ENV.cloudinaryApiKey && ENV.cloudinaryApiSecret) {
    try {
      const buffer =
        typeof data === "string"
          ? Buffer.from(data)
          : Buffer.isBuffer(data)
            ? data
            : Buffer.from(data);
      
      // Extract folder from key (e.g. "vehicles/image.jpg" -> "vehicles")
      // If key has no folder (e.g. "image.jpg"), use "default" or empty
      const folder = path.dirname(key);
      const targetFolder = folder === "." ? "uploads" : folder;

      const { url } = await uploadToCloudinary(buffer, targetFolder);
      return { key, url };
    } catch (error) {
      console.error("Cloudinary upload failed, falling back to other storage:", error);
      // Fall through to other storage methods if Cloudinary fails? 
      // Or throw? Usually if configured, we want it to work. 
      // But for robustness, maybe fall back? 
      // Let's throw for now so the user knows it failed.
      throw error;
    }
  }

  const config = getStorageConfig();

  if (!config) {
    const url = await saveLocally(key, data);
    return { key, url };
  }

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

export async function storageGet(relKey: string): Promise<{ key: string; url: string; }> {
  const key = normalizeKey(relKey);
  const config = getStorageConfig();

  if (!config) {
    return { key, url: `/uploads/${key}` };
  }

  const { baseUrl, apiKey } = config;
  return { key, url: await buildDownloadUrl(baseUrl, key, apiKey) };
}
