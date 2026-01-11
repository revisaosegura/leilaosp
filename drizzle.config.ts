import "dotenv/config";
import { defineConfig } from "drizzle-kit";

// Usa a variável de ambiente ou a URL direta do Render como fallback
const connectionString =
  process.env.DATABASE_URL ||
  "postgresql://leilaosp_user:ZBI9see0qaBUUuSFJJwrkzrCXuAwUpsi@dpg-d5hg446mcj7s73b0oou0-a.oregon-postgres.render.com/leilaosp?ssl=true";

export default defineConfig({
  schema: "./drizzle/schema.ts",
  out: "./drizzle",
  dialect: "postgresql",
  dbCredentials: {
    url: connectionString,
  },
  tablesFilter: ["!pg_*"],
});
