import * as React from "react";

const MOBILE_BREAKPOINT = 768;
const MOBILE_QUERY = `(max-width: ${MOBILE_BREAKPOINT - 1}px)`;

const getMediaQuery = () => {
  if (typeof window === "undefined" || typeof window.matchMedia !== "function") {
    return null;
  }

  return window.matchMedia(MOBILE_QUERY);
};

const getClientSnapshot = () => {
  if (typeof window === "undefined") return false;

  const mql = getMediaQuery();
  const hasCoarsePointer = window.matchMedia?.("(pointer: coarse)").matches ?? false;

  if (mql) return mql.matches || hasCoarsePointer;

  return window.innerWidth < MOBILE_BREAKPOINT || hasCoarsePointer;
};

export function useIsMobile() {
  return React.useSyncExternalStore(
    callback => {
      const mql = getMediaQuery();

      if (!mql) return () => {};

      const onChange = () => callback();
      const addListener =
        "addEventListener" in mql
          ? mql.addEventListener.bind(mql)
          : (mql as MediaQueryList).addListener?.bind(mql);
      const removeListener =
        "removeEventListener" in mql
          ? mql.removeEventListener.bind(mql)
          : (mql as MediaQueryList).removeListener?.bind(mql);

      addListener?.("change", onChange);
      return () => removeListener?.("change", onChange);
    },
    getClientSnapshot,
    () => false
  );
}
