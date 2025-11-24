import { useAuth } from "@/_core/hooks/useAuth";
import { trpc } from "@/lib/trpc";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Loader2, User, Heart, Gavel, Edit2, Save, X, Eye, Trash2, LogOut } from "lucide-react";
import { useState, useEffect } from "react";
import { Link } from "wouter";
import { toast } from "sonner";

export default function UserDashboard() {
  const { user, loading: authLoading, logout } = useAuth({ redirectOnUnauthenticated: true });

  // Redirecionar admin para painel admin
  if (user && user.role === 'admin') {
    window.location.href = '/admin';
    return null;
  }

  const [isEditing, setIsEditing] = useState(false);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");

  const { data: profile, refetch: refetchProfile } = trpc.user.profile.useQuery(undefined, {
    enabled: !!user,
  });

  const { data: favorites, refetch: refetchFavorites } = trpc.favorites.list.useQuery(undefined, {
    enabled: !!user,
  });

  const { data: myBids, refetch: refetchBids } = trpc.user.myBids.useQuery(undefined, {
    enabled: !!user,
  });

  useEffect(() => {
    if (profile) {
      setName(profile.name || "");
      setEmail(profile.email || "");
    }
  }, [profile]);

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
      refetchFavorites();
    },
    onError: (error) => {
      toast.error("Erro ao remover favorito: " + error.message);
    },
  });

  const handleSaveProfile = () => {
    updateProfileMutation.mutate({ name, email });
  };

  const handleCancelEdit = () => {
    setName(profile?.name || "");
    setEmail(profile?.email || "");
    setIsEditing(false);
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('pt-BR', {
      style: 'currency',
      currency: 'BRL'
    }).format(value);
  };

  const formatDate = (date: Date | string) => {
    return new Date(date).toLocaleDateString('pt-BR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
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

  const stats = [
    {
      title: "Favoritos",
      value: favorites?.length || 0,
      icon: Heart,
      color: "text-red-600",
      bgColor: "bg-red-100",
    },
    {
      title: "Lances Ativos",
      value: myBids?.length || 0,
      icon: Gavel,
      color: "text-blue-600",
      bgColor: "bg-blue-100",
    },
    {
      title: "Total Investido",
      value: formatCurrency(myBids?.reduce((sum, bid) => sum + bid.amount, 0) || 0),
      icon: User,
      color: "text-green-600",
      bgColor: "bg-green-100",
    },
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white">
        <div className="container py-8">
          <div className="flex items-center justify-between gap-4">
            <div>
              <h1 className="text-3xl font-bold mb-2">Meu Painel</h1>
              <p className="text-blue-200">Bem-vindo, {user.name || user.username}</p>
            </div>
            <div className="flex items-center gap-3">
              <Link href="/">
                <Button variant="outline" className="bg-white text-blue-600 hover:bg-gray-100">
                  Voltar ao Site
                </Button>
              </Link>
              <Button onClick={logout} variant="secondary" className="bg-white text-blue-600 hover:bg-gray-100">
                <LogOut className="mr-2 h-4 w-4" />
                Sair
              </Button>
            </div>
          </div>
        </div>
      </div>

      <div className="container py-8">
        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          {stats.map((stat) => (
            <Card key={stat.title} className="hover:shadow-lg transition-shadow">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium text-gray-600">{stat.title}</CardTitle>
                <div className={`p-2 rounded-lg ${stat.bgColor}`}>
                  <stat.icon className={`h-5 w-5 ${stat.color}`} />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{stat.value}</div>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* Tabs */}
        <Tabs defaultValue="profile" className="space-y-6">
          <TabsList className="grid w-full grid-cols-3 lg:w-auto">
            <TabsTrigger value="profile">Meu Perfil</TabsTrigger>
            <TabsTrigger value="favorites">Favoritos</TabsTrigger>
            <TabsTrigger value="bids">Meus Lances</TabsTrigger>
          </TabsList>

          {/* Profile Tab */}
          <TabsContent value="profile" className="space-y-6">
            <Card>
              <CardHeader className="flex flex-row items-center justify-between">
                <CardTitle className="flex items-center gap-2">
                  <User className="h-5 w-5" />
                  Informações do Perfil
                </CardTitle>
                {!isEditing ? (
                  <Button onClick={() => setIsEditing(true)} variant="outline">
                    <Edit2 className="mr-2 h-4 w-4" />
                    Editar
                  </Button>
                ) : (
                  <div className="flex gap-2">
                    <Button onClick={handleSaveProfile} disabled={updateProfileMutation.isPending}>
                      <Save className="mr-2 h-4 w-4" />
                      Salvar
                    </Button>
                    <Button onClick={handleCancelEdit} variant="outline">
                      <X className="mr-2 h-4 w-4" />
                      Cancelar
                    </Button>
                  </div>
                )}
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="grid md:grid-cols-2 gap-6">
                  <div className="space-y-2">
                    <Label htmlFor="username">Usuário</Label>
                    <Input
                      id="username"
                      value={user.username}
                      disabled
                      className="bg-gray-100"
                    />
                    <p className="text-xs text-gray-500">O nome de usuário não pode ser alterado</p>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="name">Nome Completo</Label>
                    <Input
                      id="name"
                      value={name}
                      onChange={(e) => setName(e.target.value)}
                      disabled={!isEditing}
                      placeholder="Digite seu nome completo"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="email">E-mail</Label>
                    <Input
                      id="email"
                      type="email"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      disabled={!isEditing}
                      placeholder="seu@email.com"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label>Data de Cadastro</Label>
                    <Input
                      value={formatDate(user.createdAt)}
                      disabled
                      className="bg-gray-100"
                    />
                  </div>
                </div>

                {isEditing && (
                  <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
                    <p className="text-sm text-blue-800">
                      <strong>Dica:</strong> Mantenha suas informações atualizadas para receber notificações sobre seus lances e veículos favoritos.
                    </p>
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          {/* Favorites Tab */}
          <TabsContent value="favorites" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Heart className="h-5 w-5 text-red-600" />
                  Veículos Favoritos ({favorites?.length || 0})
                </CardTitle>
              </CardHeader>
              <CardContent>
                {!favorites || favorites.length === 0 ? (
                  <div className="text-center py-12">
                    <Heart className="h-16 w-16 text-gray-300 mx-auto mb-4" />
                    <p className="text-gray-600 mb-4">Você ainda não tem veículos favoritos</p>
                    <Link href="/find-vehicle">
                      <Button>Explorar Veículos</Button>
                    </Link>
                  </div>
                ) : (
                  <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {favorites.map((fav) => (
                      <Card key={fav.id} className="overflow-hidden hover:shadow-lg transition-shadow">
                        <div className="aspect-video bg-gray-200 relative">
                          {fav.vehicle.images && fav.vehicle.images[0] ? (
                            <img
                              src={fav.vehicle.images[0]}
                              alt={`${fav.vehicle.year} ${fav.vehicle.make} ${fav.vehicle.model}`}
                              className="w-full h-full object-cover"
                            />
                          ) : (
                            <div className="w-full h-full flex items-center justify-center text-gray-400">
                              Sem imagem
                            </div>
                          )}
                        </div>
                        <CardContent className="p-4">
                          <h3 className="font-bold text-lg mb-2">
                            {fav.vehicle.year} {fav.vehicle.make} {fav.vehicle.model}
                          </h3>
                          <p className="text-sm text-gray-600 mb-2">Lote: {fav.vehicle.lotNumber}</p>
                          <p className="text-lg font-semibold text-green-600 mb-4">
                            {formatCurrency(fav.vehicle.currentBid)}
                          </p>
                          <div className="flex gap-2">
                            <Link href={`/vehicle/${fav.vehicle.id}`} className="flex-1">
                              <Button variant="outline" className="w-full" size="sm">
                                <Eye className="mr-2 h-4 w-4" />
                                Ver Detalhes
                              </Button>
                            </Link>
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={() => {
                                if (confirm('Remover dos favoritos?')) {
                                  removeFavoriteMutation.mutate({ vehicleId: fav.vehicle.id });
                                }
                              }}
                            >
                              <Trash2 className="h-4 w-4 text-red-600" />
                            </Button>
                          </div>
                        </CardContent>
                      </Card>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </TabsContent>

          {/* Bids Tab */}
          <TabsContent value="bids" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Gavel className="h-5 w-5 text-blue-600" />
                  Meus Lances ({myBids?.length || 0})
                </CardTitle>
              </CardHeader>
              <CardContent>
                {!myBids || myBids.length === 0 ? (
                  <div className="text-center py-12">
                    <Gavel className="h-16 w-16 text-gray-300 mx-auto mb-4" />
                    <p className="text-gray-600 mb-4">Você ainda não fez nenhum lance</p>
                    <Link href="/find-vehicle">
                      <Button>Explorar Leilões</Button>
                    </Link>
                  </div>
                ) : (
                  <div className="overflow-x-auto">
                    <table className="w-full">
                      <thead>
                        <tr className="border-b">
                          <th className="text-left py-3 px-4">Veículo</th>
                          <th className="text-left py-3 px-4">Lote</th>
                          <th className="text-left py-3 px-4">Meu Lance</th>
                          <th className="text-left py-3 px-4">Lance Atual</th>
                          <th className="text-left py-3 px-4">Tipo</th>
                          <th className="text-left py-3 px-4">Data</th>
                          <th className="text-right py-3 px-4">Ações</th>
                        </tr>
                      </thead>
                      <tbody>
                        {myBids.map((bid) => (
                          <tr key={bid.id} className="border-b hover:bg-gray-50">
                            <td className="py-3 px-4">
                              <p className="font-semibold">Veículo #{bid.vehicleId}</p>
                            </td>
                            <td className="py-3 px-4 font-mono text-sm">
                              #{bid.vehicleId}
                            </td>
                            <td className="py-3 px-4 font-semibold text-blue-600">
                              {formatCurrency(bid.amount)}
                            </td>
                            <td className="py-3 px-4 font-semibold text-green-600">
                              -
                            </td>
                            <td className="py-3 px-4">
                              <span className="px-2 py-1 rounded-full text-xs bg-orange-100 text-orange-800">
                                {bid.bidType}
                              </span>
                            </td>
                            <td className="py-3 px-4 text-sm text-gray-600">
                              {formatDate(bid.createdAt)}
                            </td>
                            <td className="py-3 px-4">
                              <div className="flex justify-end">
                                <Link href={`/vehicle/${bid.vehicleId}`}>
                                  <Button variant="ghost" size="sm">
                                    <Eye className="h-4 w-4" />
                                  </Button>
                                </Link>
                              </div>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
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
