import { Link } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { APP_LOGO } from "@/const";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";

export default function HowItWorks() {
  return (
    <div className="min-h-screen">
      {/* Hero Section */}
      <section className="bg-gradient-to-r from-copart-blue to-copart-blue-light text-white py-16">
        <div className="container">
          <div className="mb-6 inline-flex items-center gap-3 rounded-full bg-white/10 px-4 py-2 shadow-lg backdrop-blur">
            <img src={APP_LOGO} alt="Copart" className="h-8 w-auto drop-shadow-md" />
            <span className="text-sm font-semibold uppercase tracking-[0.15em] text-copart-orange">Copart Brasil</span>
          </div>
          <h1 className="text-4xl md:text-5xl font-bold mb-6">Como Funcionam os leilões de veículo</h1>
          <p className="text-xl mb-4">Mais de 10.000 carros, caminhões, SUVs, motocicletas e mais à venda</p>
          <p className="text-lg">
            A Copart do Brasil tem algo para todos - compradores de carros usados, desmontadores, revendedores, oficinas de reparo, compradores de salvados, etc.
          </p>
        </div>
      </section>

      {/* Main Content */}
      <section className="py-16">
        <div className="container max-w-5xl">
          <div className="grid md:grid-cols-2 gap-12 mb-16">
            <div>
              <h2 className="text-2xl font-bold text-copart-blue mb-4">Uma Forma Melhor de Comprar e Vender</h2>
              <p className="mb-4">Compre seu próximo carro no conforto da sua casa.</p>
              <ul className="space-y-3">
                <li>
                  <strong>Leilão online:</strong> Adquira o seu veículo em um leilão online, ou deixe que nosso software exclusivo faça os lances por você.
                </li>
                <li>
                  <strong>Compre Agora:</strong> Compre o veículo na hora de forma facilitada, diretamente no site!
                </li>
                <li>
                  <strong>Venda Meu Carro - VMC:</strong> Você pode vender seu veículo em qualquer estado, em nossos leilões ou na plataforma Compre Agora!
                </li>
              </ul>
            </div>

            <div>
              <h2 className="text-2xl font-bold text-copart-blue mb-4">Líder global na venda de veículos online</h2>
              <p className="mb-6">
                A Copart é líder global em venda de carros 100% online, ofertando veículos usados, salvados, entre outros.
              </p>
              <Link href="/find-vehicle">
                <Button className="bg-copart-blue-light hover:bg-blue-700 text-white">
                  Busque seu carro dos sonhos
                </Button>
              </Link>
            </div>
          </div>

          {/* Steps */}
          <h2 className="text-3xl font-bold text-copart-blue mb-8 text-center">Depois de se cadastrar:</h2>

          <div className="grid md:grid-cols-3 gap-8 mb-16">
            <Card>
              <CardContent className="p-6">
                <div className="bg-copart-orange text-white w-12 h-12 rounded-full flex items-center justify-center text-xl font-bold mb-4">
                  1
                </div>
                <h3 className="text-xl font-bold text-copart-blue mb-3">Faça login e envie os seus documentos</h3>
                <p className="text-sm mb-3">Os documentos te deixam apto a comprar na Copart!</p>
                <p className="text-sm"><strong>Se Pessoa Física:</strong> RG ou CNH completo (o documento deve conter o número de CPF).</p>
                <p className="text-sm mt-2"><strong>Se Pessoa Jurídica:</strong> RG ou CNH do representante ou titular da empresa e contrato social.</p>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-6">
                <div className="bg-copart-orange text-white w-12 h-12 rounded-full flex items-center justify-center text-xl font-bold mb-4">
                  2
                </div>
                <h3 className="text-xl font-bold text-copart-blue mb-3">Busque e Economize</h3>
                <p className="text-sm mb-3">
                  Navegue por 10.000 veículos todos os dias. Cadastre-se para receber alertas e ser notificado quando um novo veículo estiver disponível para compra.
                </p>
                <ul className="space-y-2 text-sm">
                  <li>
                    <Link href="/find-vehicle" className="text-copart-blue-light hover:underline">
                      Localizador de Veículos
                    </Link>
                  </li>
                  <li>
                    <Link href="/auctions" className="text-copart-blue-light hover:underline">
                      Calendário de Leilões
                    </Link>
                  </li>
                </ul>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-6">
                <div className="bg-copart-orange text-white w-12 h-12 rounded-full flex items-center justify-center text-xl font-bold mb-4">
                  3
                </div>
                <h3 className="text-xl font-bold text-copart-blue mb-3">Compre em nossos leilões ou "Compre Agora"</h3>
                <p className="text-sm mb-3">
                  Junte-se à emoção e aproveite a inovadora tecnologia de lances virtuais da Copart. Precisa de algo mais rápido? Explore nosso inventário "Compre Agora".
                </p>
                <ul className="space-y-2 text-sm">
                  <li>
                    <Link href="/auctions" className="text-copart-blue-light hover:underline">
                      Calendário de Leilões
                    </Link>
                  </li>
                  <li>
                    <Link href="/direct-sale" className="text-copart-blue-light hover:underline">
                      Compre Agora
                    </Link>
                  </li>
                </ul>
              </CardContent>
            </Card>
          </div>

          {/* Why Copart */}
          <h2 className="text-3xl font-bold text-copart-blue mb-8 text-center">Porque comprar e vender na Copart?</h2>

          <div className="grid md:grid-cols-2 gap-8 mb-16">
            <Card>
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-copart-blue mb-3">Veja antes de dar lances</h3>
                <p className="text-sm">
                  Quer ver um veículo pessoalmente? Visite um pátio da Copart para checar as condições do veículo antes de dar um lance.
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-copart-blue mb-3">Inventário Expansivo</h3>
                <p className="text-sm">
                  Com mais de 10.000 veículos à venda todos os dias, você certamente encontrará algo que se encaixa nas suas prioridades e gosto.
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-copart-blue mb-3">Ótimos Negócios: Compra e Venda</h3>
                <p className="text-sm">
                  Encontre algo que você ame a um ótimo preço, de marcas de luxo a carros esportivos e muito mais. Venda seu veículo de forma rápida e segura.
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-copart-blue mb-3">Leilões Diários ou Compre Agora</h3>
                <p className="text-sm">
                  Leilões diários de segunda a sexta a partir das 9:00. Não pode dar lances durante o dia? Junte-se a nós para nossos leilões noturnos. Ou utilize o Compre Agora e compre imediatamente no site.
                </p>
              </CardContent>
            </Card>
          </div>

          {/* FAQ */}
          <h2 className="text-3xl font-bold text-copart-blue mb-8 text-center">Perguntas Frequentes</h2>

          <Accordion type="single" collapsible className="w-full">
            <AccordionItem value="item-1">
              <AccordionTrigger className="text-left">Como começo a comprar na Copart?</AccordionTrigger>
              <AccordionContent>
                O primeiro passo para dar lances e comprar nos leilões da Copart ou no Compre Agora é fazer seu cadastro. O cadastro é totalmente gratuito e rápido. Envie seus documentos para começar a dar lances nos veículos.
              </AccordionContent>
            </AccordionItem>

            <AccordionItem value="item-2">
              <AccordionTrigger className="text-left">Como dou lances nos veículos em leilão?</AccordionTrigger>
              <AccordionContent>
                <p className="mb-3">Há dois tipos de lances na Copart:</p>
                <p className="mb-2"><strong>Lances Preliminares:</strong> Uma vez que o veículo está no site da Copart, se tiver cadastro e enviado seus documentos, pode realizar lances preliminares ("pré-lances") a qualquer momento até uma hora antes do início do leilão ao vivo.</p>
                <p><strong>Lances ao vivo (no leilão):</strong> Durante um leilão online ao vivo, se uma pessoa der um lance e for o mais alto, ele vence a disputa pela compra do veículo (sujeito à aprovação da venda pelo vendedor).</p>
              </AccordionContent>
            </AccordionItem>

            <AccordionItem value="item-3">
              <AccordionTrigger className="text-left">Como vender meu veículo na Copart?</AccordionTrigger>
              <AccordionContent>
                Venda seu carro na Copart em 4 passos simples: preencha o cadastro, receba atendimento personalizado para avaliação, seu veículo participa dos leilões para máxima visibilidade, e o pagamento é efetuado diretamente ao proprietário. Taxa de 1% do valor de venda + laudo cautelar.
              </AccordionContent>
            </AccordionItem>

            <AccordionItem value="item-4">
              <AccordionTrigger className="text-left">Como faço para retirar meu veículo após a compra?</AccordionTrigger>
              <AccordionContent>
                Depois de adquirir com sucesso um veículo da Copart, o próximo passo é retirá-lo. A Copart oferece 3 dias de armazenamento gratuito enquanto você organiza a coleta. Você precisará preencher o passe do portão com os dados da pessoa e do guincho que irá buscar o veículo.
              </AccordionContent>
            </AccordionItem>

            <AccordionItem value="item-5">
              <AccordionTrigger className="text-left">Como funciona o Compre Agora?</AccordionTrigger>
              <AccordionContent>
                Compre Agora é uma opção para quem quer comprar imediatamente os veículos disponíveis no site na modalidade Compre Agora. É uma modalidade que te dá opção de comprar veículos sem crivo de leilão. A compra é feita imediatamente ou você pode fazer uma oferta e aguardar a resposta do vendedor.
              </AccordionContent>
            </AccordionItem>
          </Accordion>
        </div>
      </section>
    </div>
  );
}
