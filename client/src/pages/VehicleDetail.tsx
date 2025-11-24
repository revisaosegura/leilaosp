import { useState } from "react";
import { Link, useRoute } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import FavoriteButton from "@/components/FavoriteButton";
import { useAuth } from "@/_core/hooks/useAuth";
import { trpc } from "@/lib/trpc";
import {
  Calendar,
  ChevronLeft,
  ChevronRight,
  Clock,
  FileText,
  Loader2,
  MapPin,
  Printer,
  Share2,
  Shield,
} from "lucide-react";
import { toast } from "sonner";

export default function VehicleDetail() {
  const [, params] = useRoute("/vehicle/:id");
  const vehicleId = params?.id ? parseInt(params.id) : 0;
  const [currentImageIndex, setCurrentImageIndex] = useState(0);

  const { user } = useAuth();
  const { data: vehicle, isLoading } = trpc.vehicles.getById.useQuery({ id: vehicleId });
  const { data: locations } = trpc.locations.list.useQuery();

  const createBid = trpc.bids.create.useMutation({
    onSuccess: () => {
      toast.success("Lance realizado com sucesso!");
    },
    onError: (error) => {
      toast.error(error.message || "Erro ao realizar lance");
    },
  });

  const location = locations?.find((loc) => loc.id === vehicle?.locationId);

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="animate-spin" size={48} />
      </div>
    );
  }

  if (!vehicle) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-4">Veículo não encontrado</h1>
          <Link href="/find-vehicle">
            <Button>Voltar para busca</Button>
          </Link>
        </div>
      </div>
    );
  }

  const handleBid = () => {
    if (!user) {
      window.location.href = "/login";
      return;
    }

    const bidAmount = prompt("Digite o valor do seu lance (em BRL):");
    if (bidAmount) {
      const amount = parseFloat(bidAmount.replace(/\D/g, ""));
      if (amount > vehicle.currentBid) {
        createBid.mutate({
          vehicleId: vehicle.id,
          amount,
          bidType: "preliminary",
        });
      } else {
        toast.error("O lance deve ser maior que o lance atual");
      }
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(value);
  };

  const images =
    vehicle.images && vehicle.images.length > 0
      ? vehicle.images
      : vehicle.imageUrl
        ? [vehicle.imageUrl]
        : [`https://placehold.co/800x600/0066CC/FFFFFF/png?text=${vehicle.make}+${vehicle.model}`];

  const nextImage = () => {
    setCurrentImageIndex((prev) => (prev + 1) % images.length);
  };

  const prevImage = () => {
    setCurrentImageIndex((prev) => (prev - 1 + images.length) % images.length);
  };

  const locationLabel = location
    ? `${location.name} - ${location.city}/${location.state}`
    : "Localização indisponível";

  const auctionDate = vehicle.auctionDate ? new Date(vehicle.auctionDate) : undefined;
  const formattedAuctionDate = auctionDate
    ? auctionDate.toLocaleDateString("pt-BR", {
        day: "2-digit",
        month: "2-digit",
        year: "numeric",
        hour: "2-digit",
        minute: "2-digit",
      })
    : "A definir";

  const infoRows = [
    { label: "Código", value: vehicle.lotNumber },
    { label: "Marca", value: vehicle.make },
    { label: "Modelo", value: vehicle.model },
    { label: "Ano Mod/Modelo", value: `${vehicle.year}/${vehicle.year}` },
    { label: "Localização", value: locationLabel },
    { label: "Situação", value: vehicle.saleType === "direct" ? "Venda Direta" : "Leilão" },
    { label: "Status", value: vehicle.status || "N/A" },
    { label: "Pátio do Leilão", value: location?.name || "N/A" },
  ];

  const characteristicRows = [
    { label: "Combustível", value: (vehicle as any).fuelType || "N/A" },
    { label: "Transmissão", value: (vehicle as any).transmission || "N/A" },
    { label: "Motor", value: (vehicle as any).engine || "N/A" },
    {
      label: "Quilometragem",
      value: vehicle.mileage && vehicle.mileage > 0 ? `${vehicle.mileage.toLocaleString("pt-BR")} km` : "N/A",
    },
    { label: "Cor", value: (vehicle as any).color || "N/A" },
    { label: "Garantia", value: vehicle.hasWarranty ? "Possui" : "Não possui" },
  ];

  const renderRows = (rows: { label: string; value: string }[]) => (
    <dl className="divide-y divide-gray-100">
      {rows.map((row) => (
        <div key={row.label} className="flex items-center justify-between gap-3 py-2">
          <dt className="text-sm text-gray-500">{row.label}</dt>
          <dd className="text-sm font-semibold text-gray-900 text-right">{row.value}</dd>
        </div>
      ))}
    </dl>
  );

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="bg-white border-b shadow-sm">
        <div className="container py-4 flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
          <div className="space-y-2">
            <p className="text-sm text-gray-500 uppercase tracking-wide">
              {vehicle.saleType === "direct" ? "Venda Direta" : "Leilão Online"}
            </p>
            <div className="flex flex-wrap items-center gap-3">
              <h1 className="text-3xl md:text-4xl font-bold text-copart-blue">
                {vehicle.year} {vehicle.make} {vehicle.model}
              </h1>
              <span className="px-3 py-1 bg-gray-100 rounded-full text-sm font-semibold text-gray-700">
                Lote {vehicle.lotNumber}
              </span>
            </div>
            <div className="flex flex-wrap items-center gap-3 text-sm text-gray-700">
              <span className="flex items-center gap-1 text-copart-blue">
                <MapPin size={16} /> {locationLabel}
              </span>
              <span className="px-2 py-1 bg-blue-50 text-copart-blue text-xs font-semibold rounded-full capitalize">
                {vehicle.status}
              </span>
            </div>
          </div>

          <div className="flex flex-col items-start lg:items-end gap-3">
            <div className="text-left lg:text-right">
              <p className="text-sm text-gray-500">Lance Atual</p>
              <p className="text-3xl font-bold text-copart-blue">{formatCurrency(vehicle.currentBid)}</p>
              {vehicle.buyNowPrice ? (
                <p className="text-sm text-gray-500">Comprar agora por {formatCurrency(vehicle.buyNowPrice)}</p>
              ) : null}
            </div>
            <div className="flex gap-2">
              <FavoriteButton vehicleId={vehicle.id} />
              <Button variant="outline" size="icon" className="border-copart-blue text-copart-blue">
                <Share2 size={18} />
              </Button>
              <Button variant="outline" size="icon" className="border-copart-blue text-copart-blue">
                <Printer size={18} />
              </Button>
            </div>
          </div>
        </div>
      </div>

      <div className="container py-8 space-y-6">
        <div className="grid lg:grid-cols-3 gap-6">
          <div className="lg:col-span-2 space-y-4">
            <Card className="overflow-hidden shadow-sm">
              <CardContent className="p-0">
                <div className="relative bg-black aspect-video">
                  {images.length > 0 && (
                    <>
                      <img
                        src={images[currentImageIndex]}
                        alt={`${vehicle.year} ${vehicle.make} ${vehicle.model}`}
                        className="w-full h-full object-contain"
                      />

                      {images.length > 1 && (
                        <>
                          <button
                            onClick={prevImage}
                            className="absolute left-4 top-1/2 -translate-y-1/2 bg-black/50 text-white p-2 rounded-full hover:bg-black/70"
                            aria-label="Imagem anterior"
                          >
                            <ChevronLeft size={24} />
                          </button>
                          <button
                            onClick={nextImage}
                            className="absolute right-4 top-1/2 -translate-y-1/2 bg-black/50 text-white p-2 rounded-full hover:bg-black/70"
                            aria-label="Próxima imagem"
                          >
                            <ChevronRight size={24} />
                          </button>
                          <div className="absolute bottom-4 left-1/2 -translate-x-1/2 bg-black/50 text-white px-3 py-1 rounded-full text-sm">
                            {currentImageIndex + 1} / {images.length}
                          </div>
                        </>
                      )}
                    </>
                  )}
                </div>

                {images.length > 1 && (
                  <div className="p-4 bg-gray-100 flex gap-2 overflow-x-auto">
                    {images.map((img, idx) => (
                      <button
                        key={idx}
                        onClick={() => setCurrentImageIndex(idx)}
                        className={`flex-shrink-0 w-24 h-20 border-2 rounded overflow-hidden ${
                          idx === currentImageIndex ? "border-copart-blue" : "border-gray-300"
                        }`}
                        aria-label={`Selecionar imagem ${idx + 1}`}
                      >
                        <img src={img} alt={`Thumbnail ${idx + 1}`} className="w-full h-full object-cover" />
                      </button>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>

            <Card className="shadow-sm">
              <CardContent className="p-0">
                <div className="grid md:grid-cols-2 divide-y md:divide-y-0 md:divide-x divide-gray-100">
                  <div className="p-6 space-y-4">
                    <div className="flex items-center justify-between">
                      <h3 className="text-lg font-semibold text-copart-blue">Informações do Veículo</h3>
                      <span className="text-xs text-gray-500">Glossário</span>
                    </div>
                    {renderRows(infoRows.slice(0, 4))}
                  </div>
                  <div className="p-6 space-y-4">
                    <h3 className="text-lg font-semibold text-copart-blue">Detalhes do Lote</h3>
                    {renderRows(infoRows.slice(4))}
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card className="shadow-sm">
              <CardContent className="p-6 space-y-6">
                <div className="grid md:grid-cols-2 gap-6">
                  <div className="space-y-4">
                    <div className="flex items-center gap-2 text-copart-blue">
                      <Shield size={18} />
                      <h3 className="text-lg font-semibold">Características</h3>
                    </div>
                    {renderRows(characteristicRows)}
                  </div>
                  <div className="space-y-4">
                    <div className="flex items-center gap-2 text-copart-blue">
                      <FileText size={18} />
                      <h3 className="text-lg font-semibold">Notas</h3>
                    </div>
                    <p className="text-sm text-gray-700 leading-relaxed">
                      {vehicle.description || "Sem observações adicionais sobre este lote."}
                    </p>
                    {vehicle.highlights && (
                      <div className="bg-blue-50 border border-copart-blue/30 rounded-lg p-4 text-sm text-copart-blue">
                        {vehicle.highlights}
                      </div>
                    )}
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>

          <div className="lg:col-span-1 space-y-4">
            <Card className="border-2 border-copart-blue shadow-sm">
              <CardContent className="p-6 space-y-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-gray-500">Lance Atual</p>
                    <p className="text-3xl font-bold text-copart-blue">{formatCurrency(vehicle.currentBid)}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-xs text-gray-500">Hora Local</p>
                    <p className="font-semibold text-gray-800">
                      {new Date().toLocaleString("pt-BR", { hour: "2-digit", minute: "2-digit" })}
                    </p>
                  </div>
                </div>

                <div className="space-y-2 text-sm text-gray-700">
                  <div className="flex items-center justify-between">
                    <span>Lance Preliminar</span>
                    <span className="font-semibold">{formatCurrency(vehicle.currentBid)}</span>
                  </div>
                  <div className="flex items-center justify-between">
                    <span>Lance Inicial</span>
                    <span className="font-semibold">R$ 0,00</span>
                  </div>
                  {vehicle.buyNowPrice ? (
                    <div className="flex items-center justify-between text-copart-blue font-semibold">
                      <span>Comprar Agora</span>
                      <span>{formatCurrency(vehicle.buyNowPrice)}</span>
                    </div>
                  ) : null}
                </div>

                <div className="space-y-3">
                  <Button
                    onClick={handleBid}
                    className="w-full bg-copart-orange hover:bg-yellow-600 text-white font-semibold py-6 text-lg"
                  >
                    Dar Lance Agora
                  </Button>
                  {vehicle.buyNowPrice ? (
                    <Button
                      variant="outline"
                      className="w-full border-copart-blue text-copart-blue hover:bg-copart-blue hover:text-white py-6"
                    >
                      Comprar Agora - {formatCurrency(vehicle.buyNowPrice)}
                    </Button>
                  ) : null}
                </div>

                <div className="pt-4 border-t space-y-3 text-sm text-gray-700">
                  <div className="flex items-center gap-2">
                    <Calendar size={16} className="text-copart-blue" />
                    <div>
                      <p className="text-gray-500">Data do Leilão</p>
                      <p className="font-semibold">{formattedAuctionDate}</p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2">
                    <MapPin size={16} className="text-copart-blue" />
                    <div>
                      <p className="text-gray-500">Pátio</p>
                      <p className="font-semibold">{location?.name || "N/A"}</p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2">
                    <Shield size={16} className="text-copart-blue" />
                    <div>
                      <p className="text-gray-500">Status</p>
                      <p className="font-semibold capitalize">{vehicle.status}</p>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card className="shadow-sm">
              <CardContent className="p-6 space-y-3 text-sm text-gray-700">
                <div className="flex items-center gap-2 text-copart-blue">
                  <Clock size={16} />
                  <h3 className="text-base font-semibold">Informações de Venda</h3>
                </div>
                <div className="flex items-center justify-between">
                  <span>Tipo de Venda</span>
                  <span className="font-semibold">
                    {vehicle.saleType === "direct" ? "Venda Direta" : "Leilão Online"}
                  </span>
                </div>
                <div className="flex items-center justify-between">
                  <span>Categoria</span>
                  <span className="font-semibold">{vehicle.categoryId ? `Categoria #${vehicle.categoryId}` : "N/A"}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span>Relatório</span>
                  <span className="font-semibold">{vehicle.hasReport ? "Disponível" : "Não disponível"}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span>Garantia</span>
                  <span className="font-semibold">{vehicle.hasWarranty ? "Disponível" : "Não disponível"}</span>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-copart-blue text-white shadow-sm">
              <CardContent className="p-6 space-y-2 text-center">
                <h3 className="text-lg font-semibold">Precisa de ajuda?</h3>
                <p className="text-sm text-blue-50">Entre em contato com nossa equipe de suporte para tirar dúvidas.</p>
                <Button variant="outline" className="w-full bg-white text-copart-blue hover:bg-gray-100">
                  Falar com Suporte
                </Button>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
}
