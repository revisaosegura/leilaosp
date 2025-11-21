import { COOKIE_NAME, ONE_YEAR_MS } from "@shared/const";
import type { Express, Request, Response } from "express";
import * as db from "../db";
import { getSessionCookieOptions } from "./cookies";
import { createToken, verifyPassword, hashPassword } from "./auth";

function getBodyParam(req: Request, key: string): string | undefined {
  const value = req.body?.[key];
  return typeof value === "string" ? value : undefined;
}

export async function initializeAdminUser() {
  try {
    const existingAdmin = await db.getUserByUsername("admin");
    
    if (existingAdmin) {
      console.log("[Auth] Admin user already exists");
      return;
    }

    const hashedPassword = await hashPassword("copart2025");
    
    await db.createUser({
      username: "admin",
      password: hashedPassword,
      name: "Administrador",
      email: "admin@leilaosp.com",
      role: "admin",
      lastSignedIn: new Date(),
    });

    console.log("[Auth] Admin user created successfully");
  } catch (error) {
    console.error("[Auth] Failed to initialize admin user:", error);
  }
}

export function registerLocalAuthRoutes(app: Express) {
  // Initialize admin user on startup
  initializeAdminUser();
  
  // Initialize sample vehicles on startup
  initializeSampleVehicles();
  
  // Login endpoint
  app.post("/api/auth/login", async (req: Request, res: Response) => {
    const username = getBodyParam(req, "username");
    const password = getBodyParam(req, "password");

    if (!username || !password) {
      res.status(400).json({ error: "Username and password are required" });
      return;
    }

    try {
      // Get user from database
      const user = await db.getUserByUsername(username);

      if (!user) {
        res.status(401).json({ error: "Invalid credentials" });
        return;
      }

      // Verify password
      const isValid = await verifyPassword(password, user.password);

      if (!isValid) {
        res.status(401).json({ error: "Invalid credentials" });
        return;
      }

      // Update last signed in
      await db.updateUserProfile(user.id, {});

      // Create JWT token
      const token = await createToken(user);

      // Set cookie
      const cookieOptions = getSessionCookieOptions(req);
      res.cookie(COOKIE_NAME, token, { ...cookieOptions, maxAge: ONE_YEAR_MS });

      res.json({ 
        success: true,
        user: {
          id: user.id,
          username: user.username,
          name: user.name,
          email: user.email,
          role: user.role,
        }
      });
    } catch (error) {
      console.error("[Auth] Login failed", error);
      res.status(500).json({ error: "Login failed" });
    }
  });

  // Initialize admin user if not exists
  app.post("/api/auth/init-admin", async (req: Request, res: Response) => {
    try {
      const existingAdmin = await db.getUserByUsername("admin");
      
      if (existingAdmin) {
        res.json({ message: "Admin user already exists" });
        return;
      }

      const hashedPassword = await hashPassword("copart2025");
      
      await db.createUser({
        username: "admin",
        password: hashedPassword,
        name: "Administrador",
        email: "admin@leilaosp.com",
        role: "admin",
        lastSignedIn: new Date(),
      });

      res.json({ message: "Admin user created successfully" });
    } catch (error) {
      console.error("[Auth] Failed to create admin user", error);
      res.status(500).json({ error: "Failed to create admin user" });
    }
  });
}


// Initialize sample vehicles data
export async function initializeSampleVehicles() {
  try {
    // Check if we already have vehicles
    const existingVehicles = await db.getVehicles({ limit: 1 });
    if (existingVehicles && existingVehicles.length > 0) {
      console.log("[Database] Sample vehicles already exist, skipping initialization");
      return;
    }

    console.log("[Database] Initializing sample vehicles...");

    // Create locations
    const locations = [
      { name: "Pátio São Paulo", city: "Guarulhos", state: "SP", address: "Av. Monteiro Lobato, 1000" },
      { name: "Pátio Campinas", city: "Campinas", state: "SP", address: "Rodovia Dom Pedro I, km 120" },
      { name: "Pátio Rio de Janeiro", city: "Rio de Janeiro", state: "RJ", address: "Avenida Brasil, 5000" },
      { name: "Pátio Belo Horizonte", city: "Belo Horizonte", state: "MG", address: "Avenida Getúlio Vargas, 3000" },
      { name: "Pátio Curitiba", city: "Curitiba", state: "PR", address: "Rodovia BR-116, km 80" },
    ];

    // Create categories
    const categories = [
      { name: "Carros de Passeio", slug: "carros-passeio" },
      { name: "SUVs e Utilitários", slug: "suvs-utilitarios" },
      { name: "Caminhonetes", slug: "caminhonetes" },
      { name: "Motos", slug: "motos" },
      { name: "Veículos Comerciais", slug: "veiculos-comerciais" },
      { name: "Veículos Salvados", slug: "veiculos-salvados" },
      { name: "Veículos Premium", slug: "veiculos-premium" },
    ];

    // Insert locations and categories
    for (const loc of locations) {
      try {
        await db.createLocation(loc);
      } catch (e) {
        // Location might already exist
      }
    }

    for (const cat of categories) {
      try {
        await db.createCategory(cat);
      } catch (e) {
        // Category might already exist
      }
    }

    // Get IDs for the first location and category
    const allLocations = await db.getLocations();
    const allCategories = await db.getCategories();

    if (!allLocations || allLocations.length === 0 || !allCategories || allCategories.length === 0) {
      console.warn("[Database] Failed to create locations or categories");
      return;
    }

    // Create sample vehicles
    const vehicles = [
      {
        lotNumber: "LOT001",
        year: 2021,
        make: "Volkswagen",
        model: "Gol 1.6",
        description: "Volkswagen Gol 1.6 MSI 2021, branco, 22.000 km, automático, completo.",
        imageUrl: "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800",
        currentBid: 38000,
        buyNowPrice: 52000,
        locationId: allLocations[0].id,
        categoryId: allCategories[0].id,
        saleType: "auction" as const,
        status: "active" as const,
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
        locationId: allLocations[1].id,
        categoryId: allCategories[0].id,
        saleType: "direct" as const,
        status: "active" as const,
        hasWarranty: true,
        hasReport: false,
      },
      {
        lotNumber: "LOT003",
        year: 2019,
        make: "Honda",
        model: "Civic 2.0",
        description: "Honda Civic 2.0 EXL 2019, cinza, 25.000 km, automático, completo.",
        imageUrl: "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800",
        currentBid: 45000,
        buyNowPrice: 62000,
        locationId: allLocations[2].id,
        categoryId: allCategories[0].id,
        saleType: "auction" as const,
        status: "active" as const,
        hasWarranty: true,
        hasReport: true,
      },
      {
        lotNumber: "LOT004",
        year: 2020,
        make: "Toyota",
        model: "Corolla 2.0",
        description: "Toyota Corolla 2.0 XEI 2020, prata, 35.000 km, automático.",
        imageUrl: "https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800",
        currentBid: 52000,
        buyNowPrice: 72000,
        locationId: allLocations[0].id,
        categoryId: allCategories[0].id,
        saleType: "direct" as const,
        status: "active" as const,
        hasWarranty: true,
        hasReport: true,
      },
    ];

    for (const vehicle of vehicles) {
      try {
        await db.createVehicle(vehicle);
      } catch (e) {
        console.error("[Database] Failed to create vehicle:", e);
      }
    }

    console.log("[Database] Sample vehicles initialized successfully");
  } catch (error) {
    console.error("[Database] Failed to initialize sample vehicles:", error);
  }
}
