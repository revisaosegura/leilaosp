import { drizzle } from "drizzle-orm/mysql2";
import mysql from "mysql2/promise";

const connection = await mysql.createConnection(process.env.DATABASE_URL);
const db = drizzle(connection);

async function seed() {
  console.log("🌱 Seeding database...");

  try {
    // Seed Locations
    console.log("📍 Creating locations...");
    await connection.execute(`
      INSERT INTO locations (name, city, state, address) VALUES
      ('Itaquaquecetuba - SP', 'Itaquaquecetuba', 'SP', 'Rua Exemplo, 123'),
      ('Osasco - SP', 'Osasco', 'SP', 'Av. Exemplo, 456'),
      ('Betim - MG', 'Betim', 'MG', 'Rua Exemplo, 789'),
      ('Leilão Pátio Porto Seguro - SP', 'São Paulo', 'SP', 'Av. Porto Seguro, 100')
      ON DUPLICATE KEY UPDATE name=name
    `);

    // Seed Categories
    console.log("📁 Creating categories...");
    await connection.execute(`
      INSERT INTO categories (name, slug) VALUES
      ('Automóveis', 'automoveis'),
      ('Caminhões', 'caminhoes'),
      ('Motocicletas', 'motocicletas'),
      ('SUVs', 'suvs'),
      ('Venda Direta', 'venda-direta')
      ON DUPLICATE KEY UPDATE name=name
    `);

    // Seed Vehicles
    console.log("🚗 Creating vehicles...");
    await connection.execute(`
      INSERT INTO vehicles (lotNumber, year, make, model, description, imageUrl, currentBid, buyNowPrice, locationId, categoryId, saleType, hasWarranty, hasReport) VALUES
      ('1036018', 2023, 'FERRARI', 'SF90 STRADALE 4.0 V8 BITURBO HIBRID', 'Ferrari SF90 Stradale em excelente estado', 'https://placehold.co/600x400/1a2332/f7a600?text=Ferrari+SF90', 0, 5000000, 4, 1, 'auction', 0, 1),
      ('1027187', 2021, 'MERCEDES BENZ', 'ACTROS', 'Caminhão Mercedes Benz Actros', 'https://placehold.co/600x400/1a2332/f7a600?text=Mercedes+Actros', 80050, 350000, 1, 2, 'auction', 0, 1),
      ('1054628', 2025, 'YAMAHA', 'NMAX', 'Yamaha NMAX 2025 zero km', 'https://placehold.co/600x400/1a2332/f7a600?text=Yamaha+NMAX', 18000, 22000, 2, 3, 'auction', 1, 1),
      ('1058614', 2019, 'BMW', 'M5', 'BMW M5 2019 em perfeito estado', 'https://placehold.co/600x400/1a2332/f7a600?text=BMW+M5', 285000, 350000, 3, 1, 'auction', 0, 1),
      ('1058615', 2022, 'TOYOTA', 'COROLLA XEI', 'Toyota Corolla XEI 2022 completo', 'https://placehold.co/600x400/1a2332/f7a600?text=Toyota+Corolla', 0, 95000, 1, 5, 'direct', 1, 1),
      ('1058616', 2023, 'HONDA', 'CIVIC TOURING', 'Honda Civic Touring 2023 top de linha', 'https://placehold.co/600x400/1a2332/f7a600?text=Honda+Civic', 0, 145000, 2, 5, 'direct', 1, 1),
      ('1058617', 2021, 'JEEP', 'COMPASS LIMITED', 'Jeep Compass Limited 2021 diesel', 'https://placehold.co/600x400/1a2332/f7a600?text=Jeep+Compass', 0, 125000, 3, 4, 'direct', 1, 1),
      ('1058618', 2020, 'VOLKSWAGEN', 'AMAROK HIGHLINE', 'VW Amarok Highline 2020 4x4', 'https://placehold.co/600x400/1a2332/f7a600?text=VW+Amarok', 45000, 155000, 1, 2, 'auction', 0, 1)
      ON DUPLICATE KEY UPDATE lotNumber=lotNumber
    `);

    // Seed Partners
    console.log("🤝 Creating partners...");
    await connection.execute(`
      INSERT INTO partners (name, logoUrl, displayOrder) VALUES
      ('Banco Itaú', 'https://placehold.co/200x100/1a2332/f7a600?text=Itau', 1),
      ('Porto Seguro', 'https://placehold.co/200x100/1a2332/f7a600?text=Porto', 2),
      ('Bradesco Seguros', 'https://placehold.co/200x100/1a2332/f7a600?text=Bradesco', 3),
      ('Santander', 'https://placehold.co/200x100/1a2332/f7a600?text=Santander', 4)
      ON DUPLICATE KEY UPDATE name=name
    `);

    console.log("✅ Seed completed successfully!");
  } catch (error) {
    console.error("❌ Seed failed:", error);
    throw error;
  } finally {
    await connection.end();
  }
}

seed().catch((error) => {
  console.error("Error:", error);
  process.exit(1);
});
