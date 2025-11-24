import { mysqlTable, mysqlEnum, int, varchar, text, timestamp, boolean } from "drizzle-orm/mysql-core";

/**
 * Enums for PostgreSQL
 */
export const roleEnum = mysqlEnum("role", ["user", "admin"]);
export const saleTypeEnum = mysqlEnum("sale_type", ["auction", "direct"]);
export const statusEnum = mysqlEnum("status", ["active", "sold", "pending"]);
export const auctionStatusEnum = mysqlEnum("auction_status", ["scheduled", "live", "ended"]);
export const bidTypeEnum = mysqlEnum("bid_type", ["preliminary", "live"]);

/**
 * Core user table backing auth flow.
 */
export const users = mysqlTable("users", {
  id: int("id").autoincrement().primaryKey(),
  username: varchar("username", { length: 64 }).notNull().unique(),
  password: varchar("password", { length: 255 }).notNull(),
  name: text("name"),
  email: varchar("email", { length: 320 }),
  role: roleEnum.default("user").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
  lastSignedIn: timestamp("last_signed_in").defaultNow().notNull(),
});

export type User = typeof users.$inferSelect;
export type InsertUser = typeof users.$inferInsert;

/**
 * Locations/Pátios table
 */
export const locations = mysqlTable("locations", {
  id: int("id").autoincrement().primaryKey(),
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
export const categories = mysqlTable("categories", {
  id: int("id").autoincrement().primaryKey(),
  name: varchar("name", { length: 100 }).notNull(),
  slug: varchar("slug", { length: 100 }).notNull().unique(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Category = typeof categories.$inferSelect;
export type InsertCategory = typeof categories.$inferInsert;

/**
 * Vehicles table
 */
export const vehicles = mysqlTable("vehicles", {
  id: int("id").autoincrement().primaryKey(),
  lotNumber: varchar("lot_number", { length: 50 }).notNull().unique(),
  year: int("year").notNull(),
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
  currentBid: int("current_bid").default(0).notNull(),
  buyNowPrice: int("buy_now_price"),
  fipeValue: int("fipe_value"),
  bidIncrement: int("bid_increment"),
  locationId: int("location_id").notNull(),
  categoryId: int("category_id").notNull(),
  saleType: saleTypeEnum.default("auction").notNull(),
  status: statusEnum.default("active").notNull(),
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
export const auctions = mysqlTable("auctions", {
  id: int("id").autoincrement().primaryKey(),
  title: varchar("title", { length: 255 }).notNull(),
  description: text("description"),
  startDate: timestamp("start_date").notNull(),
  endDate: timestamp("end_date").notNull(),
  status: auctionStatusEnum.default("scheduled").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Auction = typeof auctions.$inferSelect;
export type InsertAuction = typeof auctions.$inferInsert;

/**
 * Bids table
 */
export const bids = mysqlTable("bids", {
  id: int("id").autoincrement().primaryKey(),
  vehicleId: int("vehicle_id").notNull(),
  userId: int("user_id").notNull(),
  amount: int("amount").notNull(),
  bidType: bidTypeEnum.default("preliminary").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Bid = typeof bids.$inferSelect;
export type InsertBid = typeof bids.$inferInsert;

/**
 * Partners table
 */
export const partners = mysqlTable("partners", {
  id: int("id").autoincrement().primaryKey(),
  name: varchar("name", { length: 255 }).notNull(),
  logoUrl: text("logo_url"),
  displayOrder: int("display_order").default(0).notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Partner = typeof partners.$inferSelect;
export type InsertPartner = typeof partners.$inferInsert;

/**
 * Favorites table - User's favorite vehicles
 */
export const favorites = mysqlTable("favorites", {
  id: int("id").autoincrement().primaryKey(),
  userId: int("user_id").notNull(),
  vehicleId: int("vehicle_id").notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type Favorite = typeof favorites.$inferSelect;
export type InsertFavorite = typeof favorites.$inferInsert;
