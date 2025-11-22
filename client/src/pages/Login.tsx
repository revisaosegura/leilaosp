import { useState } from "react";
import { Link, useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { APP_TITLE, APP_LOGO } from "@/const";
import { useToast } from "@/hooks/use-toast";
import { User } from "lucide-react";

export default function Login() {
  const [, setLocation] = useLocation();
  const { toast } = useToast();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    try {
      const response = await fetch("/api/auth/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ username, password }),
      });

      const data = await response.json();

      if (response.ok) {
        // Redirecionar admin para painel admin
        if (data.user.role === 'admin') {
          toast({
            title: "Redirecionando...",
            description: "Você será redirecionado para o painel administrativo.",
          });
          setLocation("/admin");
          return;
        }

        toast({
          title: "Login realizado com sucesso",
          description: `Bem-vindo, ${data.user.name || data.user.username}!`,
        });
        
        // Redirect to user dashboard
        setLocation("/dashboard");
      } else {
        toast({
          title: "Erro ao fazer login",
          description: data.error || "Credenciais inválidas",
          variant: "destructive",
        });
      }
    } catch (error) {
      toast({
        title: "Erro ao fazer login",
        description: "Ocorreu um erro ao tentar fazer login. Tente novamente.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 p-4">
      <Card className="w-full max-w-md">
        <CardHeader className="space-y-4">
          <div className="flex justify-center">
            <div className="relative">
              <img src={APP_LOGO} alt={APP_TITLE} className="h-16 w-auto" />
              <div className="absolute -bottom-2 -right-2 bg-blue-600 rounded-full p-1">
                <User className="h-4 w-4 text-white" />
              </div>
            </div>
          </div>
          <CardTitle className="text-2xl text-center">Entrar no {APP_TITLE}</CardTitle>
          <CardDescription className="text-center">
            Digite suas credenciais para acessar sua conta
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="username">Usuário</Label>
              <Input
                id="username"
                type="text"
                placeholder="Digite seu usuário"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                required
                autoComplete="username"
                disabled={isLoading}
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="password">Senha</Label>
              <Input
                id="password"
                type="password"
                placeholder="Digite sua senha"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                autoComplete="current-password"
                disabled={isLoading}
              />
            </div>
            <Button type="submit" className="w-full" disabled={isLoading}>
              {isLoading ? "Entrando..." : "Entrar"}
            </Button>
          </form>
          <div className="mt-4 text-center text-sm">
            <Link
              href="/auth/register"
              className="text-blue-600 underline transition hover:text-blue-700"
            >
              Criar nova conta
            </Link>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
