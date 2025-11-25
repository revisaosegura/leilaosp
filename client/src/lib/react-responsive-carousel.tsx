import type { PropsWithChildren, ReactNode } from "react";

export type CarouselProps = PropsWithChildren<{
  className?: string;
  showThumbs?: boolean;
  showStatus?: boolean;
  infiniteLoop?: boolean;
  autoPlay?: boolean;
  interval?: number;
  renderIndicator?: (onClick: () => void, isSelected: boolean, index: number, label: string) => ReactNode;
}>;

// Minimal stand-in for the `react-responsive-carousel` component so the project
// can render without relying on the external dependency.
export function Carousel({ className, children }: CarouselProps) {
  return <div className={className}>{children}</div>;
}

export default Carousel;
