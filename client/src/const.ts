export { COOKIE_NAME, ONE_YEAR_MS } from "@shared/const";

export const APP_TITLE = import.meta.env.VITE_APP_TITLE || "Copart Brasil";

const copartLogoSvg = `<svg width="160" height="64" viewBox="0 0 160 64" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bgGradient" x1="0" y1="0" x2="0" y2="64" gradientUnits="userSpaceOnUse">
      <stop offset="0" stop-color="#182743" />
      <stop offset="1" stop-color="#0b1528" />
    </linearGradient>
    <linearGradient id="ringBlue" x1="34" y1="32" x2="126" y2="32" gradientUnits="userSpaceOnUse">
      <stop offset="0" stop-color="#2f5fad" />
      <stop offset="1" stop-color="#0e43a5" />
    </linearGradient>
  </defs>
  <rect width="160" height="64" rx="10" fill="url(#bgGradient)" />
  <ellipse cx="87" cy="33" rx="62" ry="26" transform="rotate(-7 87 33)" fill="#7f7f7f" />
  <ellipse cx="83" cy="31" rx="60" ry="24" transform="rotate(-7 83 31)" fill="url(#ringBlue)" />
  <ellipse cx="80" cy="31" rx="58" ry="22" transform="rotate(-7 80 31)" fill="#101724" />
  <text x="30" y="43" fill="white" font-family="'Arial Black','Arial',sans-serif" font-size="36" font-style="italic" stroke="#0a0a0a" stroke-width="1.5" paint-order="stroke fill" letter-spacing="-1">Copart</text>
</svg>`;

export const APP_LOGO = `data:image/svg+xml;utf8,${encodeURIComponent(copartLogoSvg)}`;

// Generate login URL for local authentication
export const getLoginUrl = () => {
  return "/login";
};

export const WHATSAPP_URL = "http://wa.me/5511921271104";
