import { useRoute, Link } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { trpc } from "@/lib/trpc";
import { Loader2, MapPin, Calendar, FileText, Shield, Heart, Share2, Printer, ChevronLeft, ChevronRight } from "lucide-react";
import { useAuth } from "@/_core/hooks/useAuth";
import { toast } from "sonner";
import FavoriteButton from "@/components/FavoriteButton";
import { useState } from "react";

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
    return new Intl.NumberFormat('pt-BR', {
      style: 'currency',
      currency: 'BRL'
    }).format(value);
  };

  const images = vehicle.images && vehicle.images.length > 0 
    ? vehicle.images 
    : [`https://placehold.co/800x600/0066CC/FFFFFF/png?text=${vehicle.make}+${vehicle.model}`];

  const nextImage = () => {
    setCurrentImageIndex((prev) => (prev + 1) % images.length);
  };

  const prevImage = () => {
    setCurrentImageIndex((prev) => (prev - 1 + images.length) % images.length);
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Breadcrumb */}
      <div className="bg-white border-b">
        <div className="container py-3">
          <div className="flex items-center gap-2 text-sm text-gray-600">
            <Link href="/" className="hover:text-copart-blue">Início</Link>
            <span>/</span>
            <Link href="/find-vehicle" className="hover:text-copart-blue">Encontrar Veículo</Link>
            <span>/</span>
            <span className="text-gray-900">Lote {vehicle.lotNumber}</span>
          </div>
        </div>
      </div>

      <div className="container py-6">
        <div className="grid lg:grid-cols-3 gap-6">
          {/* Coluna Principal - Imagens e Detalhes */}
          <div className="lg:col-span-2 space-y-6">
            {/* Galeria de Imagens */}
            <Card>
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
                            className="absolute left-4 top-1/2 -translate-y-1/2 bg-black/50 hover:bg-black/70 text-white p-2 rounded-full"
                          >
                            <ChevronLeft size={24} />
                          </button>
                          <button
                            onClick={nextImage}
                            className="absolute right-4 top-1/2 -translate-y-1/2 bg-black/50 hover:bg-black/70 text-white p-2 rounded-full"
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
                
                {/* Miniaturas */}
                {images.length > 1 && (
                  <div className="p-4 bg-gray-100 flex gap-2 overflow-x-auto">
                    {images.map((img, idx) => (
                      <button
                        key={idx}
                        onClick={() => setCurrentImageIndex(idx)}
                        className={`flex-shrink-0 w-20 h-20 border-2 rounded overflow-hidden ${
                          idx === currentImageIndex ? 'border-copart-blue' : 'border-gray-300'
                        }`}
                      >
                        <img src={img} alt={`Thumbnail ${idx + 1}`} className="w-full h-full object-cover" />
                      </button>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Informações do Veículo */}
            <Card>
              <CardContent className="p-6">
                <div className="flex items-start justify-between mb-4">
                  <div>
                    <h1 className="text-3xl font-bold text-copart-blue mb-2">
                      {vehicle.year} {vehicle.make} {vehicle.model}
                    </h1>
                    <div className="flex items-center gap-4 text-sm text-gray-600">
                      <span className="font-semibold">Lote: {vehicle.lotNumber}</span>
                      <span>VIN: {vehicle.vin}</span>
                    </div>
                  </div>
                  <div className="flex gap-2">
                    <FavoriteButton vehicleId={vehicle.id} />
                    <Button variant="outline" size="icon">
                      <Share2 size={18} />
                    </Button>
                    <Button variant="outline" size="icon">
                      <Printer size={18} />
                    </Button>
                  </div>
                </div>

                {/* Grid de Informações */}
                <div className="grid md:grid-cols-2 gap-4 py-4 border-t border-b">
                  <div>
                    <span className="text-gray-600 text-sm">Tipo de Documento:</span>
                    <p className="font-semibold">{vehicle.titleStatus || 'N/A'}</p>
                  </div>
                  <div>
                    <span className="text-gray-600 text-sm">Danos Primários:</span>
                    <p className="font-semibold">{vehicle.damageDescription || 'N/A'}</p>
                  </div>
                  <div>
                    <span className="text-gray-600 text-sm">Combustível:</span>
                    <p className="font-semibold">{vehicle.fuelType || 'N/A'}</p>
                  </div>
                  <div>
                    <span className="text-gray-600 text-sm">Transmissão:</span>
                    <p className="font-semibold">{vehicle.transmission || 'N/A'}</p>
                  </div>
                  <div>
                    <span className="text-gray-600 text-sm">Cor:</span>
                    <p className="font-semibold">{vehicle.color || 'N/A'}</p>
                  </div>
                  <div>
                    <span className="text-gray-600 text-sm">Motor:</span>
                    <p className="font-semibold">{vehicle.engine || 'N/A'}</p>
                  </div>
                  <div>
                    <span className="text-gray-600 text-sm">Quilometragem:</span>
                    <p className="font-semibold">
                      {vehicle.mileage > 0 ? `${vehicle.mileage.toLocaleString('pt-BR')} km` : 'N/A'}
                    </p>
                  </div>
                  <div>
                    <span className="text-gray-600 text-sm">Localização:</span>
                    <p className="font-semibold flex items-center gap-1">
                      <MapPin size={16} />
                      {location?.name || 'N/A'}
                    </p>
                  </div>
                </div>

                {/* Descrição */}
                {vehicle.description && (
                  <div className="mt-4">
                    <h3 className="font-semibold mb-2">Descrição:</h3>
                    <p className="text-gray-700">{vehicle.description}</p>
                  </div>
                )}

                {/* Destaques */}
                {vehicle.highlights && (
                  <div className="mt-4">
                    <h3 className="font-semibold mb-2">Destaques:</h3>
                    <p className="text-gray-700">{vehicle.highlights}</p>
                  </div>
                )}
              </CardContent>
            </Card>
          </div>

          {/* Coluna Lateral - Informações de Lance */}
          <div className="lg:col-span-1">
            <div className="sticky top-4 space-y-4">
              {/* Card de Lance */}
              <Card className="border-2 border-copart-blue">
                <CardContent className="p-6">
                  <div className="mb-4">
                    <div className="flex items-center justify-between mb-2">
                      <span className="text-sm text-gray-600">Lance Atual:</span>
                      <span className="text-2xl font-bold text-copart-blue">
                        {formatCurrency(vehicle.currentBid)}
                      </span>
                    </div>
                    {vehicle.estimatedValue > 0 && (
                      <div className="flex items-center justify-between text-sm">
                        <span className="text-gray-600">Valor Estimado:</span>
                        <span className="font-semibold">{formatCurrency(vehicle.estimatedValue)}</span>
                      </div>
                    )}
                  </div>

                  <div className="space-y-3">
                    <Button 
                      onClick={handleBid} 
                      className="w-full bg-copart-orange hover:bg-yellow-600 text-white font-semibold py-6 text-lg"
                    >
                      Fazer Lance
                    </Button>
                    
                    {vehicle.buyNowPrice > 0 && (
                      <Button 
                        variant="outline" 
                        className="w-full border-copart-blue text-copart-blue hover:bg-copart-blue hover:text-white py-6"
                      >
                        Comprar Agora - {formatCurrency(vehicle.buyNowPrice)}
                      </Button>
                    )}
                  </div>

                  <div className="mt-6 pt-6 border-t space-y-3">
                    <div className="flex items-center gap-2 text-sm">
                      <Calendar size={16} className="text-gray-600" />
                      <div>
                        <p className="text-gray-600">Data do Leilão:</p>
                        <p className="font-semibold">
                          {vehicle.auctionDate 
                            ? new Date(vehicle.auctionDate).toLocaleDateString('pt-BR', {
                                day: '2-digit',
                                month: '2-digit',
                                year: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit'
                              })
                            : 'A definir'}
                        </p>
                      </div>
                    </div>

                    <div className="flex items-center gap-2 text-sm">
                      <MapPin size={16} className="text-gray-600" />
                      <div>
                        <p className="text-gray-600">Pátio:</p>
                        <p className="font-semibold">{location?.name || 'N/A'}</p>
                      </div>
                    </div>

                    <div className="flex items-center gap-2 text-sm">
                      <Shield size={16} className="text-gray-600" />
                      <div>
                        <p className="text-gray-600">Status:</p>
                        <p className="font-semibold capitalize">{vehicle.status}</p>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>

              {/* Informações Adicionais */}
              <Card>
                <CardContent className="p-6">
                  <h3 className="font-semibold mb-4 flex items-center gap-2">
                    <FileText size={18} />
                    Informações Importantes
                  </h3>
                  <ul className="space-y-2 text-sm text-gray-700">
                    <li>• Todos os lances são vinculantes</li>
                    <li>• Inspeção recomendada antes do lance</li>
                    <li>• Taxas adicionais podem ser aplicadas</li>
                    <li>• Veículo vendido no estado em que se encontra</li>
                  </ul>
                </CardContent>
              </Card>

              {/* Botão de Contato */}
              <Card className="bg-copart-blue text-white">
                <CardContent className="p-6 text-center">
                  <h3 className="font-semibold mb-2">Precisa de Ajuda?</h3>
                  <p className="text-sm mb-4">Entre em contato com nossa equipe</p>
                  <Button variant="outline" className="w-full bg-white text-copart-blue hover:bg-gray-100">
                    Falar com Suporte
                  </Button>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
