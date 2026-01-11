export { COOKIE_NAME, ONE_YEAR_MS } from "@shared/const";

export const APP_TITLE = import.meta.env.VITE_APP_TITLE || "Copart Brasil";

export const APP_LOGO = import.meta.env.VITE_APP_LOGO || "/copart-logo.png";

// Generate login URL for local authentication
export const getLoginUrl = () => {
  return "/login";
};

export const WHATSAPP_URL = "http://wa.me/5511953290242";
