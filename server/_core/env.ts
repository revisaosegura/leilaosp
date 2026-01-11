const DEFAULT_DATABASE_URL =
  "postgresql://leilaosp_user:ZBI9see0qaBUUuSFJJwrkzrCXuAwUpsi@dpg-d5hg446mcj7s73b0oou0-a/leilaosp";

export const ENV = {
  appId: process.env.VITE_APP_ID ?? "",
  cookieSecret: process.env.JWT_SECRET ?? "",
  jwtSecret: process.env.JWT_SECRET ?? "leilaosp_secret_key_2025_secure_token_generation",
  databaseUrl:
    process.env.DATABASE_URL ??
    (process.env.NODE_ENV === "test" ? "" : DEFAULT_DATABASE_URL),
  oAuthServerUrl: process.env.OAUTH_SERVER_URL ?? "",
  ownerOpenId: process.env.OWNER_OPEN_ID ?? "",
  isProduction: process.env.NODE_ENV === "production",
  forgeApiUrl: process.env.BUILT_IN_FORGE_API_URL ?? "",
  forgeApiKey: process.env.BUILT_IN_FORGE_API_KEY ?? "",
  cloudinaryCloudName: process.env.CLOUDINARY_CLOUD_NAME ?? "",
  cloudinaryApiKey: process.env.CLOUDINARY_API_KEY ?? "",
  cloudinaryApiSecret: process.env.CLOUDINARY_API_SECRET ?? "",
};
