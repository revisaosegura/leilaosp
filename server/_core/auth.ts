import { SignJWT, jwtVerify } from "jose";
import { ENV } from "./env";
import type { User } from "../../drizzle/schema";

const JWT_SECRET = new TextEncoder().encode(ENV.jwtSecret);

export interface JWTPayload {
  userId: number;
  username: string;
  role: string;
}

/**
 * Create a JWT token for a user
 */
export async function createToken(user: User): Promise<string> {
  const payload: JWTPayload = {
    userId: user.id,
    username: user.username,
    role: user.role,
  };

  const token = await new SignJWT(payload)
    .setProtectedHeader({ alg: "HS256" })
    .setIssuedAt()
    .setExpirationTime("365d") // 1 year
    .sign(JWT_SECRET);

  return token;
}

/**
 * Verify and decode a JWT token
 */
export async function verifyToken(token: string): Promise<JWTPayload | null> {
  try {
    const { payload } = await jwtVerify(token, JWT_SECRET);
    return payload as JWTPayload;
  } catch (error) {
    console.error("[Auth] Token verification failed:", error);
    return null;
  }
}

/**
 * Hash a password using a simple approach (in production, use bcrypt)
 */
export async function hashPassword(password: string): Promise<string> {
  // For simplicity, we'll use a basic hash. In production, use bcrypt or argon2
  const encoder = new TextEncoder();
  const data = encoder.encode(password + ENV.jwtSecret);
  const hashBuffer = await crypto.subtle.digest("SHA-256", data);
  const hashArray = Array.from(new Uint8Array(hashBuffer));
  const hashHex = hashArray.map(b => b.toString(16).padStart(2, "0")).join("");
  return hashHex;
}

/**
 * Verify a password against a hash
 */
export async function verifyPassword(password: string, hash: string): Promise<boolean> {
  const passwordHash = await hashPassword(password);
  return passwordHash === hash;
}
