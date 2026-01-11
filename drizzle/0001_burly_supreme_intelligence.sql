CREATE TABLE IF NOT EXISTS "auctions" (
	"id" SERIAL PRIMARY KEY,
	"title" text NOT NULL,
	"description" text,
	"start_date" timestamp NOT NULL,
	"end_date" timestamp NOT NULL,
	"status" text DEFAULT 'scheduled' NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "bids" (
	"id" SERIAL PRIMARY KEY,
	"amount" decimal(10, 2) NOT NULL,
	"user_id" integer,
	"vehicle_id" integer,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "categories" (
	"id" SERIAL PRIMARY KEY,
	"name" text NOT NULL,
	"slug" text,
	"description" text,
	"image_url" text,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "locations" (
	"id" SERIAL PRIMARY KEY,
	"name" text NOT NULL,
	"address" text,
	"city" text,
	"state" text,
	"zip_code" text,
	"phone" text,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "partners" (
	"id" SERIAL PRIMARY KEY,
	"name" text NOT NULL,
	"logo_url" text,
	"display_order" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "vehicles" (
	"id" SERIAL PRIMARY KEY,
	"lot_number" text,
	"year" integer,
	"make" text,
	"model" text,
	"vin" text,
	"status" text DEFAULT 'active',
	"mileage" integer DEFAULT 0,
	"color" text,
	"engine" text,
	"transmission" text,
	"fuel_type" text,
	"body_type" text,
	"drive_type" text,
	"estimated_value" decimal(10, 2),
	"current_bid" decimal(10, 2) DEFAULT 0,
	"buy_now_price" decimal(10, 2),
	"reserve_met" boolean DEFAULT false,
	"auction_date" timestamp,
	"category_id" integer,
	"location_id" integer,
	"seller_id" integer,
	"description" text,
	"highlights" text,
	"damage_description" text,
	"title_status" text,
	"images" text[],
	"image_url" text,
	"sale_type" text DEFAULT 'auction',
	"has_warranty" boolean DEFAULT false,
	"has_report" boolean DEFAULT false,
	"fipe_value" integer,
	"bid_increment" integer,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
