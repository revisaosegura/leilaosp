import { pgTable, pgEnum, serial, varchar, text, timestamp, boolean, integer } from "drizzle-orm/pg-core";

/**
 * Enums for PostgreSQL
 */
export const roleEnum = pgEnum("role", ["user", "admin"]);
export const saleTypeEnum = pgEnum("sale_type", ["auction", "direct"]);
export const statusEnum = pgEnum("status", ["active", "sold", "pending"]);
export const auctionStatusEnum = pgEnum("auction_status", ["scheduled", "live", "ended"]);
export const bidTypeEnum = pgEnum("bid_type", ["preliminary", "live"]);

/**
 * Core user table backing auth flow.
 */
export const users = pgTable("users", {
  id: serial("id").primaryKey(),
  username: varchar("username", { length: 64 }).notNull().unique(),
  password: varchar("password", { length: 255 }).notNull(),
  name: text("name"),
  email: varchar("email", { length: 320 }),
  role: roleEnum("role").default("user").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
  lastSignedIn: timestamp("last_signed_in").defaultNow().notNull(),
});

export type User = typeof users.$inferSelect;
export type InsertUser = typeof users.$inferInsert;

/**
 * Locations/Pátios table
 */
export const locations = pgTable("locations", {
  id: serial("id").primaryKey(),
  name: varchar("name", { length: 255 }).notNull(),
  city: varchar("city", { length: 100 }).notNull(),
  state: varchar("state", { length: 2 }).notNull(),
  address: text("address"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Location = typeof locations.$inferSelect;
export type InsertLocation = typeof locations.$inferInsert;

/**
 * Categories table
 */
export const categories = pgTable("categories", {
  id: serial("id").primaryKey(),
  name: varchar("name", { length: 100 }).notNull(),
  slug: varchar("slug", { length: 100 }).notNull().unique(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Category = typeof categories.$inferSelect;
export type InsertCategory = typeof categories.$inferInsert;

/**
 * Vehicles table
 */
export const vehicles = pgTable("vehicles", {
  id: serial("id").primaryKey(),
  lotNumber: varchar("lot_number", { length: 50 }).notNull().unique(),
  year: integer("year").notNull(),
  make: varchar("make", { length: 100 }).notNull(),
  model: varchar("model", { length: 100 }).notNull(),
  description: text("description"),
  documentStatus: varchar("document_status", { length: 100 }),
  categoryDetail: varchar("category_detail", { length: 100 }),
  condition: varchar("condition", { length: 100 }),
  runningCondition: varchar("running_condition", { length: 100 }),
  montaType: varchar("monta_type", { length: 100 }),
  chassisType: varchar("chassis_type", { length: 100 }),
  comitente: varchar("comitente", { length: 255 }),
  patio: varchar("patio", { length: 255 }),
  imageUrl: text("image_url"),
  images: text("images"),
  currentBid: integer("current_bid").default(0).notNull(),
  buyNowPrice: integer("buy_now_price"),
  fipeValue: integer("fipe_value"),
  bidIncrement: integer("bid_increment"),
  locationId: integer("location_id").notNull(),
  categoryId: integer("category_id").notNull(),
  saleType: saleTypeEnum("sale_type").default("auction").notNull(),
  status: statusEnum("status").default("active").notNull(),
  hasWarranty: boolean("has_warranty").default(false).notNull(),
  hasReport: boolean("has_report").default(false).notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export type Vehicle = typeof vehicles.$inferSelect;
export type InsertVehicle = typeof vehicles.$inferInsert;

/**
 * Auctions table
 */
export const auctions = pgTable("auctions", {
  id: serial("id").primaryKey(),
  title: varchar("title", { length: 255 }).notNull(),
  description: text("description"),
  startDate: timestamp("start_date").notNull(),
  endDate: timestamp("end_date").notNull(),
  status: auctionStatusEnum("auction_status").default("scheduled").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Auction = typeof auctions.$inferSelect;
export type InsertAuction = typeof auctions.$inferInsert;

/**
 * Bids table
 */
export const bids = pgTable("bids", {
  id: serial("id").primaryKey(),
  vehicleId: integer("vehicle_id").notNull(),
  userId: integer("user_id").notNull(),
  amount: integer("amount").notNull(),
  bidType: bidTypeEnum("bid_type").default("preliminary").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Bid = typeof bids.$inferSelect;
export type InsertBid = typeof bids.$inferInsert;

/**
 * Partners table
 */
export const partners = pgTable("partners", {
  id: serial("id").primaryKey(),
  name: varchar("name", { length: 255 }).notNull(),
  logoUrl: text("logo_url"),
  displayOrder: integer("display_order").default(0).notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Partner = typeof partners.$inferSelect;
export type InsertPartner = typeof partners.$inferInsert;

/**
 * Favorites table - User's favorite vehicles
 */
export const favorites = pgTable("favorites", {
  id: serial("id").primaryKey(),
  userId: integer("user_id").notNull(),
  vehicleId: integer("vehicle_id").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Favorite = typeof favorites.$inferSelect;
export type InsertFavorite = typeof favorites.$inferInsert;
