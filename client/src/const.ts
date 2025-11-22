export { COOKIE_NAME, ONE_YEAR_MS } from "@shared/const";

export const APP_TITLE = import.meta.env.VITE_APP_TITLE || "Copart Brasil";

const copartLogoSvg = `<svg width="134" height="52" viewBox="0 0 134 52" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="2" y="8" width="120" height="36" rx="18" fill="url(#paint0_linear)" stroke="#0A1B3F" stroke-width="4"/>
  <path d="M33 32.5C30.3 32.5 28 30.2 28 27.5C28 24.8 30.3 22.5 33 22.5C34.8 22.5 36.5 23.4 37.5 24.8L40.2 22.8C38.5 20.4 36 19 33 19C27.8 19 23.5 23.3 23.5 28.5C23.5 33.7 27.8 38 33 38C36 38 38.6 36.6 40.3 34.1L37.6 32.1C36.5 33.6 34.8 34.5 33 34.5Z" fill="white"/>
  <path d="M49 32.5C46.3 32.5 44 30.2 44 27.5C44 24.8 46.3 22.5 49 22.5C51.7 22.5 54 24.8 54 27.5C54 30.2 51.7 32.5 49 32.5ZM49 19C43.8 19 39.5 23.3 39.5 28.5C39.5 33.7 43.8 38 49 38C54.2 38 58.5 33.7 58.5 28.5C58.5 23.3 54.2 19 49 19Z" fill="white"/>
  <path d="M70.5 19H65.8L59.5 37.5H64.3L65.5 34H70.7L71.9 37.5H76.7L70.5 19ZM66.6 30.6L68.1 25.8L69.6 30.6H66.6Z" fill="white"/>
  <path d="M92.5 37.5V22H88.1L84.4 30L80.7 22H76.4V37.5H80.4V29.1L83.7 36.1H85.2L88.5 29.1V37.5H92.5Z" fill="white"/>
  <path d="M102.5 34.5C101.3 34.5 100.4 33.8 100.4 32.6C100.4 31.4 101.3 30.7 102.5 30.7H108.3V27.4H103.1C101.2 27.4 100 26.3 100 24.7C100 23.2 101.1 22.1 102.8 22.1H109.6V19H102.2C98.5 19 96 21.6 96 24.7C96 27.3 97.5 29.2 99.9 29.7C97.7 30.3 96.2 32 96.2 34.2C96.2 37.1 98.6 39 102.1 39H109.8V34.5H102.5Z" fill="white"/>
  <path d="M122.5 37L131.5 29.5L122.5 22V26.7H112.5V32.3H122.5V37Z" fill="#F6B330" stroke="#0A1B3F" stroke-width="2" stroke-linejoin="round"/>
  <defs>
    <linearGradient id="paint0_linear" x1="2" y1="26" x2="122" y2="26" gradientUnits="userSpaceOnUse">
      <stop stop-color="#0C2349"/>
      <stop offset="1" stop-color="#0F2B55"/>
    </linearGradient>
  </defs>
</svg>`;

export const APP_LOGO = `data:image/svg+xml;utf8,${encodeURIComponent(copartLogoSvg)}`;

// Generate login URL for local authentication
export const getLoginUrl = () => {
  return "/login";
};

export const WHATSAPP_URL = "http://wa.me/5511921271104";
