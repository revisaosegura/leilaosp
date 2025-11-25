import type { SyntheticEvent } from "react";

export const VEHICLE_PLACEHOLDER_IMAGE = "/vehicle-placeholder.svg";

export function resolveVehiclePrimaryImage(
  imageUrl?: string | null,
  images?: string[] | null
) {
  const primary = images?.find(Boolean) || imageUrl;
  return primary?.trim() || VEHICLE_PLACEHOLDER_IMAGE;
}

export function ensureVehicleImages(
  images?: string[] | null,
  imageUrl?: string | null
) {
  const resolved = images?.filter(Boolean);
  if (resolved?.length) return resolved;

  const candidate = imageUrl?.trim();
  if (candidate) return [candidate];

  return [VEHICLE_PLACEHOLDER_IMAGE];
}

export function handleVehicleImageError(
  event: SyntheticEvent<HTMLImageElement, Event>
) {
  const target = event.currentTarget;
  if (target.dataset.fallbackApplied === "true") return;

  target.dataset.fallbackApplied = "true";
  target.src = VEHICLE_PLACEHOLDER_IMAGE;
  target.classList.add("bg-gray-100", "object-contain");
}
