import { useAuth } from "@/_core/hooks/useAuth";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { trpc } from "@/lib/trpc";
import { Loader2, User, Car, DollarSign, Calendar, TrendingUp } from "lucide-react";
import { Link } from "wouter";
import DashboardLayout from "@/components/DashboardLayout";
import { useState, useMemo } from "react";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

export default function AdminBids() {
  const { user } = useAuth({ redirectOnUnauthenticated: true });
  const [filterUserId, setFilterUserId] = useState<string>("all");
  const [filterVehicleId, setFilterVehicleId] = useState<string>("all");

  const { data: users } = trpc.admin.users.list.useQuery(undefined, {
    enabled: user?.role === "admin",
  });

  const { data: vehicles } = trpc.vehicles.list.useQuery({ limit: 100 });

  // Get all bids from all users
  const { data: allUserBids, isLoading } = trpc.admin.bids.listAll.useQuery(undefined, {
    enabled: user?.role === "admin",
  });

  const filteredBids = useMemo(() => {
    if (!allUserBids) return [];

    let filtered = allUserBids;

    if (filterUserId !== "all") {
      filtered = filtered.filter((bid) => bid.userId === parseInt(filterUserId));
    }

    if (filterVehicleId !== "all") {
      filtered = filtered.filter((bid) => bid.vehicle.id === parseInt(filterVehicleId));
    }

    return filtered;
  }, [allUserBids, filterUserId, filterVehicleId]);

  const stats = useMemo(() => {
    if (!allUserBids) return { total: 0, totalValue: 0, avgBid: 0 };

    const total = allUserBids.length;
    const totalValue = allUserBids.reduce((sum, bid) => sum + bid.amount, 0);
    const avgBid = total > 0 ? totalValue / total : 0;

    return { total, totalValue, avgBid };
  }, [allUserBids]);

  if (user?.role !== "admin") {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-4">Acesso Negado</h1>
          <Link href="/">
            <Button>Voltar para Início</Button>
          </Link>
        </div>
      </div>
    );
  }

  return (
    <DashboardLayout>
      <div className="p-8">
        <div className="flex justify-between items-center mb-8">
          <h1 className="text-3xl font-bold">Gerenciar Lances</h1>
        </div>

        {/* Statistics */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Total de Lances</CardTitle>
              <TrendingUp className="h-4 w-4 text-blue-600" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{stats.total}</div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Valor Total</CardTitle>
              <DollarSign className="h-4 w-4 text-green-600" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">R$ {stats.totalValue.toLocaleString("pt-BR")}</div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Lance Médio</CardTitle>
              <DollarSign className="h-4 w-4 text-orange-600" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">R$ {Math.round(stats.avgBid).toLocaleString("pt-BR")}</div>
            </CardContent>
          </Card>
        </div>

        {/* Filters */}
        <Card className="mb-6">
          <CardHeader>
            <CardTitle>Filtros</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="text-sm font-medium mb-2 block">Filtrar por Usuário</label>
                <Select value={filterUserId} onValueChange={setFilterUserId}>
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">Todos os Usuários</SelectItem>
                    {users?.map((u) => (
                      <SelectItem key={u.id} value={u.id.toString()}>
                        {u.name || u.email || `Usuário #${u.id}`}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div>
                <label className="text-sm font-medium mb-2 block">Filtrar por Veículo</label>
                <Select value={filterVehicleId} onValueChange={setFilterVehicleId}>
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">Todos os Veículos</SelectItem>
                    {vehicles?.map((v) => (
                      <SelectItem key={v.id} value={v.id.toString()}>
                        {v.year} {v.make} {v.model} - Lote {v.lotNumber}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>
          </CardContent>
        </Card>

        {isLoading ? (
          <div className="flex justify-center py-12">
            <Loader2 className="animate-spin" size={48} />
          </div>
        ) : (
          <Card>
            <CardHeader>
              <CardTitle>Lista de Lances ({filteredBids.length})</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead>
                    <tr className="border-b">
                      <th className="text-left p-3">ID</th>
                      <th className="text-left p-3">Usuário</th>
                      <th className="text-left p-3">Veículo</th>
                      <th className="text-left p-3">Valor do Lance</th>
                      <th className="text-left p-3">Lance Atual</th>
                      <th className="text-left p-3">Tipo</th>
                      <th className="text-left p-3">Data</th>
                      <th className="text-left p-3">Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filteredBids.map((bid) => {
                      const isWinning = bid.amount >= bid.vehicle.currentBid;
                      const userData = users?.find((u) => u.id === bid.userId);

                      return (
                        <tr key={bid.id} className="border-b hover:bg-gray-50">
                          <td className="p-3">{bid.id}</td>
                          <td className="p-3">
                            <div className="flex items-center gap-2">
                              <User size={16} className="text-gray-400" />
                              <div>
                                <div className="font-medium">
                                  {userData?.name || "Não informado"}
                                </div>
                                <div className="text-xs text-gray-500">
                                  {userData?.email || `ID: ${bid.userId}`}
                                </div>
                              </div>
                            </div>
                          </td>
                          <td className="p-3">
                            <div className="flex items-center gap-2">
                              <Car size={16} className="text-gray-400" />
                              <div>
                                <div className="font-medium">
                                  {bid.vehicle.year} {bid.vehicle.make} {bid.vehicle.model}
                                </div>
                                <div className="text-xs text-gray-500">
                                  Lote: {bid.vehicle.lotNumber}
                                </div>
                              </div>
                            </div>
                          </td>
                          <td className="p-3">
                            <span className="font-bold text-copart-orange">
                              R$ {bid.amount.toLocaleString("pt-BR")}
                            </span>
                          </td>
                          <td className="p-3">
                            <span className="font-medium">
                              R$ {bid.vehicle.currentBid.toLocaleString("pt-BR")}
                            </span>
                          </td>
                          <td className="p-3">
                            <span className="capitalize text-sm">{bid.bidType}</span>
                          </td>
                          <td className="p-3">
                            <div className="flex items-center gap-2 text-sm text-gray-600">
                              <Calendar size={14} />
                              {new Date(bid.createdAt).toLocaleString("pt-BR")}
                            </div>
                          </td>
                          <td className="p-3">
                            {isWinning ? (
                              <span className="px-2 py-1 rounded text-xs font-bold bg-green-100 text-green-800">
                                Vencendo
                              </span>
                            ) : (
                              <span className="px-2 py-1 rounded text-xs font-bold bg-gray-100 text-gray-800">
                                Superado
                              </span>
                            )}
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>

                {filteredBids.length === 0 && (
                  <div className="text-center py-12 text-gray-500">
                    Nenhum lance encontrado com os filtros selecionados.
                  </div>
                )}
              </div>
            </CardContent>
          </Card>
        )}
      </div>
    </DashboardLayout>
  );
}
