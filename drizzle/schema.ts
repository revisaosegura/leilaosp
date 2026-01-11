import { pgTable, serial, text, integer, decimal, boolean, timestamp, varchar } from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";

/**
 * Core user table backing auth flow.
 */
export const users = pgTable("users", {
  id: serial("id").primaryKey(),
  username: text("username").unique(),
  password: text("password"),
  name: text("name"),
  email: text("email").notNull().unique(),
  phone: text("phone"),
  role: text("role").default("user"),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});

/**
 * Locations/Pátios table
 */
export const locations = pgTable("locations", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  city: text("city"),
  state: text("state"),
  address: text("address"),
  zipCode: text("zip_code"),
  phone: text("phone"),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});

/**
 * Categories table
 */
export const categories = pgTable("categories", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  slug: text("slug"),
  description: text("description"),
  imageUrl: text("image_url"),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});

/**
 * Vehicles table
 */
export const vehicles = pgTable("vehicles", {
  id: serial("id").primaryKey(),
  lotNumber: text("lot_number"),
  year: integer("year"),
  make: text("make"),
  model: text("model"),
  vin: text("vin"),
  status: text("status").default("active"),
  mileage: integer("mileage").default(0),
  color: text("color"),
  engine: text("engine"),
  transmission: text("transmission"),
  fuelType: text("fuel_type"),
  bodyType: text("body_type"),
  driveType: text("drive_type"),
  estimatedValue: decimal("estimated_value", { precision: 10, scale: 2 }),
  currentBid: decimal("current_bid", { precision: 10, scale: 2 }).default("0"),
  buyNowPrice: decimal("buy_now_price", { precision: 10, scale: 2 }),
  reserveMet: boolean("reserve_met").default(false),
  auctionDate: timestamp("auction_date"),
  categoryId: integer("category_id").references(() => categories.id),
  locationId: integer("location_id").references(() => locations.id),
  sellerId: integer("seller_id").references(() => partners.id),
  description: text("description"),
  highlights: text("highlights"),
  damageDescription: text("damage_description"),
  titleStatus: text("title_status"),
  documentStatus: text("document_status"),
  categoryDetail: text("category_detail"),
  condition: text("condition"),
  runningCondition: text("running_condition"),
  montaType: text("monta_type"),
  chassisType: text("chassis_type"),
  comitente: text("comitente"),
  patio: text("patio"),
  images: text("images").array(),
  imageUrl: text("image_url"),
  saleType: text("sale_type").default("auction"),
  hasWarranty: boolean("has_warranty").default(false),
  hasReport: boolean("has_report").default(false),
  fipeValue: integer("fipe_value"),
  bidIncrement: integer("bid_increment"),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});

/**
 * Auctions table
 */
export const auctions = pgTable("auctions", {
  id: serial("id").primaryKey(),
  title: text("title").notNull(),
  description: text("description"),
  startDate: timestamp("start_date").notNull(),
  endDate: timestamp("end_date").notNull(),
  status: text("status").default("scheduled").notNull(),
  createdAt: timestamp("created_at").defaultNow(),
});

/**
 * Bids table
 */
export const bids = pgTable("bids", {
  id: serial("id").primaryKey(),
  amount: decimal("amount", { precision: 10, scale: 2 }).notNull(),
  userId: integer("user_id").references(() => users.id),
  vehicleId: integer("vehicle_id").references(() => vehicles.id),
  createdAt: timestamp("created_at").defaultNow(),
});

/**
 * Partners table
 */
export const partners = pgTable("partners", {
  id: serial("id").primaryKey(),
  name: text("name").notNull(),
  logoUrl: text("logo_url"),
  displayOrder: integer("display_order").default(0),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});

/**
 * Favorites table - User's favorite vehicles
 */
export const favorites = pgTable("favorites", {
  id: serial("id").primaryKey(),
  userId: integer("user_id").references(() => users.id),
  vehicleId: integer("vehicle_id").references(() => vehicles.id),
  createdAt: timestamp("created_at").defaultNow(),
});


// Relações
export const vehiclesRelations = relations(vehicles, ({ one, many }) => ({
  category: one(categories, {
    fields: [vehicles.categoryId],
    references: [categories.id],
  }),
  location: one(locations, {
    fields: [vehicles.locationId],
    references: [locations.id],
  }),
  seller: one(partners, {
    fields: [vehicles.sellerId],
    references: [partners.id],
  }),
  bids: many(bids),
}));

export const bidsRelations = relations(bids, ({ one }) => ({
  user: one(users, {
    fields: [bids.userId],
    references: [users.id],
  }),
  vehicle: one(vehicles, {
    fields: [bids.vehicleId],
    references: [vehicles.id],
  }),
}));

export const usersRelations = relations(users, ({ many }) => ({
  bids: many(bids),
  favorites: many(favorites),
}));
