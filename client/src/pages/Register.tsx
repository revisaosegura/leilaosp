import { useState } from "react";
import { Link, useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { APP_LOGO, APP_TITLE } from "@/const";
import { useToast } from "@/hooks/use-toast";
import { UserPlus } from "lucide-react";

export default function Register() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    if (password !== confirmPassword) {
      toast({
        title: "As senhas não coincidem",
        description: "Verifique a confirmação de senha e tente novamente.",
        variant: "destructive",
      });
      return;
    }

    setIsLoading(true);

    try {
      const response = await fetch("/api/auth/register", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          name: name.trim(),
          email: email.trim(),
          username: username.trim(),
          password,
        }),
      });

      const data = await response.json();

      if (response.ok) {
        toast({
          title: "Conta criada com sucesso",
          description: "Você será redirecionado para o painel.",
        });
        setLocation("/dashboard");
        return;
      }

      toast({
        title: "Não foi possível criar a conta",
        description: data.error || "Tente novamente em instantes.",
        variant: "destructive",
      });
    } catch (error) {
      toast({
        title: "Erro ao registrar",
        description: "Verifique sua conexão e tente novamente.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 p-4 dark:from-gray-900 dark:to-gray-800">
      <div className="mx-auto flex max-w-5xl flex-col gap-10 lg:flex-row">
        <div className="flex-1 space-y-6 rounded-3xl bg-white/60 p-8 text-[#123b8b] shadow-[0_20px_50px_rgba(16,48,118,0.15)] backdrop-blur dark:bg-slate-900/60 dark:text-white">
          <div className="inline-flex items-center gap-3 rounded-full bg-blue-50 px-4 py-2 text-sm font-semibold text-[#0f4fb9] dark:bg-blue-500/20 dark:text-blue-100">
            <UserPlus className="h-4 w-4" />
            Novo na plataforma
          </div>
          <h1 className="text-4xl font-bold leading-tight">Crie sua conta e participe dos leilões da {APP_TITLE}</h1>
          <p className="text-lg text-[#234b93] dark:text-blue-100">
            Cadastre-se para acompanhar veículos, salvar favoritos, fazer lances e usar o botão de Compra Imediata.
          </p>
          <ul className="space-y-3 text-[#234b93] dark:text-blue-100">
            <li className="flex items-start gap-3">
              <span className="mt-2 inline-block h-2.5 w-2.5 rounded-full bg-[#0f4fb9]" />
              Acesso rápido ao painel do comprador.
            </li>
            <li className="flex items-start gap-3">
              <span className="mt-2 inline-block h-2.5 w-2.5 rounded-full bg-[#0f4fb9]" />
              Suporte dedicado para dúvidas e documentação.
            </li>
            <li className="flex items-start gap-3">
              <span className="mt-2 inline-block h-2.5 w-2.5 rounded-full bg-[#0f4fb9]" />
              Notificações sobre lances, vitórias e etapas de entrega.
            </li>
          </ul>
        </div>

        <Card className="w-full max-w-xl self-center shadow-2xl lg:max-w-md">
          <CardHeader className="space-y-4">
            <div className="flex justify-center">
              <div className="relative">
                <img src={APP_LOGO} alt={APP_TITLE} className="h-16 w-auto" />
                <div className="absolute -bottom-2 -right-2 rounded-full bg-blue-600 p-1">
                  <UserPlus className="h-4 w-4 text-white" />
                </div>
              </div>
            </div>
            <CardTitle className="text-center text-2xl">Registrar no {APP_TITLE}</CardTitle>
            <CardDescription className="text-center text-base">
              Preencha os dados para criar sua conta e entrar.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="name">Nome completo</Label>
                <Input
                  id="name"
                  type="text"
                  placeholder="Digite seu nome"
                  value={name}
                  onChange={(event) => setName(event.target.value)}
                  required
                  disabled={isLoading}
                  autoComplete="name"
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="email">E-mail</Label>
                <Input
                  id="email"
                  type="email"
                  placeholder="seuemail@exemplo.com"
                  value={email}
                  onChange={(event) => setEmail(event.target.value)}
                  required
                  disabled={isLoading}
                  autoComplete="email"
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="username">Usuário</Label>
                <Input
                  id="username"
                  type="text"
                  placeholder="Escolha um usuário"
                  value={username}
                  onChange={(event) => setUsername(event.target.value)}
                  required
                  disabled={isLoading}
                  autoComplete="username"
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="password">Senha</Label>
                <Input
                  id="password"
                  type="password"
                  placeholder="Crie uma senha"
                  value={password}
                  onChange={(event) => setPassword(event.target.value)}
                  required
                  disabled={isLoading}
                  autoComplete="new-password"
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="confirmPassword">Confirmar senha</Label>
                <Input
                  id="confirmPassword"
                  type="password"
                  placeholder="Repita a senha"
                  value={confirmPassword}
                  onChange={(event) => setConfirmPassword(event.target.value)}
                  required
                  disabled={isLoading}
                  autoComplete="new-password"
                />
              </div>

              <Button type="submit" className="w-full" disabled={isLoading}>
                {isLoading ? "Criando conta..." : "Registrar"}
              </Button>
            </form>

            <div className="mt-4 text-center text-sm">
              Já possui conta?{" "}
              <Link href="/login" className="text-blue-600 underline transition hover:text-blue-700">
                Entrar
              </Link>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
