import { useAuth } from "@/_core/hooks/useAuth";
import { trpc } from "@/lib/trpc";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Loader2, User, Heart, Gavel, Edit2, Save, X } from "lucide-react";
import { useState } from "react";
import { Link } from "wouter";
import VehicleCard from "@/components/VehicleCard";
import { toast } from "sonner";

export default function UserDashboard() {
  const { user, loading: authLoading } = useAuth({ redirectOnUnauthenticated: true });
  const [isEditing, setIsEditing] = useState(false);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");

  const { data: profile, refetch: refetchProfile } = trpc.user.profile.useQuery(undefined, {
    enabled: !!user,
  });

  const { data: favorites, isLoading: favoritesLoading } = trpc.favorites.list.useQuery(undefined, {
    enabled: !!user,
  });

  const { data: myBids, isLoading: bidsLoading } = trpc.user.myBids.useQuery(undefined, {
    enabled: !!user,
  });

  const updateProfileMutation = trpc.user.updateProfile.useMutation({
    onSuccess: () => {
      toast.success("Perfil atualizado com sucesso!");
      setIsEditing(false);
      refetchProfile();
    },
    onError: (error) => {
      toast.error("Erro ao atualizar perfil: " + error.message);
    },
  });

  const removeFavoriteMutation = trpc.favorites.remove.useMutation({
    onSuccess: () => {
      toast.success("Veículo removido dos favoritos!");
      trpc.useUtils().favorites.list.invalidate();
    },
    onError: (error) => {
      toast.error("Erro ao remover favorito: " + error.message);
    },
  });

  const handleEditProfile = () => {
    if (profile) {
      setName(profile.name || "");
      setEmail(profile.email || "");
      setIsEditing(true);
    }
  };

  const handleSaveProfile = () => {
    updateProfileMutation.mutate({
      name: name || undefined,
      email: email || undefined,
    });
  };

  const handleCancelEdit = () => {
    setIsEditing(false);
    setName(profile?.name || "");
    setEmail(profile?.email || "");
  };

  const handleRemoveFavorite = (vehicleId: number) => {
    if (confirm("Deseja remover este veículo dos favoritos?")) {
      removeFavoriteMutation.mutate({ vehicleId });
    }
  };

  if (authLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <Loader2 className="animate-spin" size={48} />
      </div>
    );
  }

  if (!user) {
    return null;
  }

  return (
    <div className="min-h-screen bg-gray-50 py-8">
      <div className="container max-w-6xl">
        <h1 className="text-3xl font-bold text-copart-blue mb-8">Meu Painel</h1>

        <Tabs defaultValue="profile" className="space-y-6">
          <TabsList className="grid w-full grid-cols-3">
            <TabsTrigger value="profile" className="flex items-center gap-2">
              <User size={18} />
              Meu Perfil
            </TabsTrigger>
            <TabsTrigger value="bids" className="flex items-center gap-2">
              <Gavel size={18} />
              Meus Lances
            </TabsTrigger>
            <TabsTrigger value="favorites" className="flex items-center gap-2">
              <Heart size={18} />
              Favoritos
            </TabsTrigger>
          </TabsList>

          {/* Profile Tab */}
          <TabsContent value="profile">
            <Card>
              <CardHeader className="flex flex-row items-center justify-between">
                <CardTitle>Informações do Perfil</CardTitle>
                {!isEditing && (
                  <Button onClick={handleEditProfile} variant="outline" size="sm">
                    <Edit2 size={16} className="mr-2" />
                    Editar
                  </Button>
                )}
              </CardHeader>
              <CardContent className="space-y-4">
                {profile && (
                  <>
                    <div className="space-y-2">
                      <Label htmlFor="name">Nome</Label>
                      {isEditing ? (
                        <Input
                          id="name"
                          value={name}
                          onChange={(e) => setName(e.target.value)}
                          placeholder="Seu nome completo"
                        />
                      ) : (
                        <p className="text-lg">{profile.name || "Não informado"}</p>
                      )}
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="email">Email</Label>
                      {isEditing ? (
                        <Input
                          id="email"
                          type="email"
                          value={email}
                          onChange={(e) => setEmail(e.target.value)}
                          placeholder="seu@email.com"
                        />
                      ) : (
                        <p className="text-lg">{profile.email || "Não informado"}</p>
                      )}
                    </div>

                    <div className="space-y-2">
                      <Label>Método de Login</Label>
                      <p className="text-lg capitalize">{profile.loginMethod || "Não disponível"}</p>
                    </div>

                    <div className="space-y-2">
                      <Label>Membro desde</Label>
                      <p className="text-lg">
                        {new Date(profile.createdAt).toLocaleDateString("pt-BR")}
                      </p>
                    </div>

                    <div className="space-y-2">
                      <Label>Último acesso</Label>
                      <p className="text-lg">
                        {new Date(profile.lastSignedIn).toLocaleDateString("pt-BR")}
                      </p>
                    </div>

                    {isEditing && (
                      <div className="flex gap-3 pt-4">
                        <Button
                          onClick={handleSaveProfile}
                          disabled={updateProfileMutation.isPending}
                          className="bg-copart-blue hover:bg-blue-700"
                        >
                          {updateProfileMutation.isPending ? (
                            <>
                              <Loader2 className="animate-spin mr-2" size={16} />
                              Salvando...
                            </>
                          ) : (
                            <>
                              <Save size={16} className="mr-2" />
                              Salvar Alterações
                            </>
                          )}
                        </Button>
                        <Button
                          onClick={handleCancelEdit}
                          variant="outline"
                          disabled={updateProfileMutation.isPending}
                        >
                          <X size={16} className="mr-2" />
                          Cancelar
                        </Button>
                      </div>
                    )}
                  </>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          {/* Bids Tab */}
          <TabsContent value="bids">
            <Card>
              <CardHeader>
                <CardTitle>Meus Lances</CardTitle>
              </CardHeader>
              <CardContent>
                {bidsLoading ? (
                  <div className="flex justify-center py-12">
                    <Loader2 className="animate-spin" size={48} />
                  </div>
                ) : myBids && myBids.length > 0 ? (
                  <div className="space-y-4">
                    {myBids.map((bid) => (
                      <div
                        key={bid.id}
                        className="border rounded-lg p-4 hover:shadow-md transition-shadow"
                      >
                        <div className="flex justify-between items-start">
                          <div className="flex-1">
                            <Link href={`/vehicle/${bid.vehicle.id}`}>
                              <h3 className="font-bold text-lg text-copart-blue hover:underline cursor-pointer">
                                {bid.vehicle.year} {bid.vehicle.make} {bid.vehicle.model}
                              </h3>
                            </Link>
                            <p className="text-sm text-gray-600 mt-1">
                              Lote: {bid.vehicle.lotNumber}
                            </p>
                            <div className="mt-3 flex gap-4 text-sm">
                              <div>
                                <span className="text-gray-600">Meu Lance:</span>
                                <span className="font-bold text-copart-orange ml-2">
                                  R$ {bid.amount.toLocaleString("pt-BR")}
                                </span>
                              </div>
                              <div>
                                <span className="text-gray-600">Lance Atual:</span>
                                <span className="font-bold ml-2">
                                  R$ {bid.vehicle.currentBid.toLocaleString("pt-BR")}
                                </span>
                              </div>
                              <div>
                                <span className="text-gray-600">Tipo:</span>
                                <span className="ml-2 capitalize">{bid.bidType}</span>
                              </div>
                            </div>
                            <p className="text-xs text-gray-500 mt-2">
                              Lance realizado em:{" "}
                              {new Date(bid.createdAt).toLocaleString("pt-BR")}
                            </p>
                          </div>
                          {bid.amount >= bid.vehicle.currentBid && (
                            <div className="bg-green-100 text-green-800 px-3 py-1 rounded-full text-xs font-bold">
                              Maior Lance
                            </div>
                          )}
                        </div>
                      </div>
                    ))}
                  </div>
                ) : (
                  <div className="text-center py-12">
                    <Gavel size={48} className="mx-auto text-gray-400 mb-4" />
                    <p className="text-gray-600 mb-4">Você ainda não fez nenhum lance</p>
                    <Link href="/find-vehicle">
                      <Button className="bg-copart-orange hover:bg-yellow-600">
                        Explorar Veículos
                      </Button>
                    </Link>
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          {/* Favorites Tab */}
          <TabsContent value="favorites">
            <Card>
              <CardHeader>
                <CardTitle>Veículos Favoritos</CardTitle>
              </CardHeader>
              <CardContent>
                {favoritesLoading ? (
                  <div className="flex justify-center py-12">
                    <Loader2 className="animate-spin" size={48} />
                  </div>
                ) : favorites && favorites.length > 0 ? (
                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {favorites.map((vehicle) => (
                      <div key={vehicle.id} className="relative">
                        <VehicleCard
                          veiculo={{
                            id: vehicle.id,
                            lote: vehicle.lotNumber,
                            ano: vehicle.year,
                            marca: vehicle.make,
                            modelo: vehicle.model,
                            descricao: `${vehicle.year} ${vehicle.make} ${vehicle.model}`,
                            lanceAtual: vehicle.currentBid,
                            moeda: "BRL",
                            patio: "",
                            tipo: vehicle.saleType,
                            imagem: vehicle.imageUrl || "",
                            status: vehicle.status,
                          }}
                        />
                        <Button
                          onClick={() => handleRemoveFavorite(vehicle.id)}
                          variant="destructive"
                          size="sm"
                          className="absolute top-2 right-2 z-10"
                          disabled={removeFavoriteMutation.isPending}
                        >
                          <X size={16} />
                        </Button>
                      </div>
                    ))}
                  </div>
                ) : (
                  <div className="text-center py-12">
                    <Heart size={48} className="mx-auto text-gray-400 mb-4" />
                    <p className="text-gray-600 mb-4">Você ainda não tem veículos favoritos</p>
                    <Link href="/find-vehicle">
                      <Button className="bg-copart-orange hover:bg-yellow-600">
                        Explorar Veículos
                      </Button>
                    </Link>
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
