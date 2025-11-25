import * as React from "react";

const MOBILE_BREAKPOINT = 768;

const getIsMobile = () => {
  if (typeof window === "undefined") {
    return false;
  }

  if (typeof window.matchMedia !== "function") {
    return window.innerWidth < MOBILE_BREAKPOINT;
  }

  return window.matchMedia(`(max-width: ${MOBILE_BREAKPOINT - 1}px)`).matches;
};

export function useIsMobile() {
  const [isMobile, setIsMobile] = React.useState<boolean>(() => getIsMobile());

  React.useEffect(() => {
    if (typeof window === "undefined") {
      return;
    }

    const mql = window.matchMedia(`(max-width: ${MOBILE_BREAKPOINT - 1}px)`);
    const onChange = () => {
      setIsMobile(mql.matches);
    };
    const addListener =
      "addEventListener" in mql
        ? mql.addEventListener.bind(mql)
        : (mql as MediaQueryList).addListener?.bind(mql);
    const removeListener =
      "removeEventListener" in mql
        ? mql.removeEventListener.bind(mql)
        : (mql as MediaQueryList).removeListener?.bind(mql);

    addListener?.("change", onChange);
    setIsMobile(mql.matches);
    return () => removeListener?.("change", onChange);
  }, []);

  return isMobile;
}
