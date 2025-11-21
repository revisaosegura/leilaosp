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
