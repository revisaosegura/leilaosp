import { Link } from "wouter";
import { Card, CardContent } from "@/components/ui/card";
import { Veiculo } from "@/hooks/useCopartData";

interface VehicleCardProps {
  veiculo: Veiculo;
}

export default function VehicleCard({ veiculo }: VehicleCardProps) {
  return (
    <Link href={`/vehicle/${veiculo.id}`}>
      <Card className="hover:shadow-lg transition-shadow cursor-pointer">
        <div className="aspect-video bg-gray-200 relative overflow-hidden">
          {veiculo.imagem ? (
            <img
              src={veiculo.imagem}
              alt={veiculo.descricao}
              className="w-full h-full object-cover"
              onError={(e) => {
                const target = e.target as HTMLImageElement;
                target.style.display = 'none';
                const parent = target.parentElement;
                if (parent) {
                  parent.innerHTML = '<div class="w-full h-full flex items-center justify-center text-gray-400">Sem imagem</div>';
                }
              }}
            />
          ) : (
            <div className="w-full h-full flex items-center justify-center text-gray-400">
              Sem imagem
            </div>
          )}
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
