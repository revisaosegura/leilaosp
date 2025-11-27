const DEFAULT_DATABASE_URL =
  "postgresql://copartbr_user:4b8jjDMumPKf1pATPOiUn2BcwHh89LGc@dpg-d4d3c02li9vc73caijg0-a/copartbr";

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
  b2Endpoint: process.env.B2_ENDPOINT ?? "",
  b2BucketName: process.env.B2_BUCKET_NAME ?? "",
  b2AccessKeyId: process.env.B2_ACCESS_KEY_ID ?? "",
  b2SecretAccessKey: process.env.B2_SECRET_ACCESS_KEY ?? "",
  b2Region: process.env.B2_REGION ?? "",
};
