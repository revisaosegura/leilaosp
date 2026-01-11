CREATE TABLE IF NOT EXISTS "users" (
	"id" SERIAL PRIMARY KEY,
	"username" text UNIQUE,
	"name" text,
	"email" text NOT NULL UNIQUE,
	"phone" text,
	"password" text,
	"role" text DEFAULT 'user',
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
