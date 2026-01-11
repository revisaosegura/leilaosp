import { Link } from "wouter";
import { Button } from "@/components/ui/button";
import { APP_LOGO } from "@/const";

interface SimplePageProps {
  title: string;
  description: string;
  content?: string;
}

export default function SimplePage({ title, description, content }: SimplePageProps) {
  return (
    <div className="min-h-screen bg-gray-50">
      <section className="bg-copart-blue text-white py-16">
        <div className="container">
          <div className="mb-6 inline-flex items-center gap-3 rounded-full bg-white/10 px-4 py-2 shadow-lg backdrop-blur">
            <img src={APP_LOGO} alt="Copart" className="h-8 w-auto drop-shadow-md" />
            <span className="text-sm font-semibold uppercase tracking-[0.15em] text-copart-orange">Copart Brasil</span>
          </div>
          <h1 className="text-4xl md:text-5xl font-bold mb-4">{title}</h1>
          <p className="text-xl">{description}</p>
        </div>
      </section>

      <section className="py-16">
        <div className="container max-w-4xl">
          {content ? (
            <div className="prose max-w-none">
              <p className="text-gray-700 text-lg leading-relaxed">{content}</p>
            </div>
          ) : (
            <div className="text-center py-12">
              <p className="text-gray-600 mb-6">Esta página está em desenvolvimento.</p>
              <Link href="/">
                <Button className="bg-copart-blue-light hover:bg-blue-700">
                  Voltar para Início
                </Button>
              </Link>
            </div>
          )}
        </div>
      </section>
    </div>
  );
}

// Export specific pages
export function AuctionsPage() {
  return (
    <SimplePage
      title="Leilões"
      description="Participe dos nossos leilões online de veículos"
      content="Acompanhe os leilões diários de segunda a sexta-feira a partir das 9:00. Faça seus lances online de forma segura e prática. Mais de 70 leilões mensais com veículos de bancos, seguradoras e muito mais."
    />
  );
}

export function LocationsPage() {
  return (
    <SimplePage
      title="Localizações"
      description="Encontre os pátios da Copart mais próximos de você"
      content="A Copart possui pátios em diversas cidades do Brasil. Visite nossos pátios para verificar pessoalmente os veículos antes de dar seu lance. Oferecemos 3 dias úteis de armazenamento gratuito após a compra."
    />
  );
}

export function SupportPage() {
  return (
    <SimplePage
      title="Suporte"
      description="Estamos aqui para ajudar você"
      content="Entre em contato conosco através do WhatsApp (11) 95329-0242 ou email contato@copartosasco.com.br. Nossa equipe está pronta para responder suas dúvidas sobre compra, venda, leilões e muito mais."
    />
  );
}

export function SellMyCarPage() {
  return (
    <SimplePage
      title="Vender Meu Carro"
      description="Venda seu veículo de forma rápida e segura"
      content="Aceitamos veículos em qualquer estado, de qualquer marca e modelo. Você define o preço e a Copart cuida de todo o processo, do anúncio ao pagamento. Taxa de apenas 1% do valor de venda + laudo cautelar. Venda com segurança, sem encontros em lugares desconhecidos."
    />
  );
}

export function DirectSalePage() {
  return (
    <SimplePage
      title="Venda Direta"
      description="Compre veículos imediatamente sem leilão"
      content="Na Venda Direta você compra veículos com preço fixo, sem necessidade de participar de leilões. Todos os veículos possuem laudo, negociação intermediada pela Copart e diversas opções com garantia. Disponível 24 horas por dia, 7 dias por semana."
    />
  );
}

export function FindPartsPage() {
  return (
    <SimplePage
      title="Achar Peças"
      description="Encontre peças automotivas de qualidade"
      content="Procurando peças para seu veículo? Na Copart você encontra uma ampla variedade de peças automotivas de qualidade. Entre em contato para mais informações sobre disponibilidade e preços."
    />
  );
}
