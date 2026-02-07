import { useState } from "react";
import { Link } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/hooks/use-toast";
import { APP_LOGO, APP_TITLE } from "@/const";
import { Mail, PhoneCall, Undo2, MessageSquareText } from "lucide-react";

export default function ForgotPassword() {
  const { toast } = useToast();
  const [identifier, setIdentifier] = useState("");
  const [notes, setNotes] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    setIsSubmitting(true);

    setTimeout(() => {
      toast({
        title: "Solicitação registrada",
        description:
          "Nossa equipe entrará em contato para ajudar com a redefinição da sua senha. Verifique seu email ou WhatsApp.",
      });
      setIdentifier("");
      setNotes("");
      setIsSubmitting(false);
    }, 400);
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 p-4">
      <Card className="w-full max-w-3xl shadow-xl">
        <div className="grid md:grid-cols-[1.05fr_0.95fr]">
          <div className="border-b md:border-b-0 md:border-r border-gray-100 dark:border-gray-800 bg-white/80 dark:bg-gray-900/60 backdrop-blur">
            <CardHeader className="space-y-3">
              <div className="flex items-center gap-3">
                <img src={APP_LOGO} alt={APP_TITLE} className="h-10 w-auto" />
                <div>
                  <p className="text-xs uppercase tracking-[0.18em] text-copart-orange">Acesso seguro</p>
                  <CardTitle className="text-2xl">Esqueceu sua senha?</CardTitle>
                </div>
              </div>
              <CardDescription>
                Informe seu usuário ou email e descreva como prefere ser contatado para concluir a redefinição.
              </CardDescription>
            </CardHeader>
            <CardContent>
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="identifier">Usuário ou email</Label>
                  <Input
                    id="identifier"
                    placeholder="ex: joao.silva ou joao@exemplo.com"
                    value={identifier}
                    onChange={(event) => setIdentifier(event.target.value)}
                    required
                    disabled={isSubmitting}
                  />
                </div>
                <div className="space-y-2">
                  <div className="flex items-center justify-between">
                    <Label htmlFor="notes">Detalhes adicionais (opcional)</Label>
                    <span className="text-xs text-muted-foreground">Como prefere ser contatado?</span>
                  </div>
                  <Textarea
                    id="notes"
                    placeholder="Inclua seu telefone WhatsApp, melhor horário ou qualquer detalhe que facilite o contato."
                    value={notes}
                    onChange={(event) => setNotes(event.target.value)}
                    disabled={isSubmitting}
                    rows={4}
                  />
                </div>
                <Button type="submit" className="w-full" disabled={isSubmitting}>
                  {isSubmitting ? "Enviando..." : "Enviar solicitação"}
                </Button>
                <p className="text-xs text-muted-foreground text-center leading-relaxed">
                  Por segurança, a redefinição é concluída manualmente por nossa equipe. Responderemos usando os contatos
                  cadastrados ou os dados informados acima.
                </p>
              </form>
            </CardContent>
            <CardFooter className="flex justify-center gap-3 pt-0 pb-6">
              <Link href="/login" className="flex items-center gap-2 text-sm text-blue-600 hover:text-blue-700">
                <Undo2 className="h-4 w-4" /> Voltar para login
              </Link>
            </CardFooter>
          </div>

          <div className="bg-gradient-to-br from-copart-blue via-blue-700 to-indigo-700 text-white">
            <CardHeader className="space-y-2">
              <CardTitle className="text-xl">Atendimento imediato</CardTitle>
              <CardDescription className="text-blue-50">
                Fale diretamente com o suporte para acelerar a recuperação da sua conta.
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-start gap-3 rounded-lg bg-white/10 p-4 shadow-sm">
                <MessageSquareText className="h-5 w-5 mt-0.5" />
                <div>
                  <p className="text-sm font-semibold">WhatsApp</p>
                  <p className="text-sm text-blue-50">(11) 95993-9239</p>
                  <a
                    className="text-sm text-copart-orange hover:underline"
                    href="http://wa.me/5511959939239?text=Preciso+redefinir+minha+senha"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    Iniciar conversa
                  </a>
                </div>
              </div>

              <div className="flex items-start gap-3 rounded-lg bg-white/10 p-4 shadow-sm">
                <Mail className="h-5 w-5 mt-0.5" />
                <div>
                  <p className="text-sm font-semibold">Email</p>
                  <p className="text-sm text-blue-50">contato@copart.website</p>
                  <a
                    className="text-sm text-copart-orange hover:underline"
                    href="mailto:contato@copart.website?subject=Redefini%C3%A7%C3%A3o%20de%20senha"
                  >
                    Enviar email
                  </a>
                </div>
              </div>

              <div className="flex items-start gap-3 rounded-lg bg-white/10 p-4 shadow-sm">
                <PhoneCall className="h-5 w-5 mt-0.5" />
                <div>
                  <p className="text-sm font-semibold">Telefone</p>
                  <p className="text-sm text-blue-50">(11) 95993-9239</p>
                  <p className="text-xs text-blue-100">Segunda a sexta, 9h às 18h</p>
                </div>
              </div>

              <div className="rounded-lg bg-white/5 p-4 text-sm text-blue-50 leading-relaxed">
                <p className="font-semibold text-white mb-1">Dicas rápidas</p>
                <ul className="list-disc list-inside space-y-1">
                  <li>Mantenha seus dados de contato atualizados no perfil.</li>
                  <li>Confirme se tem acesso ao email cadastrado.</li>
                  <li>Não compartilhe códigos ou senhas com terceiros.</li>
                </ul>
              </div>
            </CardContent>
          </div>
        </div>
      </Card>
    </div>
  );
}
