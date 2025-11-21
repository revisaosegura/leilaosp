import { useAuth } from "@/_core/hooks/useAuth";
import DashboardLayout from "@/components/DashboardLayout";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { trpc } from "@/lib/trpc";
import { Car, Users, Gavel, MapPin } from "lucide-react";
import { getLoginUrl } from "@/const";
import { Link } from "wouter";

export default function Admin() {
  const { user, loading } = useAuth();
  const { data: vehicles } = trpc.vehicles.list.useQuery({ limit: 100 });
  const { data: users } = trpc.admin.users.list.useQuery(undefined, {
    enabled: user?.role === "admin",
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
    },
    {
      title: "Total de Usuários",
      value: users?.length || 0,
      icon: Users,
      color: "text-green-600",
    },
    {
      title: "Leilões Ativos",
      value: vehicles?.filter((v) => v.saleType === "auction").length || 0,
      icon: Gavel,
      color: "text-orange-600",
    },
    {
      title: "Venda Direta",
      value: vehicles?.filter((v) => v.saleType === "direct").length || 0,
      icon: MapPin,
      color: "text-purple-600",
    },
  ];

  return (
    <DashboardLayout>
      <div className="p-8">
        <h1 className="text-3xl font-bold mb-8">Painel Administrativo</h1>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          {stats.map((stat) => (
            <Card key={stat.title}>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">{stat.title}</CardTitle>
                <stat.icon className={`h-4 w-4 ${stat.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{stat.value}</div>
              </CardContent>
            </Card>
          ))}
        </div>

        <div className="grid md:grid-cols-2 gap-6">
          <Card>
            <CardHeader>
              <CardTitle>Veículos Recentes</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {vehicles?.slice(0, 5).map((vehicle) => (
                  <div key={vehicle.id} className="flex justify-between items-center border-b pb-2">
                    <div>
                      <p className="font-medium">
                        {vehicle.year} {vehicle.make} {vehicle.model}
                      </p>
                      <p className="text-sm text-gray-600">Lote {vehicle.lotNumber}</p>
                    </div>
                    <span className="text-sm font-semibold">
                      R$ {vehicle.currentBid.toLocaleString("pt-BR")}
                    </span>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Ações Rápidas</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <Link href="/admin/vehicles">
                  <Button className="w-full" variant="outline">
                    Gerenciar Veículos
                  </Button>
                </Link>
                <Link href="/admin/users">
                  <Button className="w-full" variant="outline">
                    Gerenciar Usuários
                  </Button>
                </Link>
                <Link href="/admin/bids">
                  <Button className="w-full" variant="outline">
                    Gerenciar Lances
                  </Button>
                </Link>
                <Link href="/admin/auctions">
                  <Button className="w-full" variant="outline">
                    Gerenciar Leilões
                  </Button>
                </Link>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </DashboardLayout>
  );
}
