import * as React from "react";

const MOBILE_BREAKPOINT = 768;

export function useIsMobile() {
  const [isMobile, setIsMobile] = React.useState<boolean | undefined>(
    undefined
  );

  React.useEffect(() => {
    if (typeof window === "undefined") {
      setIsMobile(false);
      return;
    }

    if (typeof window.matchMedia !== "function") {
      setIsMobile(window.innerWidth < MOBILE_BREAKPOINT);
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

  return !!isMobile;
}
