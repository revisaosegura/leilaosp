export { COOKIE_NAME, ONE_YEAR_MS } from "@shared/const";

export const APP_TITLE = import.meta.env.VITE_APP_TITLE || "App";

export const APP_LOGO = "/copart-logo.png";

// Generate login URL at runtime so redirect URI reflects the current origin.
export const getLoginUrl = () => {
  const oauthPortalUrl = import.meta.env.VITE_OAUTH_PORTAL_URL || "https://oauth.manus.im";
  const appId = import.meta.env.VITE_APP_ID || "";
  
  // If OAuth is not configured, return a placeholder
  if (!appId) {
    console.warn("OAuth not configured. Please set VITE_APP_ID and VITE_OAUTH_PORTAL_URL environment variables.");
    return "#oauth-not-configured";
  }
  
  const redirectUri = `${window.location.origin}/api/oauth/callback`;
  const state = btoa(redirectUri);

  try {
    const url = new URL(`${oauthPortalUrl}/app-auth`);
    url.searchParams.set("appId", appId);
    url.searchParams.set("redirectUri", redirectUri);
    url.searchParams.set("state", state);
    url.searchParams.set("type", "signIn");

    return url.toString();
  } catch (error) {
    console.error("Error generating login URL:", error);
    return "#oauth-error";
  }
};

export const WHATSAPP_URL = "http://wa.me/5511921271104";
