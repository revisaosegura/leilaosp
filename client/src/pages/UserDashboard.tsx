import { useState, useEffect, useLayoutEffect } from "react";
import { useAuth } from "@/_core/hooks/useAuth";
import { trpc } from "@/lib/trpc";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Loader2, User, Heart, Gavel, Edit2, Save, X, Eye, Trash2, LogOut, KeyRound } from "lucide-react";
import { Link, useLocation } from "wouter";
import { toast } from "sonner";

export default function UserDashboard() {
  const { user, loading: authLoading, logout } = useAuth({ redirectOnUnauthenticated: true });
  const [, setLocation] = useLocation();

  // Redireciona o admin para o painel de administração
  useLayoutEffect(() => {
    if (user && user.role === 'admin') {
      setLocation('/admin');
    }
  }, [user, setLocation]);

  const [isEditing, setIsEditing] = useState(false);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");

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
    if (profile && !isEditing) {
      setName(profile.name || "");
      setEmail(profile.email || "");
      setPhone(profile.phone || "");
    }
  }, [profile, isEditing]);

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
    updateProfileMutation.mutate({ name, email, phone });
  };

  const changePasswordMutation = trpc.user.changePassword.useMutation({
    onSuccess: () => {
      toast.success("Senha atualizada com sucesso!");
      setCurrentPassword("");
      setNewPassword("");
      setConfirmPassword("");
    },
    onError: (error) => {
      toast.error("Erro ao alterar senha: " + error.message);
    },
  });

  const handleChangePassword = () => {
    if (newPassword !== confirmPassword) {
      toast.error("A confirmação da nova senha não confere");
      return;
    }

    changePasswordMutation.mutate({ currentPassword, newPassword });
  };

  const handleCancelEdit = () => {
    setName(profile?.name || "");
    setEmail(profile?.email || "");
    setPhone(profile?.phone || "");
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

  if (user && user.role === 'admin') {
    return null; // Renderiza nada enquanto redireciona
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
              <p className="text-blue-200">Bem-vindo, {profile?.name || user.username}</p>
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
                    <Label htmlFor="phone">Celular / WhatsApp</Label>
                    <Input
                      id="phone"
                      type="tel"
                      value={phone}
                      onChange={(e) => setPhone(e.target.value)}
                      disabled={!isEditing}
                      placeholder="(11) 99999-9999"
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

            <Card>
              <CardHeader className="flex flex-row items-center justify-between">
                <CardTitle className="flex items-center gap-2">
                  <KeyRound className="h-5 w-5" />
                  Alterar Senha
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid md:grid-cols-2 gap-6">
                  <div className="space-y-2">
                    <Label htmlFor="currentPassword">Senha atual</Label>
                    <Input
                      id="currentPassword"
                      type="password"
                      value={currentPassword}
                      onChange={(e) => setCurrentPassword(e.target.value)}
                      placeholder="Digite sua senha atual"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="newPassword">Nova senha</Label>
                    <Input
                      id="newPassword"
                      type="password"
                      value={newPassword}
                      onChange={(e) => setNewPassword(e.target.value)}
                      placeholder="Escolha uma nova senha"
                    />
                  </div>

                  <div className="space-y-2 md:col-span-2">
                    <Label htmlFor="confirmPassword">Confirmar nova senha</Label>
                    <Input
                      id="confirmPassword"
                      type="password"
                      value={confirmPassword}
                      onChange={(e) => setConfirmPassword(e.target.value)}
                      placeholder="Repita a nova senha"
                    />
                  </div>
                </div>

                <div className="flex items-center justify-between gap-3">
                  <p className="text-sm text-gray-600">
                    Use uma senha segura e não compartilhe suas credenciais.
                  </p>
                  <div className="flex gap-3">
                    <Button
                      variant="outline"
                      onClick={() => {
                        setCurrentPassword("");
                        setNewPassword("");
                        setConfirmPassword("");
                      }}
                      disabled={changePasswordMutation.isPending}
                    >
                      Limpar
                    </Button>
                    <Button
                      onClick={handleChangePassword}
                      disabled={
                        changePasswordMutation.isPending ||
                        !currentPassword ||
                        !newPassword ||
                        !confirmPassword
                      }
                    >
                      {changePasswordMutation.isPending ? (
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                      ) : (
                        <Save className="mr-2 h-4 w-4" />
                      )}
                      Atualizar senha
                    </Button>
                  </div>
                </div>
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
        {fav.images && fav.images[0] ? (
          <img
            src={fav.images[0]}
            alt={`${fav.year} ${fav.make} ${fav.model}`}
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
          {fav.year} {fav.make} {fav.model}
        </h3>
        <p className="text-sm text-gray-600 mb-2">Lote: {fav.lotNumber}</p>
        <p className="text-lg font-semibold text-green-600 mb-4">
          {formatCurrency(fav.currentBid)}
        </p>
        <div className="flex gap-2">
          <Link href={`/vehicle/${fav.id}`} className="flex-1">
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
                removeFavoriteMutation.mutate({ vehicleId: fav.id });
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
                            <td className="py-3 px-4 flex items-center gap-3">
                              <img 
                                src={bid.vehicle.images?.[0] || '/placeholder.png'} 
                                alt={bid.vehicle.model} 
                                className="w-16 h-12 object-cover rounded-md"
                              />
                              <p className="font-semibold">{bid.vehicle.year} {bid.vehicle.make} {bid.vehicle.model}</p>
                            </td>
                            <td className="py-3 px-4 font-mono text-sm">
                              #{bid.vehicle.lotNumber}
                            </td>
                            <td className="py-3 px-4 font-semibold text-blue-600">
                              {formatCurrency(bid.amount)}
                            </td>
                            <td className="py-3 px-4 font-semibold text-green-600"> 
                              {formatCurrency(bid.vehicle.currentBid)}
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
