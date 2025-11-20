import { useRoute, Link } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { trpc } from "@/lib/trpc";
import { Loader2, MapPin, Calendar, FileText, Shield } from "lucide-react";
import { useAuth } from "@/_core/hooks/useAuth";
import { getLoginUrl } from "@/const";
import { toast } from "sonner";
import FavoriteButton from "@/components/FavoriteButton";

export default function VehicleDetail() {
  const [, params] = useRoute("/vehicle/:id");
  const vehicleId = params?.id ? parseInt(params.id) : 0;
  
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
      window.location.href = getLoginUrl();
      return;
    }

    const bidAmount = prompt("Digite o valor do seu lance:");
    if (bidAmount) {
      const amount = parseInt(bidAmount.replace(/\D/g, ""));
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

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="container py-8">
        <div className="grid lg:grid-cols-3 gap-8">
          {/* Main Content */}
          <div className="lg:col-span-2">
            {/* Image Gallery */}
            <Card className="mb-6">
              <div className="aspect-video bg-gray-200 relative overflow-hidden">
                {vehicle.imageUrl ? (
                  <img
                    src={vehicle.imageUrl}
                    alt={`${vehicle.year} ${vehicle.make} ${vehicle.model}`}
                    className="w-full h-full object-cover"
                  />
                ) : (
                  <div className="w-full h-full flex items-center justify-center text-gray-400">
                    Sem imagem disponível
                  </div>
                )}
              </div>
            </Card>

            {/* Vehicle Info */}
            <Card className="mb-6">
              <CardContent className="p-6">
                <h1 className="text-3xl font-bold text-copart-blue mb-2">
                  {vehicle.year} {vehicle.make} {vehicle.model}
                </h1>
                <p className="text-gray-600 mb-4">Lote Nº {vehicle.lotNumber}</p>

                <div className="grid md:grid-cols-2 gap-4 mb-6">
                  <div className="flex items-center gap-2 text-gray-700">
                    <Calendar size={20} />
                    <span>Ano: {vehicle.year}</span>
                  </div>
                  <div className="flex items-center gap-2 text-gray-700">
                    <MapPin size={20} />
                    <span>{location?.name || "Localização não disponível"}</span>
                  </div>
                  {vehicle.hasReport && (
                    <div className="flex items-center gap-2 text-green-600">
                      <FileText size={20} />
                      <span>Laudo Disponível</span>
                    </div>
                  )}
                  {vehicle.hasWarranty && (
                    <div className="flex items-center gap-2 text-blue-600">
                      <Shield size={20} />
                      <span>Com Garantia</span>
                    </div>
                  )}
                </div>

                {vehicle.description && (
                  <div>
                    <h3 className="font-bold text-lg mb-2">Descrição</h3>
                    <p className="text-gray-700">{vehicle.description}</p>
                  </div>
                )}
              </CardContent>
            </Card>
          </div>

          {/* Sidebar */}
          <div>
            <Card className="sticky top-4">
              <CardContent className="p-6">
                <div className="mb-6">
                  {vehicle.saleType === "auction" ? (
                    <>
                      <p className="text-sm text-gray-600 mb-2">Lance Atual</p>
                      <p className="text-3xl font-bold text-copart-blue mb-4">
                        R$ {vehicle.currentBid.toLocaleString("pt-BR")}
                      </p>
                      <Button
                        onClick={handleBid}
                        className="w-full bg-copart-orange hover:bg-yellow-600 text-white mb-3"
                        disabled={createBid.isPending}
                      >
                        {createBid.isPending ? "Processando..." : "Dar Lance"}
                      </Button>
                    </>
                  ) : (
                    <>
                      <p className="text-sm text-gray-600 mb-2">Preço</p>
                      <p className="text-3xl font-bold text-copart-orange mb-4">
                        R$ {vehicle.buyNowPrice?.toLocaleString("pt-BR")}
                      </p>
                      <Button className="w-full bg-copart-orange hover:bg-yellow-600 text-white mb-3">
                        Comprar Agora
                      </Button>
                    </>
                  )}
                  
                  <Button variant="outline" className="w-full mb-3">
                    Fazer Oferta
                  </Button>
                  
                  <FavoriteButton vehicleId={vehicle.id} variant="default" />
                </div>

                <div className="border-t pt-6">
                  <h3 className="font-bold mb-3">Informações do Veículo</h3>
                  <div className="space-y-2 text-sm">
                    <div className="flex justify-between">
                      <span className="text-gray-600">Status:</span>
                      <span className="font-medium capitalize">{vehicle.status}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-gray-600">Tipo de Venda:</span>
                      <span className="font-medium">
                        {vehicle.saleType === "auction" ? "Leilão" : "Venda Direta"}
                      </span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-gray-600">Pátio:</span>
                      <span className="font-medium">{location?.city}, {location?.state}</span>
                    </div>
                  </div>
                </div>

                {!user && (
                  <div className="border-t pt-6 mt-6">
                    <p className="text-sm text-gray-600 mb-3">
                      Faça login para dar lances ou comprar
                    </p>
                    <a href={getLoginUrl()}>
                      <Button variant="outline" className="w-full">
                        Entrar
                      </Button>
                    </a>
                  </div>
                )}
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
}
