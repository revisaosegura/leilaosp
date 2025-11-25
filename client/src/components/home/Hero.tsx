"use client";

import { useEffect, useState } from "react";
import { Carousel } from "react-responsive-carousel";

const carouselSlides = [
  {
    id: 1,
    title: "Encontre o veículo ideal",
    description: "Explore carros, motos e caminhões disponíveis em todo o Brasil.",
    image:
      "https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1600&q=80",
  },
  {
    id: 2,
    title: "Ofertas em destaque",
    description: "Descubra oportunidades exclusivas com atualizações diárias.",
    image:
      "https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1600&q=80",
  },
  {
    id: 3,
    title: "Experiência mobile confiável",
    description: "Acompanhe seus lances de qualquer lugar sem problemas de renderização.",
    image:
      "https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1600&q=80",
  },
];

export function Hero() {
  const [isClient, setIsClient] = useState(false);

  useEffect(() => {
    setIsClient(true);
  }, []);

  return (
    <section className="relative">
      {isClient && (
        <Carousel
          className="overflow-hidden rounded-2xl"
          showThumbs={false}
          showStatus={false}
          infiniteLoop
          autoPlay
          interval={5000}
        >
          {carouselSlides.map((slide) => (
            <div key={slide.id} className="relative h-64 w-full md:h-96">
              <img
                src={slide.image}
                alt={slide.title}
                className="h-full w-full object-cover"
                loading="lazy"
              />
              <div className="absolute inset-x-0 bottom-0 bg-gradient-to-t from-black/70 to-transparent p-6 text-left text-white">
                <h2 className="text-2xl font-bold md:text-3xl">{slide.title}</h2>
                <p className="mt-2 text-sm md:text-base">{slide.description}</p>
              </div>
            </div>
          ))}
        </Carousel>
      )}
    </section>
  );
}
