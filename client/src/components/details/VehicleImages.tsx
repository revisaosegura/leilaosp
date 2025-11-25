"use client";

import { useEffect, useState } from "react";
import { Carousel } from "react-responsive-carousel";

export type VehicleImagesProps = {
  images: string[];
  make: string;
  model: string;
};

export function VehicleImages({ images, make, model }: VehicleImagesProps) {
  const [isClient, setIsClient] = useState(false);

  useEffect(() => {
    setIsClient(true);
  }, []);

  if (!images?.length) {
    return null;
  }

  return (
    <div className="w-full">
      {isClient && (
        <Carousel className="overflow-hidden rounded-xl" showThumbs={false} showStatus={false} infiniteLoop>
          {images.map((image, index) => (
            <div key={`${make}-${model}-${index}`} className="relative aspect-video w-full">
              <img src={image} alt={`${make} ${model}`} className="h-full w-full object-cover" loading="lazy" />
            </div>
          ))}
        </Carousel>
      )}
    </div>
  );
}
