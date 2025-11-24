import fs from "fs";
import path from "path";
import { eq, desc, like, and, or } from "drizzle-orm";
import { drizzle } from "drizzle-orm/mysql2";
import mysql from "mysql2/promise";
import {
  InsertUser, User, users,
  vehicles, InsertVehicle,
  auctions, InsertAuction,
  bids, InsertBid, Bid,
  locations, InsertLocation,
  categories, InsertCategory,
  partners, InsertPartner,
  favorites, InsertFavorite
} from "../drizzle/schema";
import { ENV } from './_core/env';

type VehicleRecord = {
  id: number;
  lotNumber: string;
  year: number;
  make: string;
  model: string;
  description: string | null;
  documentStatus: string | null;
  categoryDetail: string | null;
  condition: string | null;
  runningCondition: string | null;
  montaType: string | null;
  chassisType: string | null;
  comitente: string | null;
  patio: string | null;
  imageUrl: string | null;
  images: string[];
  currentBid: number;
  buyNowPrice: number | null;
  fipeValue: number | null;
  bidIncrement: number | null;
  locationId: number;
  categoryId: number;
  saleType: "auction" | "direct";
  status: "active" | "sold" | "pending";
  hasWarranty: boolean;
  hasReport: boolean;
  createdAt: Date;
  updatedAt: Date;
  locationName: string | null;
  locationCity: string | null;
  locationState: string | null;
};

type FallbackLocation = {
  id: number;
  name: string;
  city: string;
  state: string;
  address?: string | null;
};

type FallbackCategory = {
  id: number;
  name: string;
  slug: string;
  description?: string | null;
};

type RawVehicleRow = {
  lotNumber?: string;
  year?: string | number;
  make?: string;
  model?: string;
  description?: string;
  imageUrl?: string;
  images?: string[];
  currentBid?: string | number;
  buyNowPrice?: string | number;
  fipeValue?: string | number;
  bidIncrement?: string | number;
  location?: string;
  city?: string;
  state?: string;
  category?: string;
  saleType?: string;
  status?: string;
  hasWarranty?: string | number | boolean;
  hasReport?: string | number | boolean;
};

const RAW_ROW_KEYS: (keyof RawVehicleRow)[] = [
  "lotNumber",
  "year",
  "make",
  "model",
  "description",
  "imageUrl",
  "images",
  "currentBid",
  "buyNowPrice",
  "fipeValue",
  "bidIncrement",
  "location",
  "city",
  "state",
  "category",
  "saleType",
  "status",
  "hasWarranty",
  "hasReport",
];

const HEADER_FIELD_ALIASES: Record<string, keyof RawVehicleRow> = {
  codigo: "lotNumber",
  "ano modelo": "year",
  marca: "make",
  modelo: "model",
  categoria: "category",
  condicao: "description",
  "condição": "description",
  "cond. de funcionamento": "description",
  "cond de funcionamento": "description",
  "patio veiculo": "location",
  "pátio veiculo": "location",
  "pátio veículo": "location",
  "patio veículo": "location",
  "patio do leilao": "location",
  "pátio do leilao": "location",
  "pátio do leilão": "location",
  "patio do leilão": "location",
  lote: "lotNumber",
  "lance atual": "currentBid",
  cidade: "city",
  estado: "state",
  "grade/linha": "category",
  "tabela fipe": "fipeValue",
  fipe: "fipeValue",
  "valor fipe": "fipeValue",
  incremento: "bidIncrement",
  "valor incremento": "bidIncrement",
};

const DEFAULT_FALLBACK_LOCATIONS: FallbackLocation[] = [
  {
    id: 1,
    name: "Pátio Vila de Cava",
    city: "Pátio Vila de Cava",
    state: "RJ",
    address: "Pátio Vila de Cava, RJ",
  },
];

const DEFAULT_FALLBACK_CATEGORIES: FallbackCategory[] = [
  {
    id: 1,
    name: "Automóveis",
    slug: "automoveis",
    description: "Veículos automotores em geral",
  },
];

const DEFAULT_FALLBACK_VEHICLES: VehicleRecord[] = [];

const FALLBACK_DATA_FILE = path.join(process.cwd(), "shared", "data", "fallback-data.json");

const VEHICLE_DATA_FILES = [
  path.join(process.cwd(), "shared", "data", "LotSearchresults_2025 November 16.csv"),
  path.join(process.cwd(), "shared", "data", "LotSearchresults_2025November16.csv"),
  path.join(process.cwd(), "shared", "data", "veiculos.xls"),
];
const FALLBACK_IMAGE_PLACEHOLDER = "https://placehold.co/800x600/1a2332/ffffff/png?text=Copart+Brasil";

let FALLBACK_LOCATIONS: FallbackLocation[] = [];
let FALLBACK_CATEGORIES: FallbackCategory[] = [];
let FALLBACK_VEHICLES: VehicleRecord[] = [];
let fallbackVehicleId = 1;

function slugify(value: string) {
  return value
    .toLowerCase()
    .normalize("NFD")
    .replace(/[^\w\s-]/g, "")
    .replace(/\s+/g, "-")
    .replace(/-+/g, "-")
    .replace(/^-+|-+$/g, "") || "categoria";
}

function toNumber(value: string | number | undefined, fallback = 0) {
  if (value === undefined || value === null) return fallback;
  if (typeof value === "number" && Number.isFinite(value)) return value;

  const parsed = Number(String(value).replace(/[^0-9,.-]/g, "").replace(",", "."));
  return Number.isFinite(parsed) ? parsed : fallback;
}

function toBoolean(value: string | number | boolean | undefined, fallback = false) {
  if (typeof value === "boolean") return value;
  if (typeof value === "number") return value > 0;

  if (!value) return fallback;
  const normalized = String(value).toLowerCase();
  return ["true", "1", "sim", "yes"].includes(normalized);
}

function parseImagesField(images: string | string[] | null | undefined, imageUrl?: string | null) {
  if (Array.isArray(images)) {
    return images.filter(Boolean);
  }

  if (typeof images === "string" && images.trim().length > 0) {
    try {
      const parsed = JSON.parse(images);
      if (Array.isArray(parsed)) {
        return parsed.filter(Boolean);
      }
    } catch (_) {
      // Not JSON, try to split by common delimiters
      return images
        .split(/[,;\n]/)
        .map(value => value.trim())
        .filter(Boolean);
    }
  }

  return imageUrl ? [imageUrl] : [];
}

function normalizeHeaderName(header: string) {
  return header
    .replace(/^\ufeff/, "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, " ")
    .trim();
}

function mapHeaderToField(header: string): keyof RawVehicleRow | undefined {
  const normalized = normalizeHeaderName(header);
  if (HEADER_FIELD_ALIASES[normalized]) {
    return HEADER_FIELD_ALIASES[normalized];
  }

  if (RAW_ROW_KEYS.includes(normalized as keyof RawVehicleRow)) {
    return normalized as keyof RawVehicleRow;
  }

  return undefined;
}

function parseLocationParts(locationName: string, row: RawVehicleRow) {
  const rawCity = row.city?.toString().trim();
  const rawState = row.state?.toString().trim();

  if (rawCity && rawState) {
    return { city: rawCity, state: rawState };
  }

  const match = locationName.match(/(.+?)[\s-–]+([A-Z]{2})$/);
  if (match) {
    return { city: match[1].trim(), state: match[2].trim() };
  }

  return {
    city: rawCity || locationName,
    state: rawState || "SP",
  };
}

function normalizeSaleType(value?: string): "auction" | "direct" {
  if (!value) return "auction";
  return value.toLowerCase().includes("direct") ? "direct" : "auction";
}

function normalizeStatus(value?: string): "active" | "sold" | "pending" {
  if (!value) return "active";
  const normalized = value.toLowerCase();
  if (normalized.includes("sold") || normalized.includes("vend")) return "sold";
  if (normalized.includes("pend")) return "pending";
  return "active";
}

function parseVehicleSpreadsheet(): RawVehicleRow[] {
  const vehicleFile = VEHICLE_DATA_FILES.find(filePath => fs.existsSync(filePath));
  if (!vehicleFile) {
    return [];
  }

  const raw = fs.readFileSync(vehicleFile, "utf-8");
  const lines = raw.split(/\r?\n/).filter(line => line.trim().length > 0);

  if (lines.length <= 1) return [];

  const delimiter = lines[0].includes(";")
    ? ";"
    : lines[0].includes(",")
      ? ","
      : "\t";
  const headers = lines[0].split(delimiter).map(header => normalizeHeaderName(header));

  return lines.slice(1).map(line => {
    const values = line.split(delimiter).map(value => value.trim());
    const row: Record<string, string> = {};

    headers.forEach((header, index) => {
      const mappedHeader = mapHeaderToField(header);
      if (!mappedHeader) return;

      const value = values[index] ?? "";

      if (mappedHeader === "description" && row[mappedHeader]) {
        row[mappedHeader] = `${row[mappedHeader]} - ${value}`;
      } else {
        row[mappedHeader] = value;
      }
    });

    return row as RawVehicleRow;
  });
}

function resetToDefaultFallbackData() {
  FALLBACK_LOCATIONS = DEFAULT_FALLBACK_LOCATIONS.map(location => ({ ...location }));
  FALLBACK_CATEGORIES = DEFAULT_FALLBACK_CATEGORIES.map(category => ({ ...category }));
  FALLBACK_VEHICLES = DEFAULT_FALLBACK_VEHICLES.map(vehicle => ({
    ...vehicle,
    images: [...vehicle.images],
  }));
  fallbackVehicleId = FALLBACK_VEHICLES.length + 1;
}

function loadFallbackDataFromFile() {
  if (!fs.existsSync(FALLBACK_DATA_FILE)) return false;

  try {
    const raw = fs.readFileSync(FALLBACK_DATA_FILE, "utf-8");
    const data = JSON.parse(raw) as {
      locations?: FallbackLocation[];
      categories?: FallbackCategory[];
      vehicles?: (VehicleRecord & { createdAt: string; updatedAt: string })[];
      fallbackVehicleId?: number;
    };

    if (!data.vehicles?.length) return false;

    FALLBACK_LOCATIONS = data.locations?.length
      ? data.locations.map(location => ({ ...location }))
      : DEFAULT_FALLBACK_LOCATIONS.map(location => ({ ...location }));
    FALLBACK_CATEGORIES = data.categories?.length
      ? data.categories.map(category => ({ ...category }))
      : DEFAULT_FALLBACK_CATEGORIES.map(category => ({ ...category }));
    FALLBACK_VEHICLES = data.vehicles.map(vehicle => ({
      ...vehicle,
      createdAt: new Date(vehicle.createdAt),
      updatedAt: new Date(vehicle.updatedAt),
    }));
    fallbackVehicleId = data.fallbackVehicleId ?? FALLBACK_VEHICLES.length + 1;
    return true;
  } catch (error) {
    console.warn("[Database] Failed to load fallback data file:", error);
    return false;
  }
}

function persistFallbackData() {
  try {
    fs.mkdirSync(path.dirname(FALLBACK_DATA_FILE), { recursive: true });
    const data = {
      locations: FALLBACK_LOCATIONS,
      categories: FALLBACK_CATEGORIES,
      vehicles: FALLBACK_VEHICLES.map(vehicle => ({
        ...vehicle,
        createdAt: vehicle.createdAt.toISOString(),
        updatedAt: vehicle.updatedAt.toISOString(),
      })),
      fallbackVehicleId,
    };

    fs.writeFileSync(FALLBACK_DATA_FILE, JSON.stringify(data, null, 2), "utf-8");
  } catch (error) {
    console.warn("[Database] Failed to persist fallback data:", error);
  }
}

function loadFallbackDataFromSpreadsheet() {
  const rows = parseVehicleSpreadsheet();
  if (rows.length === 0) return false;

  const locationMap = new Map<string, FallbackLocation>();
  const categoryMap = new Map<string, FallbackCategory>();
  const vehicles: VehicleRecord[] = [];

  let vehicleId = 1;

  rows.forEach(row => {
    const categoryName = row.category?.toString().trim() || "Automóveis";
    if (!categoryMap.has(categoryName)) {
      categoryMap.set(categoryName, {
        id: categoryMap.size + 1,
        name: categoryName,
        slug: slugify(categoryName),
        description: null,
      });
    }

    const locationName =
      row.location?.toString().trim() ||
      [row.city, row.state].filter(Boolean).map(value => value?.toString().trim()).join(" - ") ||
      "Local não informado";
    const locationParts = parseLocationParts(locationName, row);
    if (!locationMap.has(locationName)) {
      locationMap.set(locationName, {
        id: locationMap.size + 1,
        name: locationName,
        city: locationParts.city,
        state: locationParts.state,
        address: locationName,
      });
    }

    const location = locationMap.get(locationName)!;
    const category = categoryMap.get(categoryName)!;
    const now = new Date();

    const fallbackImage = row.imageUrl?.toString().trim() || FALLBACK_IMAGE_PLACEHOLDER;

    vehicles.push({
      id: vehicleId++,
      lotNumber: row.lotNumber?.toString().trim() || `L${100000 + vehicleId}`,
      year: toNumber(row.year, now.getFullYear()),
      make: row.make?.toString().trim() || "COPART",
      model: row.model?.toString().trim() || "Veículo",
      description: row.description?.toString().trim() || null,
      documentStatus: null,
      categoryDetail: null,
      condition: null,
      runningCondition: null,
      montaType: null,
      chassisType: null,
      comitente: null,
      patio: null,
      imageUrl: fallbackImage,
      images: row.images?.length ? row.images : parseImagesField(row.imageUrl, fallbackImage),
      currentBid: toNumber(row.currentBid),
      buyNowPrice: row.buyNowPrice ? toNumber(row.buyNowPrice) : null,
      fipeValue: row.fipeValue ? toNumber(row.fipeValue) : null,
      bidIncrement: row.bidIncrement ? toNumber(row.bidIncrement) : null,
      locationId: location.id,
      categoryId: category.id,
      saleType: normalizeSaleType(row.saleType?.toString()),
      status: normalizeStatus(row.status?.toString()),
      hasWarranty: toBoolean(row.hasWarranty),
      hasReport: toBoolean(row.hasReport, true),
      createdAt: now,
      updatedAt: now,
      locationName: location.name,
      locationCity: location.city,
      locationState: location.state,
    });
  });

  FALLBACK_LOCATIONS = Array.from(locationMap.values());
  FALLBACK_CATEGORIES = Array.from(categoryMap.values());
  FALLBACK_VEHICLES = vehicles;
  fallbackVehicleId = vehicles.length + 1;

  return true;
}

function ensureFallbackDataLoaded() {
  const shouldLoadSampleVehicles = process.env.LOAD_SAMPLE_VEHICLES === "true";

  if (loadFallbackDataFromFile()) {
    return;
  }

  if (shouldLoadSampleVehicles && loadFallbackDataFromSpreadsheet()) {
    return;
  }

  resetToDefaultFallbackData();
}

ensureFallbackDataLoaded();

const fallbackBids: Bid[] = [];
let fallbackBidId = 1;

let _db: ReturnType<typeof drizzle> | null = null;
let _pool: mysql.Pool | null = null;
let _dbFailed = false;

const fallbackUsers: User[] = [];
let fallbackUserId = 1;

export function ensureFallbackUser(user: InsertUser): User {
  const existing = getFallbackUserByUsername(user.username);

  if (existing) {
    return existing;
  }

  const created = createFallbackUser(user);
  fallbackUsers.push(created);
  return created;
}

function createFallbackUser(user: InsertUser): User {
  const now = new Date();

  return {
    id: fallbackUserId++,
    username: user.username,
    password: user.password ?? "",
    name: user.name ?? user.username,
    email: user.email ?? null,
    role: user.role ?? "user",
    createdAt: user.createdAt ?? now,
    updatedAt: user.updatedAt ?? now,
    lastSignedIn: user.lastSignedIn ?? now,
  };
}

function getFallbackUserByUsername(username: string) {
  return fallbackUsers.find(user => user.username === username);
}

function getFallbackUserById(id: number) {
  return fallbackUsers.find(user => user.id === id);
}

function getFallbackVehicleById(id: number) {
  return FALLBACK_VEHICLES.find(vehicle => vehicle.id === id);
}

function applyLocationMetadata(record: VehicleRecord, locationId: number) {
  const location = FALLBACK_LOCATIONS.find(loc => loc.id === locationId);

  record.locationId = locationId;
  record.locationName = location?.name ?? null;
  record.locationCity = location?.city ?? null;
  record.locationState = location?.state ?? null;
}

function createFallbackVehicle(vehicle: InsertVehicle): VehicleRecord {
  const now = new Date();
  const locationId = vehicle.locationId ?? FALLBACK_LOCATIONS[0]?.id ?? 1;
  const categoryId = vehicle.categoryId ?? FALLBACK_CATEGORIES[0]?.id ?? 1;

  const record: VehicleRecord = {
    id: fallbackVehicleId++,
    lotNumber: vehicle.lotNumber,
    year: vehicle.year,
    make: vehicle.make,
    model: vehicle.model,
    description: vehicle.description ?? null,
    documentStatus: (vehicle as VehicleRecord).documentStatus ?? null,
    categoryDetail: (vehicle as VehicleRecord).categoryDetail ?? null,
    condition: (vehicle as VehicleRecord).condition ?? null,
    runningCondition: (vehicle as VehicleRecord).runningCondition ?? null,
    montaType: (vehicle as VehicleRecord).montaType ?? null,
    chassisType: (vehicle as VehicleRecord).chassisType ?? null,
    comitente: (vehicle as VehicleRecord).comitente ?? null,
    patio: (vehicle as VehicleRecord).patio ?? null,
    imageUrl: vehicle.imageUrl ?? null,
    images: parseImagesField((vehicle as any).images, vehicle.imageUrl),
    currentBid: vehicle.currentBid ?? 0,
    buyNowPrice: vehicle.buyNowPrice ?? null,
    fipeValue: (vehicle as VehicleRecord).fipeValue ?? null,
    bidIncrement: (vehicle as VehicleRecord).bidIncrement ?? null,
    locationId,
    categoryId,
    saleType: vehicle.saleType ?? "auction",
    status: (vehicle as VehicleRecord).status ?? "active",
    hasWarranty: vehicle.hasWarranty ?? false,
    hasReport: vehicle.hasReport ?? false,
    createdAt: (vehicle as VehicleRecord).createdAt ?? now,
    updatedAt: (vehicle as VehicleRecord).updatedAt ?? now,
    locationName: null,
    locationCity: null,
    locationState: null,
  };

  if (!record.imageUrl && record.images.length > 0) {
    record.imageUrl = record.images[0] ?? null;
  }

  applyLocationMetadata(record, locationId);

  FALLBACK_VEHICLES.push(record);
  persistFallbackData();
  return record;
}

function createFallbackBid(bid: InsertBid): Bid {
  const createdAt = bid.createdAt ?? new Date();
  const record: Bid = {
    id: fallbackBidId++,
    ...bid,
    createdAt,
  };

  fallbackBids.push(record);

  const vehicle = getFallbackVehicleById(bid.vehicleId);
  if (vehicle && bid.amount > vehicle.currentBid) {
    vehicle.currentBid = bid.amount;
    vehicle.updatedAt = createdAt;
  }

  return record;
}

export async function getDb() {
  if (_db || _dbFailed || !ENV.databaseUrl) {
    return _db;
  }

  try {
    _pool = mysql.createPool({ uri: ENV.databaseUrl });
    // Validate the connection before using it to avoid runtime query errors
    await _pool.query("SELECT 1");
    _db = drizzle(_pool);
  } catch (error) {
    console.warn("[Database] Failed to connect:", error);
    _db = null;
    _dbFailed = true;
  }

  return _db;
}

// User functions
export async function createUser(user: InsertUser): Promise<void> {
  const db = await getDb();
  if (!db) {
    const existing = getFallbackUserByUsername(user.username);

    if (existing) {
      console.warn(`[Database] Fallback user already exists: ${user.username}`);
      return;
    }

    fallbackUsers.push(createFallbackUser(user));
    return;
  }

  try {
    await db.insert(users).values(user);
  } catch (error) {
    console.error("[Database] Failed to create user:", error);
    throw error;
  }
}

export async function getUserByUsername(username: string) {
  const db = await getDb();
  if (!db) {
    return getFallbackUserByUsername(username);
  }

  try {
    const result = await db.select().from(users).where(eq(users.username, username)).limit(1);
    return result.length > 0 ? result[0] : undefined;
  } catch (error) {
    console.warn("[Database] Failed to fetch user by username:", error);
    return undefined;
  }
}

export async function getUserById(id: number) {
  const db = await getDb();
  if (!db) {
    return getFallbackUserById(id);
  }

  try {
    const result = await db.select().from(users).where(eq(users.id, id)).limit(1);
    return result.length > 0 ? result[0] : undefined;
  } catch (error) {
    console.warn("[Database] Failed to fetch user by id:", error);
    return undefined;
  }
}

// Update user with arbitrary fields
export async function updateUser(userId: number, updates: Partial<InsertUser>) {
  const db = await getDb();

  if (!db) {
    console.warn("[Database] Cannot update user: database not available");
    return;
  }

  await db.update(users).set(updates).where(eq(users.id, userId));
}

// Vehicle functions
export async function getVehicles(filters?: {
  search?: string;
  saleType?: "auction" | "direct";
  categoryId?: number;
  limit?: number;
}) {
  const db = await getDb();
  if (!db) {
    let results = [...FALLBACK_VEHICLES];

    if (filters?.search) {
      const term = filters.search.toLowerCase();
      results = results.filter(vehicle =>
        [vehicle.make, vehicle.model, vehicle.description, vehicle.lotNumber]
          .filter(Boolean)
          .some(value => value?.toLowerCase().includes(term))
      );
    }

    if (filters?.saleType) {
      results = results.filter(vehicle => vehicle.saleType === filters.saleType);
    }

    if (filters?.categoryId) {
      results = results.filter(vehicle => vehicle.categoryId === filters.categoryId);
    }

    results = results
      .sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime());

    return filters?.limit ? results.slice(0, filters.limit) : results;
  }

  const conditions = [] as any[];

  if (filters?.search) {
    conditions.push(
      or(
        like(vehicles.make, `%${filters.search}%`),
        like(vehicles.model, `%${filters.search}%`),
        like(vehicles.description, `%${filters.search}%`),
        like(vehicles.lotNumber, `%${filters.search}%`)
      )!
    );
  }

  if (filters?.saleType) {
    conditions.push(eq(vehicles.saleType, filters.saleType));
  }

  if (filters?.categoryId) {
    conditions.push(eq(vehicles.categoryId, filters.categoryId));
  }

  const whereClause = conditions.length ? and(...conditions) : undefined;

  let query = db
    .select({
      id: vehicles.id,
      lotNumber: vehicles.lotNumber,
      year: vehicles.year,
      make: vehicles.make,
      model: vehicles.model,
      description: vehicles.description,
      documentStatus: vehicles.documentStatus,
      categoryDetail: vehicles.categoryDetail,
      condition: vehicles.condition,
      runningCondition: vehicles.runningCondition,
      montaType: vehicles.montaType,
      chassisType: vehicles.chassisType,
      comitente: vehicles.comitente,
      patio: vehicles.patio,
      imageUrl: vehicles.imageUrl,
      images: vehicles.images,
      currentBid: vehicles.currentBid,
      buyNowPrice: vehicles.buyNowPrice,
      fipeValue: vehicles.fipeValue,
      bidIncrement: vehicles.bidIncrement,
      locationId: vehicles.locationId,
      categoryId: vehicles.categoryId,
      saleType: vehicles.saleType,
      status: vehicles.status,
      hasWarranty: vehicles.hasWarranty,
      hasReport: vehicles.hasReport,
      createdAt: vehicles.createdAt,
      updatedAt: vehicles.updatedAt,
      locationName: locations.name,
      locationCity: locations.city,
      locationState: locations.state,
    })
    .from(vehicles)
    .leftJoin(locations, eq(vehicles.locationId, locations.id));

  if (whereClause) {
    query = query.where(whereClause);
  }

  const results = await query
    .orderBy(desc(vehicles.createdAt))
    .limit(filters?.limit || 50);

  return results.map(result => ({
    ...result,
    images: parseImagesField(result.images, result.imageUrl),
    imageUrl: result.imageUrl ?? parseImagesField(result.images, result.imageUrl)[0] ?? null,
  }));
}

export async function getVehicleById(id: number) {
  const db = await getDb();
  if (!db) {
    return FALLBACK_VEHICLES.find(vehicle => vehicle.id === id);
  }

  const result = await db
    .select({
      id: vehicles.id,
      lotNumber: vehicles.lotNumber,
      year: vehicles.year,
      make: vehicles.make,
      model: vehicles.model,
      description: vehicles.description,
      documentStatus: vehicles.documentStatus,
      categoryDetail: vehicles.categoryDetail,
      condition: vehicles.condition,
      runningCondition: vehicles.runningCondition,
      montaType: vehicles.montaType,
      chassisType: vehicles.chassisType,
      comitente: vehicles.comitente,
      patio: vehicles.patio,
      imageUrl: vehicles.imageUrl,
      images: vehicles.images,
      currentBid: vehicles.currentBid,
      buyNowPrice: vehicles.buyNowPrice,
      fipeValue: vehicles.fipeValue,
      bidIncrement: vehicles.bidIncrement,
      locationId: vehicles.locationId,
      categoryId: vehicles.categoryId,
      saleType: vehicles.saleType,
      status: vehicles.status,
      hasWarranty: vehicles.hasWarranty,
      hasReport: vehicles.hasReport,
      createdAt: vehicles.createdAt,
      updatedAt: vehicles.updatedAt,
      locationName: locations.name,
      locationCity: locations.city,
      locationState: locations.state,
    })
    .from(vehicles)
    .leftJoin(locations, eq(vehicles.locationId, locations.id))
    .where(eq(vehicles.id, id))
    .limit(1);

  if (result.length === 0) return undefined;

  const vehicle = result[0];
  const images = parseImagesField(vehicle.images, vehicle.imageUrl);

  return {
    ...vehicle,
    images,
    imageUrl: vehicle.imageUrl ?? images[0] ?? null,
  };
}

export async function createVehicle(vehicle: InsertVehicle) {
  const db = await getDb();
  if (!db) {
    return createFallbackVehicle(vehicle);
  }

  const result = await db.insert(vehicles).values(vehicle);
  const insertId = (result as any)?.insertId as number | undefined;

  if (insertId) {
    return await getVehicleById(insertId);
  }

  return undefined;
}

export async function updateVehicle(id: number, updates: Partial<InsertVehicle>) {
  const db = await getDb();
  if (!db) {
    const vehicle = getFallbackVehicleById(id);

    if (!vehicle) {
      throw new Error("Database not available");
    }

    const definedUpdates = Object.fromEntries(
      Object.entries(updates).filter(([, value]) => value !== undefined)
    );

    if (definedUpdates.locationId !== undefined) {
      applyLocationMetadata(vehicle, definedUpdates.locationId as number);
    }

    if (definedUpdates.categoryId !== undefined) {
      vehicle.categoryId = definedUpdates.categoryId as number;
    }

    if (definedUpdates.images !== undefined) {
      vehicle.images = parseImagesField(definedUpdates.images as string, vehicle.imageUrl);
      if (!vehicle.imageUrl && vehicle.images.length > 0) {
        vehicle.imageUrl = vehicle.images[0];
      }
      delete (definedUpdates as any).images;
    }

    Object.assign(vehicle, definedUpdates, { updatedAt: new Date() });
    persistFallbackData();
    return;
  }

  await db.update(vehicles).set(updates).where(eq(vehicles.id, id));
}

export async function deleteVehicle(id: number) {
  const db = await getDb();
  if (!db) {
    const index = FALLBACK_VEHICLES.findIndex(vehicle => vehicle.id === id);

    if (index === -1) {
      throw new Error("Database not available");
    }

    FALLBACK_VEHICLES.splice(index, 1);
    persistFallbackData();
    return;
  }

  await db.delete(vehicles).where(eq(vehicles.id, id));
}

// Location functions
export async function getLocations() {
  const db = await getDb();
  if (!db) return FALLBACK_LOCATIONS;

  return await db.select().from(locations).orderBy(locations.name);
}

export async function createLocation(location: InsertLocation) {
  const db = await getDb();
  if (!db) {
    const record: FallbackLocation = {
      id: FALLBACK_LOCATIONS.length + 1,
      name: location.name,
      city: location.city,
      state: location.state,
      address: location.address ?? null,
    };

    FALLBACK_LOCATIONS.push(record);
    persistFallbackData();
    return record;
  }

  return await db.insert(locations).values(location).returning();
}

// Category functions
export async function getCategories() {
  const db = await getDb();
  if (!db) return FALLBACK_CATEGORIES;

  return await db.select().from(categories).orderBy(categories.name);
}

export async function createCategory(category: InsertCategory) {
  const db = await getDb();
  if (!db) {
    const record: FallbackCategory = {
      id: FALLBACK_CATEGORIES.length + 1,
      name: category.name,
      slug: category.slug,
      description: category.description ?? null,
    };

    FALLBACK_CATEGORIES.push(record);
    persistFallbackData();
    return record;
  }

  return await db.insert(categories).values(category).returning();
}

// Auction functions
export async function getAuctions(status?: "scheduled" | "live" | "ended") {
  const db = await getDb();
  if (!db) return [];

  let query = db.select().from(auctions).$dynamic();

  if (status) {
    query = query.where(eq(auctions.status, status));
  }

  return await query.orderBy(desc(auctions.startDate));
}

export async function createAuction(auction: InsertAuction) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  return await db.insert(auctions).values(auction).returning();
}

// Bid functions
export async function getBidsByVehicle(vehicleId: number) {
  const db = await getDb();
  if (!db) {
    return fallbackBids
      .filter(bid => bid.vehicleId === vehicleId)
      .sort((a, b) => b.amount - a.amount || b.createdAt.getTime() - a.createdAt.getTime());
  }

  return await db.select().from(bids)
    .where(eq(bids.vehicleId, vehicleId))
    .orderBy(desc(bids.amount));
}

export async function createBid(bid: InsertBid) {
  const db = await getDb();
  if (!db) {
    return createFallbackBid(bid);
  }

  const result = await db.insert(bids).values(bid).returning();

  // Update vehicle current bid
  const highestBid = await db.select().from(bids)
    .where(eq(bids.vehicleId, bid.vehicleId))
    .orderBy(desc(bids.amount))
    .limit(1);

  if (highestBid.length > 0) {
    await updateVehicle(bid.vehicleId, { currentBid: highestBid[0]!.amount });
  }

  return result[0];
}

// Partner functions
export async function getPartners() {
  const db = await getDb();
  if (!db) return [];

  return await db.select().from(partners).orderBy(partners.displayOrder);
}

export async function createPartner(partner: InsertPartner) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  return await db.insert(partners).values(partner).returning();
}

// Get all users (for admin)
export async function getAllUsers() {
  const db = await getDb();
  if (!db) {
    return [...fallbackUsers].sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime());
  }

  return await db.select().from(users).orderBy(desc(users.createdAt));
}

// Favorite functions
export async function getUserFavorites(userId: number) {
  const db = await getDb();
  if (!db) return [];

  const result = await db
    .select({
      favorite: favorites,
      vehicle: vehicles,
    })
    .from(favorites)
    .innerJoin(vehicles, eq(favorites.vehicleId, vehicles.id))
    .where(eq(favorites.userId, userId))
    .orderBy(desc(favorites.createdAt));

  return result.map(r => ({
    ...r.vehicle,
    favoriteId: r.favorite.id,
    favoritedAt: r.favorite.createdAt,
  }));
}

export async function addFavorite(userId: number, vehicleId: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  try {
    const result = await db.insert(favorites).values({ userId, vehicleId }).returning();
    return result[0];
  } catch (error) {
    // If duplicate, ignore
    console.warn("[Database] Favorite already exists or error:", error);
    throw error;
  }
}

export async function removeFavorite(userId: number, vehicleId: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  await db.delete(favorites).where(
    and(
      eq(favorites.userId, userId),
      eq(favorites.vehicleId, vehicleId)
    )
  );
}

export async function isFavorite(userId: number, vehicleId: number): Promise<boolean> {
  const db = await getDb();
  if (!db) return false;

  const result = await db
    .select()
    .from(favorites)
    .where(
      and(
        eq(favorites.userId, userId),
        eq(favorites.vehicleId, vehicleId)
      )
    )
    .limit(1);

  return result.length > 0;
}

// Get user bids
export async function getUserBids(userId: number) {
  const db = await getDb();
  if (!db) {
    return fallbackBids
      .filter(bid => bid.userId === userId)
      .sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime())
      .map(bid => ({
        ...bid,
        vehicle: getFallbackVehicleById(bid.vehicleId),
      }));
  }

  const result = await db
    .select({
      bid: bids,
      vehicle: vehicles,
    })
    .from(bids)
    .innerJoin(vehicles, eq(bids.vehicleId, vehicles.id))
    .where(eq(bids.userId, userId))
    .orderBy(desc(bids.createdAt));

  return result.map(r => ({
    ...r.bid,
    vehicle: r.vehicle,
  }));
}

// Update user profile
export async function updateUserProfile(userId: number, updates: { name?: string; email?: string }) {
  const db = await getDb();
  if (!db) {
    const fallbackUser = getFallbackUserById(userId);

    if (!fallbackUser) {
      throw new Error("Database not available");
    }

    if (updates.name !== undefined) {
      fallbackUser.name = updates.name;
    }

    if (updates.email !== undefined) {
      fallbackUser.email = updates.email;
    }

    fallbackUser.updatedAt = new Date();
    return;
  }

  const updateData: Partial<InsertUser> = {};
  
  if (updates.name !== undefined) {
    updateData.name = updates.name;
  }
  
  if (updates.email !== undefined) {
    updateData.email = updates.email;
  }

  await db.update(users).set(updateData).where(eq(users.id, userId));
}

// Get all bids (for admin)
export async function getAllBids() {
  const db = await getDb();
  if (!db) {
    return fallbackBids
      .sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime())
      .map(bid => ({
        ...bid,
        vehicle: getFallbackVehicleById(bid.vehicleId),
      }));
  }

  const result = await db
    .select({
      bid: bids,
      vehicle: vehicles,
    })
    .from(bids)
    .innerJoin(vehicles, eq(bids.vehicleId, vehicles.id))
    .orderBy(desc(bids.createdAt));

  return result.map(r => ({
    ...r.bid,
    vehicle: r.vehicle,
  }));
}
