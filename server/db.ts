import { eq, desc, like, and, or, sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/mysql2";
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

let _db: ReturnType<typeof drizzle> | null = null;

export async function getDb() {
  if (!_db && process.env.DATABASE_URL) {
    try {
      _db = drizzle(process.env.DATABASE_URL);
    } catch (error) {
      console.warn("[Database] Failed to connect:", error);
      _db = null;
    }
  }
  return _db;
}

// User functions
export async function upsertUser(user: InsertUser): Promise<void> {
  if (!user.openId) {
    throw new Error("User openId is required for upsert");
  }

  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot upsert user: database not available");
    return;
  }

  try {
    const values: InsertUser = {
      openId: user.openId,
    };
    const updateSet: Record<string, unknown> = {};

    const textFields = ["name", "email", "loginMethod"] as const;
    type TextField = (typeof textFields)[number];

    const assignNullable = (field: TextField) => {
      const value = user[field];
      if (value === undefined) return;
      const normalized = value ?? null;
      values[field] = normalized;
      updateSet[field] = normalized;
    };

    textFields.forEach(assignNullable);

    if (user.lastSignedIn !== undefined) {
      values.lastSignedIn = user.lastSignedIn;
      updateSet.lastSignedIn = user.lastSignedIn;
    }
    if (user.role !== undefined) {
      values.role = user.role;
      updateSet.role = user.role;
    } else if (user.openId === ENV.ownerOpenId) {
      values.role = 'admin';
      updateSet.role = 'admin';
    }

    if (!values.lastSignedIn) {
      values.lastSignedIn = new Date();
    }

    if (Object.keys(updateSet).length === 0) {
      updateSet.lastSignedIn = new Date();
    }

    await db.insert(users).values(values).onDuplicateKeyUpdate({
      set: updateSet,
    });
  } catch (error) {
    console.error("[Database] Failed to upsert user:", error);
    throw error;
  }
}

export async function getUserByOpenId(openId: string) {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot get user: database not available");
    return undefined;
  }

  const result = await db.select().from(users).where(eq(users.openId, openId)).limit(1);
  return result.length > 0 ? result[0] : undefined;
}

// Vehicle functions
export async function getVehicles(filters?: {
  search?: string;
  saleType?: "auction" | "direct";
  categoryId?: number;
  limit?: number;
}) {
  const db = await getDb();
  if (!db) return [];

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

  const result = await db
    .select()
    .from(vehicles)
    .where(and(...conditions))
    .orderBy(desc(vehicles.createdAt))
    .limit(filters?.limit || 50);

  return result;
}

export async function getVehicleById(id: number) {
  const db = await getDb();
  if (!db) return undefined;

  const result = await db.select().from(vehicles).where(eq(vehicles.id, id)).limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function createVehicle(vehicle: InsertVehicle) {
  const db = await getDb();
  if (!db) throw new Error("Database not available");

  const result = await db.insert(vehicles).values(vehicle);
  return result;
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

  return await db.insert(locations).values(location);
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

  return await db.insert(categories).values(category);
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

  return await db.insert(auctions).values(auction);
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

  const result = await db.insert(bids).values(bid);
  
  // Update vehicle current bid
  const highestBid = await db.select().from(bids)
    .where(eq(bids.vehicleId, bid.vehicleId))
    .orderBy(desc(bids.amount))
    .limit(1);

  if (highestBid.length > 0) {
    await updateVehicle(bid.vehicleId, { currentBid: highestBid[0]!.amount });
  }

  return result;
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

  return await db.insert(partners).values(partner);
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
    const result = await db.insert(favorites).values({ userId, vehicleId });
    return result;
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
