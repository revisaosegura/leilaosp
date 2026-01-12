import { useAuth } from "@/_core/hooks/useAuth";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { trpc } from "@/lib/trpc";
import { Loader2, User, Shield, Calendar, Trash2 } from "lucide-react";
import { Link } from "wouter";
import DashboardLayout from "@/components/DashboardLayout";
import { toast } from "sonner";

export default function AdminUsers() {
  const { user } = useAuth({ redirectOnUnauthenticated: true });
  const { data: users, isLoading, refetch } = trpc.admin.users.list.useQuery(undefined, {
    enabled: user?.role === "admin",
  });

  const deleteUser = trpc.admin.users.delete.useMutation({
    onSuccess: () => {
      toast.success("Usuário excluído com sucesso!");
      refetch();
    },
    onError: (error) => {
      toast.error("Erro ao excluir usuário: " + error.message);
    },
  });

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
          <h1 className="text-3xl font-bold">Gerenciar Usuários</h1>
        </div>

        {isLoading ? (
          <div className="flex justify-center py-12">
            <Loader2 className="animate-spin" size={48} />
          </div>
        ) : (
          <Card>
            <CardHeader>
              <CardTitle>Lista de Usuários ({users?.length || 0})</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead>
                    <tr className="border-b">
                      <th className="text-left p-3">ID</th>
                      <th className="text-left p-3">Nome</th>
                      <th className="text-left p-3">Email</th>
                      <th className="text-left p-3">Telefone</th>
                      <th className="text-left p-3">Método de Login</th>
                      <th className="text-left p-3">Função</th>
                      <th className="text-left p-3">Cadastrado em</th>
                      <th className="text-left p-3">Último Acesso</th>
                      <th className="text-right p-3">Ações</th>
                    </tr>
                  </thead>
                  <tbody>
                    {users?.map((u) => (
                      <tr key={u.id} className="border-b hover:bg-gray-50">
                        <td className="p-3">{u.id}</td>
                        <td className="p-3">
                          <div className="flex items-center gap-2">
                            <User size={16} className="text-gray-400" />
                            {u.name || "Não informado"}
                          </div>
                        </td>
                        <td className="p-3">{u.email || "Não informado"}</td>
                        <td className="p-3">{u.phone || "Não informado"}</td>
                        <td className="p-3 capitalize">{u.loginMethod || "-"}</td>
                        <td className="p-3">
                          <div className="flex items-center gap-2">
                            {u.role === "admin" && <Shield size={16} className="text-orange-500" />}
                            <span
                              className={`px-2 py-1 rounded text-xs font-bold ${
                                u.role === "admin"
                                  ? "bg-orange-100 text-orange-800"
                                  : "bg-blue-100 text-blue-800"
                              }`}
                            >
                              {u.role === "admin" ? "Admin" : "Usuário"}
                            </span>
                          </div>
                        </td>
                        <td className="p-3">
                          <div className="flex items-center gap-2 text-sm text-gray-600">
                            <Calendar size={14} />
                            {new Date(u.createdAt).toLocaleDateString("pt-BR")}
                          </div>
                        </td>
                        <td className="p-3 text-sm text-gray-600">
                          {new Date(u.lastSignedIn).toLocaleDateString("pt-BR")}
                        </td>
                        <td className="p-3 text-right">
                          <Button
                            variant="ghost"
                            size="sm"
                            disabled={u.role === "admin"}
                            onClick={() => {
                              if (confirm("Tem certeza que deseja excluir este usuário?")) {
                                deleteUser.mutate({ id: u.id });
                              }
                            }}
                          >
                            <Trash2 className={`h-4 w-4 ${u.role === "admin" ? "text-gray-400" : "text-red-600"}`} />
                          </Button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </CardContent>
          </Card>
        )}
      </div>
    </DashboardLayout>
  );
}
