import { useState } from "react";
import { useLocation } from "wouter";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { APP_TITLE, APP_LOGO } from "@/const";
import { useToast } from "@/hooks/use-toast";
import { Shield } from "lucide-react";

export default function AdminLogin() {
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
        // Verificar se é admin
        if (data.user.role !== 'admin') {
          toast({
            title: "Acesso negado",
            description: "Você não tem permissão para acessar o painel administrativo.",
            variant: "destructive",
          });
          return;
        }

        toast({
          title: "Login administrativo realizado",
          description: `Bem-vindo, ${data.user.name || data.user.username}!`,
        });
        
        // Redirect to admin panel
        setLocation("/admin");
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
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 p-4">
      <Card className="w-full max-w-md border-purple-500/20 bg-slate-900/50 backdrop-blur">
        <CardHeader className="space-y-4">
          <div className="flex justify-center">
            <div className="relative">
              <img src={APP_LOGO} alt={APP_TITLE} className="h-16 w-auto" />
              <div className="absolute -bottom-2 -right-2 bg-purple-600 rounded-full p-1">
                <Shield className="h-4 w-4 text-white" />
              </div>
            </div>
          </div>
          <CardTitle className="text-2xl text-center text-white">
            Painel Administrativo
          </CardTitle>
          <CardDescription className="text-center text-purple-200">
            Acesso restrito para administradores
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="username" className="text-white">Usuário Administrativo</Label>
              <Input
                id="username"
                type="text"
                placeholder="Digite seu usuário admin"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                required
                autoComplete="username"
                disabled={isLoading}
                className="bg-slate-800 border-purple-500/30 text-white placeholder:text-slate-400"
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="password" className="text-white">Senha</Label>
              <Input
                id="password"
                type="password"
                placeholder="Digite sua senha"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                autoComplete="current-password"
                disabled={isLoading}
                className="bg-slate-800 border-purple-500/30 text-white placeholder:text-slate-400"
              />
            </div>
            <Button 
              type="submit" 
              className="w-full bg-purple-600 hover:bg-purple-700" 
              disabled={isLoading}
            >
              {isLoading ? "Autenticando..." : "Acessar Painel Admin"}
            </Button>
          </form>
          <div className="mt-4 text-center">
            <a 
              href="/login" 
              className="text-sm text-purple-300 hover:text-purple-200 underline"
            >
              Acesso de usuário comum
            </a>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
