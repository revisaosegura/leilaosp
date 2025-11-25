import { Link } from "wouter";
import { Card, CardContent } from "@/components/ui/card";
import { Veiculo } from "@/hooks/useCopartData";
import { handleVehicleImageError, resolveVehiclePrimaryImage } from "@/utils/vehicleImages";

interface VehicleCardProps {
  veiculo: Veiculo;
}

export default function VehicleCard({ veiculo }: VehicleCardProps) {
  return (
    <Link href={`/vehicle/${veiculo.id}`}>
      <Card className="hover:shadow-lg transition-shadow cursor-pointer">
        <div className="aspect-video bg-gray-200 relative overflow-hidden">
          <img
            src={resolveVehiclePrimaryImage(veiculo.imagem)}
            alt={veiculo.descricao}
            className="w-full h-full object-cover"
            onError={handleVehicleImageError}
            loading="lazy"
          />
          {veiculo.destaque && (
            <div className="absolute top-2 right-2 bg-copart-orange text-white px-3 py-1 rounded-full text-xs font-bold">
              DESTAQUE
            </div>
          )}
        </div>
        <CardContent className="p-4">
          <h3 className="font-bold text-sm mb-2">
            {veiculo.descricao}
          </h3>
          <p className="text-sm text-gray-600 mb-2">Nº Lote {veiculo.lote}</p>
          <p className="text-sm font-semibold text-copart-blue mb-1">
            Lance Atual: R$ {veiculo.lanceAtual.toLocaleString('pt-BR')} {veiculo.moeda}
          </p>
          <p className="text-xs text-gray-500">
            Pátio Veículo: {veiculo.patio}
          </p>
        </CardContent>
      </Card>
    </Link>
  );
}
