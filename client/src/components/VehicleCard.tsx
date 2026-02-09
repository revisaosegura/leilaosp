import { Link } from "wouter";
import { Card, CardContent } from "@/components/ui/card";
import { Veiculo } from "@/hooks/useCopartData";
import { handleVehicleImageError } from "@/utils/vehicleImages";

interface VehicleCardProps {
  veiculo: Veiculo;
}

/**
 * Resolve a imagem primária do veículo.
 * Lida com o formato de array de string do PostgreSQL (ex: "{url1,url2}")
 * e também com arrays de JS ou strings únicas.
 */
const getPrimaryImage = (imageSource: string | string[] | null | undefined): string => {
  const placeholder = "https://placehold.co/800x600/cccccc/FFFFFF/png?text=Sem+Imagem";

  if (!imageSource) {
    return placeholder;
  }

  // Caso 1: Já é um array de JS
  if (Array.isArray(imageSource)) {
    return imageSource[0] || placeholder;
  }

  // Caso 2: É uma string do PostgreSQL no formato "{url1,url2,...}"
  if (typeof imageSource === 'string' && imageSource.startsWith('{') && imageSource.endsWith('}')) {
    // Remove as chaves, divide por vírgula e pega a primeira URL
    const urls = imageSource.substring(1, imageSource.length - 1).split(',');
    // Remove aspas duplas se houver (ex: "{ \"url1\" }") e retorna
    return urls[0] ? urls[0].replace(/"/g, '') : placeholder;
  }

  // Caso 3: É uma string de URL única (ou um caminho local)
  return imageSource;
};

export default function VehicleCard({ veiculo }: VehicleCardProps) {
  return (
    <Link href={`/vehicle/${veiculo.id}`}>
      <Card className="hover:shadow-lg transition-shadow cursor-pointer">
        <div className="aspect-video bg-gray-200 relative overflow-hidden">
          <img
            src={getPrimaryImage(veiculo.imagem)}
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
