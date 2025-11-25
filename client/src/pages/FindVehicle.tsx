import { useState } from "react";
import { Link, useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { trpc } from "@/lib/trpc";
import { handleVehicleImageError, resolveVehiclePrimaryImage } from "@/utils/vehicleImages";
import { Loader2, Search } from "lucide-react";

export default function FindVehicle() {
  const [, setLocation] = useLocation();
  const searchParams = new URLSearchParams(window.location.search);
  const initialSearch = searchParams.get("search") || "";
  const initialCategory = searchParams.get("category") || "";

  const [searchQuery, setSearchQuery] = useState(initialSearch);
  const [selectedCategory, setSelectedCategory] = useState(initialCategory);
  const [saleType, setSaleType] = useState<"auction" | "direct" | "all">("all");

  const { data: categories } = trpc.categories.list.useQuery();
  const { data: vehicles, isLoading } = trpc.vehicles.list.useQuery({
    search: searchQuery || undefined,
    categoryId: selectedCategory ? parseInt(selectedCategory) : undefined,
    saleType: saleType === "all" ? undefined : saleType,
    limit: 50,
  });

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    const params = new URLSearchParams();
    if (searchQuery) params.set("search", searchQuery);
    if (selectedCategory) params.set("category", selectedCategory);
    setLocation(`/find-vehicle?${params.toString()}`);
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <section className="bg-copart-blue text-white py-12">
        <div className="container">
          <h1 className="text-4xl font-bold mb-4">Encontrar um Veículo</h1>
          <p className="text-lg">Navegue por mais de 10.000 veículos disponíveis</p>
        </div>
      </section>

      {/* Search & Filters */}
      <section className="bg-white py-6 border-b">
        <div className="container">
          <form onSubmit={handleSearch} className="grid md:grid-cols-4 gap-4">
            <div className="md:col-span-2">
              <div className="relative">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" size={20} />
                <Input
                  type="text"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  placeholder="Buscar por marca, modelo, chassis..."
                  className="pl-10"
                />
              </div>
            </div>

            <Select value={selectedCategory} onValueChange={setSelectedCategory}>
              <SelectTrigger>
                <SelectValue placeholder="Categoria" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">Todas as Categorias</SelectItem>
                {categories?.map((cat) => (
                  <SelectItem key={cat.id} value={cat.id.toString()}>
                    {cat.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>

            <Select value={saleType} onValueChange={(value: any) => setSaleType(value)}>
              <SelectTrigger>
                <SelectValue placeholder="Tipo de Venda" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">Todos</SelectItem>
                <SelectItem value="auction">Leilão</SelectItem>
                <SelectItem value="direct">Venda Direta</SelectItem>
              </SelectContent>
            </Select>
          </form>
        </div>
      </section>

      {/* Results */}
      <section className="py-12">
        <div className="container">
          {isLoading ? (
            <div className="flex justify-center py-20">
              <Loader2 className="animate-spin" size={48} />
            </div>
          ) : vehicles && vehicles.length > 0 ? (
            <>
              <div className="mb-6">
                <p className="text-gray-600">
                  Encontrados <strong>{vehicles.length}</strong> veículos
                </p>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-6">
                {vehicles.map((vehicle) => (
                  <Link key={vehicle.id} href={`/vehicle/${vehicle.id}`}>
                    <Card className="hover:shadow-lg transition-shadow h-full">
                      <div className="aspect-video bg-gray-200 relative overflow-hidden">
                        <img
                          src={resolveVehiclePrimaryImage(vehicle.imageUrl, vehicle.images)}
                          alt={`${vehicle.year} ${vehicle.make} ${vehicle.model}`}
                          className="w-full h-full object-cover"
                          loading="lazy"
                          onError={handleVehicleImageError}
                        />
                        {vehicle.saleType === "direct" && (
                          <div className="absolute top-2 right-2 bg-copart-orange text-white px-2 py-1 text-xs font-bold rounded">
                            VENDA DIRETA
                          </div>
                        )}
                      </div>
                      <CardContent className="p-4">
                        <h3 className="font-bold text-sm mb-2 line-clamp-2">
                          {vehicle.year} {vehicle.make} {vehicle.model}
                        </h3>
                        <p className="text-xs text-gray-600 mb-2">Nº Lote {vehicle.lotNumber}</p>
                        {vehicle.saleType === "auction" ? (
                          <p className="text-sm font-semibold text-copart-blue">
                            Lance Atual: R$ {vehicle.currentBid.toLocaleString("pt-BR")}
                          </p>
                        ) : (
                          <p className="text-sm font-semibold text-copart-orange">
                            Compre Agora: R$ {vehicle.buyNowPrice?.toLocaleString("pt-BR")}
                          </p>
                        )}
                        <div className="mt-2 flex gap-2">
                          {vehicle.hasWarranty && (
                            <span className="text-xs bg-green-100 text-green-800 px-2 py-1 rounded">
                              Garantia
                            </span>
                          )}
                          {vehicle.hasReport && (
                            <span className="text-xs bg-blue-100 text-blue-800 px-2 py-1 rounded">
                              Laudo
                            </span>
                          )}
                        </div>
                      </CardContent>
                    </Card>
                  </Link>
                ))}
              </div>
            </>
          ) : (
            <div className="text-center py-20">
              <p className="text-gray-600 text-lg mb-4">Nenhum veículo encontrado</p>
              <Button onClick={() => {
                setSearchQuery("");
                setSelectedCategory("");
                setSaleType("all");
              }}>
                Limpar Filtros
              </Button>
            </div>
          )}
        </div>
      </section>
    </div>
  );
}
