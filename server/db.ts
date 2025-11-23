import { eq, desc, like, and, or } from "drizzle-orm";
import { drizzle } from "drizzle-orm/mysql2";
import mysql from "mysql2/promise";
import { 
  InsertUser, users, 
  vehicles, InsertVehicle,
  auctions, InsertAuction,
  bids, InsertBid,
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
  imageUrl: string | null;
  currentBid: number;
  buyNowPrice: number | null;
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

const FALLBACK_VEHICLES: VehicleRecord[] = [
  {
    id: 1,
    lotNumber: "1030820",
    year: 2015,
    make: "VOLKSWAGEN",
    model: "AMAROK",
    description: null,
    imageUrl:
      "https://images.unsplash.com/photo-1582541556083-4e6a3c451ca8?auto=format&fit=crop&w=1200&q=80",
    currentBid: 44390,
    buyNowPrice: null,
    locationId: 1,
    categoryId: 1,
    saleType: "auction",
    status: "active",
    hasWarranty: false,
    hasReport: true,
    createdAt: new Date("2024-01-01T00:00:00Z"),
    updatedAt: new Date("2024-01-01T00:00:00Z"),
    locationName: "Pátio Vila de Cava",
    locationCity: "Pátio Vila de Cava",
    locationState: "RJ",
  },
  {
    id: 2,
    lotNumber: "1030828",
    year: 2018,
    make: "JEEP",
    model: "COMPASS",
    description: null,
    imageUrl:
      "https://images.unsplash.com/photo-1552519507-34a95f24dc86?auto=format&fit=crop&w=1200&q=80",
    currentBid: 34930,
    buyNowPrice: null,
    locationId: 1,
    categoryId: 1,
    saleType: "auction",
    status: "active",
    hasWarranty: false,
    hasReport: true,
    createdAt: new Date("2024-01-02T00:00:00Z"),
    updatedAt: new Date("2024-01-02T00:00:00Z"),
    locationName: "Pátio Vila de Cava",
    locationCity: "Pátio Vila de Cava",
    locationState: "RJ",
  },
  {
    id: 3,
    lotNumber: "1030871",
    year: 2023,
    make: "FERRARI",
    model: "SF90 STRADALE",
    description: null,
    imageUrl:
      "https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1200&q=80",
    currentBid: 34270,
    buyNowPrice: null,
    locationId: 1,
    categoryId: 1,
    saleType: "auction",
    status: "active",
    hasWarranty: false,
    hasReport: true,
    createdAt: new Date("2024-01-03T00:00:00Z"),
    updatedAt: new Date("2024-01-03T00:00:00Z"),
    locationName: "Pátio Vila de Cava",
    locationCity: "Pátio Vila de Cava",
    locationState: "RJ",
  },
  {
    id: 4,
    lotNumber: "1030829",
    year: 2016,
    make: "CHEVROLET",
    model: "S10 CABINE DUPLA",
    description: null,
    imageUrl:
      "https://images.unsplash.com/photo-1542293787938-4d4f0b8f3021?auto=format&fit=crop&w=1200&q=80",
    currentBid: 35480,
    buyNowPrice: null,
    locationId: 1,
    categoryId: 1,
    saleType: "auction",
    status: "active",
    hasWarranty: false,
    hasReport: true,
    createdAt: new Date("2024-01-04T00:00:00Z"),
    updatedAt: new Date("2024-01-04T00:00:00Z"),
    locationName: "Pátio Vila de Cava",
    locationCity: "Pátio Vila de Cava",
    locationState: "RJ",
  },
];

let _db: ReturnType<typeof drizzle> | null = null;
let _pool: mysql.Pool | null = null;
let _dbFailed = false;

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
    console.warn("[Database] Cannot create user: database not available");
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
    console.warn("[Database] Cannot get user: database not available");
    return undefined;
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
    console.warn("[Database] Cannot get user: database not available");
    return undefined;
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
      .filter(vehicle => vehicle.status === "active")
      .sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime());

    return filters?.limit ? results.slice(0, filters.limit) : results;
  }

  const conditions = [eq(vehicles.status, "active")];

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

  return await db
    .select({
      id: vehicles.id,
      lotNumber: vehicles.lotNumber,
      year: vehicles.year,
      make: vehicles.make,
      model: vehicles.model,
      description: vehicles.description,
      imageUrl: vehicles.imageUrl,
      currentBid: vehicles.currentBid,
      buyNowPrice: vehicles.buyNowPrice,
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
    .where(and(...conditions))
    .orderBy(desc(vehicles.createdAt))
    .limit(filters?.limit || 50);
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
      imageUrl: vehicles.imageUrl,
      currentBid: vehicles.currentBid,
      buyNowPrice: vehicles.buyNowPrice,
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

  return result.length > 0 ? result[0] : undefined;
}

export async function createVehicle(vehicle: InsertVehicle) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  const result = await db.insert(vehicles).values(vehicle).returning();
  return result[0];
}

export async function updateVehicle(id: number, updates: Partial<InsertVehicle>) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  await db.update(vehicles).set(updates).where(eq(vehicles.id, id));
}

export async function deleteVehicle(id: number) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  await db.delete(vehicles).where(eq(vehicles.id, id));
}

// Location functions
export async function getLocations() {
  const db = await getDb();
  if (!db) return [];

  return await db.select().from(locations).orderBy(locations.name);
}

export async function createLocation(location: InsertLocation) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  return await db.insert(locations).values(location).returning();
}

// Category functions
export async function getCategories() {
  const db = await getDb();
  if (!db) return [];

  return await db.select().from(categories).orderBy(categories.name);
}

export async function createCategory(category: InsertCategory) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

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
  if (!db) return [];

  return await db.select().from(bids)
    .where(eq(bids.vehicleId, vehicleId))
    .orderBy(desc(bids.amount));
}

export async function createBid(bid: InsertBid) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

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
  if (!db) return [];

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
  if (!db) return [];

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
  if (!db) throw new Error("Database not available");

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
  if (!db) return [];

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
