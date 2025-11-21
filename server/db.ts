import { eq, desc, like, and, or, sql } from "drizzle-orm";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
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
let _client: ReturnType<typeof postgres> | null = null;

export async function getDb() {
  if (!_db && process.env.DATABASE_URL) {
    try {
      _client = postgres(process.env.DATABASE_URL);
      _db = drizzle(_client);
    } catch (error) {
      console.warn("[Database] Failed to connect:", error);
      _db = null;
    }
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

  const result = await db.select().from(users).where(eq(users.username, username)).limit(1);
  return result.length > 0 ? result[0] : undefined;
}

export async function getUserById(id: number) {
  const db = await getDb();
  if (!db) {
    console.warn("[Database] Cannot get user: database not available");
    return undefined;
  }

  const result = await db.select().from(users).where(eq(users.id, id)).limit(1);
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


// Initialize database with sample data
export async function initializeSampleData() {
  try {
    const db = await getDb();
    if (!db) {
      console.warn("[Database] Cannot initialize sample data: database not available");
      return;
    }

    // Check if we already have vehicles
    const existingVehicles = await db.select().from(vehicles).limit(1);
    if (existingVehicles.length > 0) {
      console.log("[Database] Sample data already exists, skipping initialization");
      return;
    }

    console.log("[Database] Initializing sample data...");

    // Create locations
    const locationData: InsertLocation[] = [
      { name: "Pátio São Paulo", city: "Guarulhos", state: "SP", address: "Av. Monteiro Lobato, 1000" },
      { name: "Pátio Campinas", city: "Campinas", state: "SP", address: "Rodovia Dom Pedro I, km 120" },
      { name: "Pátio Rio de Janeiro", city: "Rio de Janeiro", state: "RJ", address: "Avenida Brasil, 5000" },
      { name: "Pátio Belo Horizonte", city: "Belo Horizonte", state: "MG", address: "Avenida Getúlio Vargas, 3000" },
      { name: "Pátio Curitiba", city: "Curitiba", state: "PR", address: "Rodovia BR-116, km 80" },
    ];

    const insertedLocations = await db.insert(locations).values(locationData).returning();
    console.log(`[Database] Created ${insertedLocations.length} locations`);

    // Create categories
    const categoryData: InsertCategory[] = [
      { name: "Carros de Passeio", slug: "carros-passeio" },
      { name: "SUVs e Utilitários", slug: "suvs-utilitarios" },
      { name: "Caminhonetes", slug: "caminhonetes" },
      { name: "Motos", slug: "motos" },
      { name: "Veículos Comerciais", slug: "veiculos-comerciais" },
      { name: "Veículos Salvados", slug: "veiculos-salvados" },
      { name: "Veículos Premium", slug: "veiculos-premium" },
    ];

    const insertedCategories = await db.insert(categories).values(categoryData).returning();
    console.log(`[Database] Created ${insertedCategories.length} categories`);

    // Create sample vehicles
    const vehicleData: InsertVehicle[] = [
      {
        lotNumber: "LOT001",
        year: 2021,
        make: "Volkswagen",
        model: "Gol 1.6",
        description: "Volkswagen Gol 1.6 MSI 2021, branco, 22.000 km, automático, completo.",
        imageUrl: "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800",
        currentBid: 38000,
        buyNowPrice: 52000,
        locationId: insertedLocations[0].id,
        categoryId: insertedCategories[0].id,
        saleType: "auction",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT002",
        year: 2020,
        make: "Chevrolet",
        model: "Onix 1.0",
        description: "Chevrolet Onix 1.0 LT 2020, prata, 28.000 km, manual, completo.",
        imageUrl: "https://images.unsplash.com/photo-1619405399517-d4dc2ebe6e0d?w=800",
        currentBid: 32000,
        buyNowPrice: 45000,
        locationId: insertedLocations[1].id,
        categoryId: insertedCategories[0].id,
        saleType: "direct",
        status: "active",
        hasWarranty: true,
        hasReport: false,
      },
      {
        lotNumber: "LOT003",
        year: 2019,
        make: "Fiat",
        model: "Argo 1.3",
        description: "Fiat Argo 1.3 Drive 2019, preto, 45.000 km, manual, ar condicionado.",
        imageUrl: "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800",
        currentBid: 28000,
        buyNowPrice: 40000,
        locationId: insertedLocations[2].id,
        categoryId: insertedCategories[0].id,
        saleType: "auction",
        status: "active",
        hasWarranty: false,
        hasReport: true,
      },
      {
        lotNumber: "LOT004",
        year: 2021,
        make: "Honda",
        model: "Civic 2.0",
        description: "Honda Civic 2.0 EXL 2021, cinza, 18.000 km, automático, central multimídia.",
        imageUrl: "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800",
        currentBid: 45000,
        buyNowPrice: 62000,
        locationId: insertedLocations[0].id,
        categoryId: insertedCategories[0].id,
        saleType: "auction",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT005",
        year: 2020,
        make: "Toyota",
        model: "Corolla 2.0",
        description: "Toyota Corolla 2.0 XEI 2020, prata, 35.000 km, automático, central multimídia.",
        imageUrl: "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800",
        currentBid: 52000,
        buyNowPrice: 72000,
        locationId: insertedLocations[1].id,
        categoryId: insertedCategories[0].id,
        saleType: "direct",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT006",
        year: 2019,
        make: "Jeep",
        model: "Compass Sport",
        description: "Jeep Compass Sport 2019, branco, 48.000 km, 4x2, automático, completo.",
        imageUrl: "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=800",
        currentBid: 55000,
        buyNowPrice: 75000,
        locationId: insertedLocations[2].id,
        categoryId: insertedCategories[1].id,
        saleType: "auction",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT007",
        year: 2021,
        make: "Hyundai",
        model: "Creta 1.6",
        description: "Hyundai Creta 1.6 Attitude 2021, cinza, 28.000 km, automático, central multimídia.",
        imageUrl: "https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=800",
        currentBid: 48000,
        buyNowPrice: 65000,
        locationId: insertedLocations[0].id,
        categoryId: insertedCategories[1].id,
        saleType: "auction",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT008",
        year: 2020,
        make: "Volkswagen",
        model: "T-Cross 1.0",
        description: "VW T-Cross 1.0 TSI 2020, azul, 32.000 km, turbo, automático, completo.",
        imageUrl: "https://images.unsplash.com/photo-1617469767053-d3b523a0b982?w=800",
        currentBid: 52000,
        buyNowPrice: 70000,
        locationId: insertedLocations[3].id,
        categoryId: insertedCategories[1].id,
        saleType: "direct",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT009",
        year: 2019,
        make: "Fiat",
        model: "Toro Freedom",
        description: "Fiat Toro Freedom 2019, branca, diesel, 4x4, 62.000 km, cabine dupla.",
        imageUrl: "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=800",
        currentBid: 65000,
        buyNowPrice: 88000,
        locationId: insertedLocations[4].id,
        categoryId: insertedCategories[2].id,
        saleType: "auction",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT010",
        year: 2020,
        make: "Toyota",
        model: "Hilux SRV",
        description: "Toyota Hilux SRV 2020, prata, diesel, 4x4, 45.000 km, automática, top de linha.",
        imageUrl: "https://images.unsplash.com/photo-1623873503168-5d7a0b0d1f8b?w=800",
        currentBid: 95000,
        buyNowPrice: 125000,
        locationId: insertedLocations[0].id,
        categoryId: insertedCategories[2].id,
        saleType: "auction",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT011",
        year: 2021,
        make: "Chevrolet",
        model: "S10 LTZ",
        description: "Chevrolet S10 LTZ 2021, preta, diesel, 4x4, 38.000 km, automática, completa.",
        imageUrl: "https://images.unsplash.com/photo-1623873503168-5d7a0b0d1f8b?w=800",
        currentBid: 88000,
        buyNowPrice: 115000,
        locationId: insertedLocations[1].id,
        categoryId: insertedCategories[2].id,
        saleType: "direct",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT012",
        year: 2020,
        make: "Honda",
        model: "CG 160",
        description: "Honda CG 160 Start 2020, vermelha, 15.000 km, partida elétrica, único dono.",
        imageUrl: "https://images.unsplash.com/photo-1558981852-426c6c22a060?w=800",
        currentBid: 7000,
        buyNowPrice: 9500,
        locationId: insertedLocations[2].id,
        categoryId: insertedCategories[3].id,
        saleType: "auction",
        status: "active",
        hasWarranty: false,
        hasReport: true,
      },
      {
        lotNumber: "LOT013",
        year: 2021,
        make: "Yamaha",
        model: "Fazer 250",
        description: "Yamaha Fazer 250 2021, azul, 8.000 km, freio ABS, painel digital.",
        imageUrl: "https://images.unsplash.com/photo-1609630875171-b1321377ee65?w=800",
        currentBid: 12000,
        buyNowPrice: 16000,
        locationId: insertedLocations[3].id,
        categoryId: insertedCategories[3].id,
        saleType: "auction",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT014",
        year: 2019,
        make: "BMW",
        model: "320i Sport",
        description: "BMW 320i Sport 2019, preta, 42.000 km, turbo, automática, interior em couro.",
        imageUrl: "https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800",
        currentBid: 85000,
        buyNowPrice: 115000,
        locationId: insertedLocations[4].id,
        categoryId: insertedCategories[6].id,
        saleType: "auction",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT015",
        year: 2020,
        make: "Mercedes-Benz",
        model: "C180",
        description: "Mercedes-Benz C180 2020, branca, 35.000 km, turbo, automática, completa.",
        imageUrl: "https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800",
        currentBid: 95000,
        buyNowPrice: 130000,
        locationId: insertedLocations[0].id,
        categoryId: insertedCategories[6].id,
        saleType: "direct",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT016",
        year: 2017,
        make: "Ford",
        model: "Ka 1.0",
        description: "Ford Ka 1.0 2017, branco, 78.000 km, pequenos reparos necessários.",
        imageUrl: "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800",
        currentBid: 8000,
        buyNowPrice: 12000,
        locationId: insertedLocations[1].id,
        categoryId: insertedCategories[5].id,
        saleType: "auction",
        status: "active",
        hasWarranty: false,
        hasReport: true,
      },
      {
        lotNumber: "LOT017",
        year: 2016,
        make: "Renault",
        model: "Sandero 1.0",
        description: "Renault Sandero 1.0 2016, prata, 92.000 km, necessita funilaria.",
        imageUrl: "https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=800",
        currentBid: 6500,
        buyNowPrice: 10000,
        locationId: insertedLocations[2].id,
        categoryId: insertedCategories[5].id,
        saleType: "auction",
        status: "active",
        hasWarranty: false,
        hasReport: false,
      },
      {
        lotNumber: "LOT018",
        year: 2018,
        make: "Fiat",
        model: "Ducato Cargo",
        description: "Fiat Ducato Cargo 2018, branca, diesel, 85.000 km, furgão.",
        imageUrl: "https://images.unsplash.com/photo-1527786356703-4b100091cd2c?w=800",
        currentBid: 45000,
        buyNowPrice: 62000,
        locationId: insertedLocations[3].id,
        categoryId: insertedCategories[4].id,
        saleType: "auction",
        status: "active",
        hasWarranty: false,
        hasReport: true,
      },
      {
        lotNumber: "LOT019",
        year: 2019,
        make: "Volkswagen",
        model: "Delivery Express",
        description: "VW Delivery Express 2019, branco, diesel, 68.000 km, baú.",
        imageUrl: "https://images.unsplash.com/photo-1527786356703-4b100091cd2c?w=800",
        currentBid: 52000,
        buyNowPrice: 70000,
        locationId: insertedLocations[4].id,
        categoryId: insertedCategories[4].id,
        saleType: "direct",
        status: "active",
        hasWarranty: false,
        hasReport: true,
      },
      {
        lotNumber: "LOT020",
        year: 2020,
        make: "Nissan",
        model: "Kicks 1.6",
        description: "Nissan Kicks 1.6 SV 2020, laranja, 35.000 km, automático.",
        imageUrl: "https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=800",
        currentBid: 48000,
        buyNowPrice: 65000,
        locationId: insertedLocations[0].id,
        categoryId: insertedCategories[1].id,
        saleType: "auction",
        status: "active",
        hasWarranty: true,
        hasReport: true,
      },
    ];

    const insertedVehicles = await db.insert(vehicles).values(vehicleData).returning();
    console.log(`[Database] Created ${insertedVehicles.length} sample vehicles`);

    // Create partners
    const partnerData: InsertPartner[] = [
      { name: "Banco do Brasil", logoUrl: "https://via.placeholder.com/200x80/003366/FFFFFF?text=Banco+do+Brasil", displayOrder: 1 },
      { name: "Caixa Econômica", logoUrl: "https://via.placeholder.com/200x80/0066CC/FFFFFF?text=Caixa", displayOrder: 2 },
      { name: "Bradesco", logoUrl: "https://via.placeholder.com/200x80/CC0000/FFFFFF?text=Bradesco", displayOrder: 3 },
      { name: "Itaú", logoUrl: "https://via.placeholder.com/200x80/FF6600/FFFFFF?text=Itau", displayOrder: 4 },
      { name: "Santander", logoUrl: "https://via.placeholder.com/200x80/CC0000/FFFFFF?text=Santander", displayOrder: 5 },
    ];

    const insertedPartners = await db.insert(partners).values(partnerData).returning();
    console.log(`[Database] Created ${insertedPartners.length} partners`);

    console.log("[Database] Sample data initialization completed successfully");
  } catch (error) {
    console.error("[Database] Failed to initialize sample data:", error);
  }
}
