import { useAuth } from "@/_core/hooks/useAuth";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { trpc } from "@/lib/trpc";
import { Car, Users, Gavel, TrendingUp, Plus, Edit, Trash2, Eye, LogOut, RefreshCw } from "lucide-react";
import { Link } from "wouter";
import { useState } from "react";
import { toast } from "sonner";

export default function Admin() {
  const { user, loading, logout } = useAuth();
  const [activeTab, setActiveTab] = useState("overview");
  
  const { data: vehicles, refetch: refetchVehicles } = trpc.vehicles.list.useQuery({ limit: 500 });
  const { data: users, refetch: refetchUsers } = trpc.admin.users.list.useQuery(undefined, {
    enabled: user?.role === "admin",
  });
  const { data: allBids, refetch: refetchBids } = trpc.admin.bids.list.useQuery(undefined, {
    enabled: user?.role === "admin",
  });

  const deleteVehicle = trpc.admin.vehicles.delete.useMutation({
    onSuccess: () => {
      toast.success("Veículo excluído com sucesso!");
      refetchVehicles();
    },
    onError: (error) => {
      toast.error("Erro ao excluir veículo: " + error.message);
    },
  });

  const deleteUser = trpc.admin.users.delete.useMutation({
    onSuccess: () => {
      toast.success("Usuário excluído com sucesso!");
      refetchUsers();
    },
    onError: (error) => {
      toast.error("Erro ao excluir usuário: " + error.message);
    },
  });

  if (loading) {
    return <div className="min-h-screen flex items-center justify-center">Carregando...</div>;
  }

  if (!user) {
    window.location.href = "/admin/login";
    return null;
  }

  if (user.role !== "admin") {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-4">Acesso Negado</h1>
          <p className="mb-4">Você não tem permissão para acessar esta página.</p>
          <Link href="/">
            <Button>Voltar para Início</Button>
          </Link>
        </div>
      </div>
    );
  }

  const stats = [
    {
      title: "Total de Veículos",
      value: vehicles?.length || 0,
      icon: Car,
      color: "text-blue-600",
      bgColor: "bg-blue-100",
    },
    {
      title: "Total de Usuários",
      value: users?.length || 0,
      icon: Users,
      color: "text-green-600",
      bgColor: "bg-green-100",
    },
    {
      title: "Total de Lances",
      value: allBids?.length || 0,
      icon: Gavel,
      color: "text-orange-600",
      bgColor: "bg-orange-100",
    },
    {
      title: "Receita Total",
      value: `R$ ${((allBids?.reduce((sum, bid) => sum + bid.amount, 0) || 0) / 1000).toFixed(1)}k`,
      icon: TrendingUp,
      color: "text-purple-600",
      bgColor: "bg-purple-100",
    },
  ];

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

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-purple-900 to-indigo-900 text-white">
        <div className="container py-8">
          <div className="flex items-center justify-between gap-4">
            <div>
              <h1 className="text-3xl font-bold mb-2">Painel Administrativo</h1>
              <p className="text-purple-200">Bem-vindo, {user.name || user.username}</p>
            </div>
            <div className="flex items-center gap-3">
              <Link href="/">
                <Button variant="outline" className="bg-white text-purple-900 hover:bg-gray-100">
                  Ver Site
                </Button>
              </Link>
              <Button onClick={logout} variant="secondary" className="bg-white text-purple-900 hover:bg-gray-100">
                <LogOut className="mr-2 h-4 w-4" />
                Sair
              </Button>
            </div>
          </div>
        </div>
      </div>

      <div className="container py-8">
        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          {stats.map((stat) => (
            <Card key={stat.title} className="hover:shadow-lg transition-shadow">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium text-gray-600">{stat.title}</CardTitle>
                <div className={`p-2 rounded-lg ${stat.bgColor}`}>
                  <stat.icon className={`h-5 w-5 ${stat.color}`} />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-3xl font-bold">{stat.value}</div>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
          <TabsList className="grid w-full grid-cols-3 lg:w-auto">
            <TabsTrigger value="overview">Visão Geral</TabsTrigger>
            <TabsTrigger value="vehicles">Veículos</TabsTrigger>
            <TabsTrigger value="users">Usuários</TabsTrigger>
            <TabsTrigger value="bids">Lances</TabsTrigger>
          </TabsList>

          {/* Overview Tab */}
          <TabsContent value="overview" className="space-y-6">
            <div className="grid md:grid-cols-2 gap-6">
              {/* Recent Vehicles */}
              <Card>
                <CardHeader>
                  <CardTitle>Veículos Recentes</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {vehicles?.slice(0, 5).map((vehicle) => (
                      <div key={vehicle.id} className="flex items-center justify-between border-b pb-3">
                        <div>
                          <p className="font-semibold">{vehicle.year} {vehicle.make} {vehicle.model}</p>
                          <p className="text-sm text-gray-600">Lote: {vehicle.lotNumber}</p>
                        </div>
                        <div className="text-right">
                          <p className="font-semibold text-green-600">{formatCurrency(vehicle.currentBid)}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>

              {/* Recent Bids */}
              <Card>
                <CardHeader>
                  <CardTitle>Lances Recentes</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {allBids?.slice(0, 5).map((bid) => (
                      <div key={bid.id} className="flex items-center justify-between border-b pb-3">
                        <div>
                          <p className="font-semibold">Veículo #{bid.vehicleId}</p>
                          <p className="text-sm text-gray-600">{formatDate(bid.createdAt)}</p>
                        </div>
                        <div className="text-right">
                          <p className="font-semibold text-blue-600">{formatCurrency(bid.amount)}</p>
                          <p className="text-xs text-gray-500">{bid.bidType}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Vehicles Tab */}
          <TabsContent value="vehicles" className="space-y-6">
            <Card>
              <CardHeader className="flex flex-row items-center justify-between">
                <CardTitle>Gerenciar Veículos ({vehicles?.length || 0})</CardTitle>
                <Link href="/admin/vehicles/new">
                  <Button className="bg-purple-600 hover:bg-purple-700">
                    <Plus className="mr-2 h-4 w-4" />
                    Adicionar Veículo
                  </Button>
                </Link>
              </CardHeader>
              <CardContent>
                <div className="overflow-x-auto">
                  <table className="w-full">
                    <thead>
                      <tr className="border-b">
                        <th className="text-left py-3 px-4">Lote</th>
                        <th className="text-left py-3 px-4">Veículo</th>
                        <th className="text-left py-3 px-4">Ano</th>
                        <th className="text-left py-3 px-4">Lance Atual</th>
                        <th className="text-left py-3 px-4">Status</th>
                        <th className="text-right py-3 px-4">Ações</th>
                      </tr>
                    </thead>
                    <tbody>
                      {vehicles?.slice(0, 20).map((vehicle) => (
                        <tr key={vehicle.id} className="border-b hover:bg-gray-50">
                          <td className="py-3 px-4 font-mono text-sm">{vehicle.lotNumber}</td>
                          <td className="py-3 px-4">
                            <div>
                              <p className="font-semibold">{vehicle.make} {vehicle.model}</p>
                              <p className="text-sm text-gray-600">{vehicle.vin}</p>
                            </div>
                          </td>
                          <td className="py-3 px-4">{vehicle.year}</td>
                          <td className="py-3 px-4 font-semibold text-green-600">
                            {formatCurrency(vehicle.currentBid)}
                          </td>
                          <td className="py-3 px-4">
                            <span className="px-2 py-1 rounded-full text-xs bg-blue-100 text-blue-800">
                              {vehicle.status}
                            </span>
                          </td>
                          <td className="py-3 px-4">
                            <div className="flex justify-end gap-2">
                              <Link href={`/vehicle/${vehicle.id}`}>
                                <Button variant="ghost" size="sm">
                                  <Eye className="h-4 w-4" />
                                </Button>
                              </Link>
                              <Link href={`/admin/vehicles/edit/${vehicle.id}`}>
                                <Button variant="ghost" size="sm">
                                  <Edit className="h-4 w-4" />
                                </Button>
                              </Link>
                              <Button 
                                variant="ghost" 
                                size="sm"
                                onClick={() => {
                                  if (confirm('Tem certeza que deseja excluir este veículo?')) {
                                    deleteVehicle.mutate({ id: vehicle.id });
                                  }
                                }}
                              >
                                <Trash2 className="h-4 w-4 text-red-600" />
                              </Button>
                            </div>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Users Tab */}
          <TabsContent value="users" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Gerenciar Usuários ({users?.length || 0})</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="overflow-x-auto">
                  <table className="w-full">
                    <thead>
                      <tr className="border-b">
                        <th className="text-left py-3 px-4">ID</th>
                        <th className="text-left py-3 px-4">Nome</th>
                        <th className="text-left py-3 px-4">Email</th>
                        <th className="text-left py-3 px-4">Telefone</th>
                        <th className="text-left py-3 px-4">Role</th>
                        <th className="text-left py-3 px-4">Cadastro</th>
                        <th className="text-right py-3 px-4">Ações</th>
                      </tr>
                    </thead>
                    <tbody>
                      {users?.map((u) => (
                        <tr key={u.id} className="border-b hover:bg-gray-50">
                          <td className="py-3 px-4 font-mono text-sm">{u.id}</td>
                          <td className="py-3 px-4">
                            <div>
                              <p className="font-semibold">{u.name || 'N/A'}</p>
                              <p className="text-sm text-gray-600">@{u.username}</p>
                            </div>
                          </td>
                          <td className="py-3 px-4">{u.email || 'N/A'}</td>
                          <td className="py-3 px-4">{u.phone || 'N/A'}</td>
                          <td className="py-3 px-4">
                            <span className={`px-2 py-1 rounded-full text-xs ${
                              u.role === 'admin'
                                ? 'bg-purple-100 text-purple-800' 
                                : 'bg-gray-100 text-gray-800'
                            }`}>
                              {u.role}
                            </span>
                          </td>
                          <td className="py-3 px-4 text-sm text-gray-600">
                            {formatDate(u.createdAt)}
                          </td>
                          <td className="py-3 px-4">
                            <div className="flex justify-end gap-2">
                              <Button 
                                variant="ghost" 
                                size="sm"
                                disabled={u.role === 'admin'}
                                onClick={() => {
                                  if (confirm('Tem certeza que deseja excluir este usuário?')) {
                                    deleteUser.mutate({ id: u.id });
                                  }
                                }}
                              >
                                <Trash2 className={`h-4 w-4 ${u.role === 'admin' ? 'text-gray-400' : 'text-red-600'}`} />
                              </Button>
                            </div>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Bids Tab */}
          <TabsContent value="bids" className="space-y-6">
            <Card>
              <CardHeader className="flex flex-row items-center justify-between">
                <CardTitle>Gerenciar Lances ({allBids?.length || 0})</CardTitle>
                <Button variant="outline" size="sm" onClick={() => refetchBids()}>
                  <RefreshCw className="mr-2 h-4 w-4" />
                  Atualizar
                </Button>
              </CardHeader>
              <CardContent>
                <div className="overflow-x-auto">
                  <table className="w-full">
                    <thead>
                      <tr className="border-b">
                        <th className="text-left py-3 px-4">ID</th>
                        <th className="text-left py-3 px-4">Veículo</th>
                        <th className="text-left py-3 px-4">Usuário</th>
                        <th className="text-left py-3 px-4">Valor</th>
                        <th className="text-left py-3 px-4">Tipo</th>
                        <th className="text-left py-3 px-4">Data</th>
                      </tr>
                    </thead>
                    <tbody>
                      {allBids && allBids.length > 0 ? (
                        allBids.slice(0, 50).map((bid) => (
                        <tr key={bid.id} className="border-b hover:bg-gray-50">
                          <td className="py-3 px-4 font-mono text-sm">{bid.id}</td>
                          <td className="py-3 px-4">
                            <Link href={`/vehicle/${bid.vehicleId}`} className="text-blue-600 hover:underline">
                              Veículo #{bid.vehicleId}
                            </Link>
                          </td>
                          <td className="py-3 px-4">Usuário #{bid.userId}</td>
                          <td className="py-3 px-4 font-semibold text-green-600">
                            {formatCurrency(bid.amount)}
                          </td>
                          <td className="py-3 px-4">
                            <span className="px-2 py-1 rounded-full text-xs bg-orange-100 text-orange-800">
                              {bid.bidType}
                            </span>
                          </td>
                          <td className="py-3 px-4 text-sm text-gray-600">
                            {formatDate(bid.createdAt)}
                          </td>
                        </tr>
                      ))
                      ) : (
                        <tr>
                          <td colSpan={6} className="text-center py-8 text-gray-500">
                            Nenhum lance encontrado.
                          </td>
                        </tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
