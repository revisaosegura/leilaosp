"use client";

import { useEffect, useState } from "react";
import { Carousel } from "react-responsive-carousel";

export type FeaturedVehicle = {
  id: number | string;
  imageUrl: string;
  make: string;
  model: string;
  year?: number;
};

export type FeaturedVehiclesProps = {
  vehicles: FeaturedVehicle[];
};

export function FeaturedVehicles({ vehicles }: FeaturedVehiclesProps) {
  const [isClient, setIsClient] = useState(false);

  useEffect(() => {
    setIsClient(true);
  }, []);

  if (!vehicles?.length) {
    return null;
  }

  return (
    <section className="space-y-6">
      <div className="hidden grid-cols-3 gap-4 md:grid">
        {vehicles.map((vehicle) => (
          <article key={vehicle.id} className="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
            <img
              src={vehicle.imageUrl}
              alt={`${vehicle.make} ${vehicle.model}`}
              className="h-48 w-full object-cover"
              loading="lazy"
            />
            <div className="p-4">
              <h3 className="text-lg font-semibold">
                {vehicle.make} {vehicle.model}
              </h3>
              {vehicle.year && <p className="text-sm text-slate-600">Ano {vehicle.year}</p>}
            </div>
          </article>
        ))}
      </div>

      <div className="md:hidden">
        {isClient && (
          <Carousel showThumbs={false} showStatus={false} infiniteLoop>
            {vehicles.map((vehicle) => (
              <div key={vehicle.id} className="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
                <img
                  src={vehicle.imageUrl}
                  alt={`${vehicle.make} ${vehicle.model}`}
                  className="h-56 w-full object-cover"
                  loading="lazy"
                />
                <div className="p-4">
                  <h3 className="text-lg font-semibold">
                    {vehicle.make} {vehicle.model}
                  </h3>
                  {vehicle.year && <p className="text-sm text-slate-600">Ano {vehicle.year}</p>}
                </div>
              </div>
            ))}
          </Carousel>
        )}
      </div>
    </section>
  );
}
