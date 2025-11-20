import { Link } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { trpc } from "@/lib/trpc";
import { Loader2 } from "lucide-react";

export default function Home() {
  const { data: vehicles, isLoading } = trpc.vehicles.list.useQuery({ limit: 4 });
  const { data: categories } = trpc.categories.list.useQuery();

  return (
    <div className="min-h-screen">
      {/* Hero Section */}
      <section className="bg-copart-blue text-white py-20 relative overflow-hidden">
        <div className="absolute inset-0 opacity-10">
          <div className="grid grid-cols-12 gap-4 h-full">
            {Array.from({ length: 48 }).map((_, i) => (
              <div key={i} className="border border-white/20"></div>
            ))}
          </div>
        </div>
        
        <div className="container relative z-10">
          <div className="grid md:grid-cols-2 gap-12 items-center">
            <div>
              <h1 className="text-4xl md:text-5xl font-bold mb-6">
                Conectando <span className="text-copart-orange">compradores</span> e{" "}
                <span className="text-copart-orange">vendedores</span> ao redor do mundo.
              </h1>
              <p className="text-xl mb-4">
                São + de <span className="text-copart-orange font-bold">12,462</span> veículos disponíveis para compra online.
              </p>
              <p className="text-lg text-gray-300">
                De automóveis a caminhões, motocicletas e muito mais.
              </p>
            </div>

            <div className="grid gap-6">
              {/* Venda Direta Card */}
              <Card className="bg-white/10 backdrop-blur border-0">
                <CardContent className="p-6">
                  <h3 className="text-copart-orange text-2xl font-bold mb-4">Venda Direta</h3>
                  <ul className="space-y-2 text-sm mb-6">
                    <li>✓ Disponível 24h horas por dia</li>
                    <li>✓ Veículos com laudo</li>
                    <li>✓ Negociação intermediada</li>
                    <li>✓ Diversas opções com garantia</li>
                  </ul>
                  <div className="flex gap-3">
                    <Link href="/direct-sale">
                      <Button className="bg-copart-orange hover:bg-yellow-600">Comprar</Button>
                    </Link>
                    <Link href="/sell-my-car">
                      <Button variant="outline" className="text-white border-white hover:bg-white/10">
                        Vender
                      </Button>
                    </Link>
                  </div>
                </CardContent>
              </Card>

              {/* Leilão Card */}
              <Card className="bg-white/10 backdrop-blur border-0">
                <CardContent className="p-6">
                  <h3 className="text-copart-orange text-2xl font-bold mb-4">Leilão</h3>
                  <ul className="space-y-2 text-sm mb-6">
                    <li>✓ + de 70 leilões mensais</li>
                    <li>✓ De Bancos, Seguradoras, e mais</li>
                    <li>✓ Faça seus lances online</li>
                    <li>✓ Veículos com procedência</li>
                  </ul>
                  <div className="flex gap-3">
                    <Link href="/auctions">
                      <Button className="bg-copart-orange hover:bg-yellow-600">Comprar</Button>
                    </Link>
                    <Link href="/sell-my-car">
                      <Button variant="outline" className="text-white border-white hover:bg-white/10">
                        Vender
                      </Button>
                    </Link>
                  </div>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </section>

      {/* Featured Vehicles */}
      <section className="py-16">
        <div className="container">
          <h2 className="text-3xl font-bold text-copart-blue mb-8">Veículos em destaque</h2>
          
          {isLoading ? (
            <div className="flex justify-center py-12">
              <Loader2 className="animate-spin" size={48} />
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              {vehicles?.map((vehicle) => (
                <Link key={vehicle.id} href={`/vehicle/${vehicle.id}`}>
                  <Card className="hover:shadow-lg transition-shadow">
                    <div className="aspect-video bg-gray-200 relative overflow-hidden">
                      {vehicle.imageUrl ? (
                        <img
                          src={vehicle.imageUrl}
                          alt={`${vehicle.year} ${vehicle.make} ${vehicle.model}`}
                          className="w-full h-full object-cover"
                        />
                      ) : (
                        <div className="w-full h-full flex items-center justify-center text-gray-400">
                          Sem imagem
                        </div>
                      )}
                    </div>
                    <CardContent className="p-4">
                      <h3 className="font-bold text-sm mb-2">
                        {vehicle.year} {vehicle.make} {vehicle.model}
                      </h3>
                      <p className="text-sm text-gray-600 mb-2">Nº Lote {vehicle.lotNumber}</p>
                      <p className="text-sm font-semibold text-copart-blue">
                        Lance Atual: R$ {vehicle.currentBid.toLocaleString('pt-BR')} BRL
                      </p>
                    </CardContent>
                  </Card>
                </Link>
              ))}
            </div>
          )}
        </div>
      </section>

      {/* Info Section */}
      <section className="bg-gray-50 py-16">
        <div className="container">
          <h2 className="text-3xl font-bold text-center mb-4">
            Mais opções, mais vantagens e <span className="text-copart-orange">toda a segurança</span> que você procura para comprar e vender.
          </h2>

          <div className="grid md:grid-cols-3 gap-8 mt-12">
            <Card>
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-copart-blue mb-4">Compre nos Leilões</h3>
                <p className="text-sm text-gray-600 mb-4">Economia real com liberdade de escolha</p>
                <ul className="space-y-2 text-sm text-gray-700">
                  <li>• Escolha o seu veículo em nosso catálogo</li>
                  <li>• Lance preliminar ou lances firmes</li>
                  <li>• Veículos com documentação regular</li>
                </ul>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-copart-blue mb-4">Compre na Venda Direta</h3>
                <p className="text-sm text-gray-600 mb-4">Segurança e tranquilidade para comprar e sair dirigindo</p>
                <ul className="space-y-2 text-sm text-gray-700">
                  <li>• Selecione o veículo desejado</li>
                  <li>• Compre Agora sem leilão</li>
                  <li>• Veículos sem registro de sinistro</li>
                </ul>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-copart-blue mb-4">Venda com a Copart</h3>
                <p className="text-sm text-gray-600 mb-4">Sem complicação e com a segurança da Copart</p>
                <ul className="space-y-2 text-sm text-gray-700">
                  <li>• Aceitamos todos os modelos</li>
                  <li>• Você define o preço</li>
                  <li>• A Copart cuida de todo o processo</li>
                </ul>
              </CardContent>
            </Card>
          </div>
        </div>
      </section>

      {/* About Section */}
      <section className="py-16">
        <div className="container max-w-4xl">
          <h2 className="text-3xl font-bold text-copart-blue mb-6">Quem é a Copart?</h2>
          <div className="space-y-4 text-gray-700">
            <p>
              Descubra a Copart, a plataforma líder em compra e venda de veículos. Reunimos em um só lugar um amplo catálogo de carros usados, recuperáveis e irrecuperáveis, oferecendo uma experiência simples, segura e eficiente tanto para quem quer comprar quanto para quem quer vender.
            </p>
            <p>
              Na Copart, você escolhe como quer negociar: comprando por meio de leilões dinâmicos ou através da Venda Direta, onde é possível adquirir veículos com valores fixos e imediatos, sem a necessidade de participar de um leilão. Para quem deseja vender, a Copart oferece uma oportunidade prática e segura de anunciar veículos de qualquer condição, alcançando milhares de compradores em todo o país.
            </p>
            <p>
              Atendemos a uma audiência diversificada, de consumidores finais e revendedores a desmontadores e oficinas, com total transparência e flexibilidade. Seja participando de um leilão ou comprando direto, a Copart transforma sua experiência automotiva. Cadastre-se e descubra como é simples comprar ou vender com quem mais entende de veículos.
            </p>
          </div>
          <div className="mt-8 text-center">
            <Link href="/auth/register">
              <Button className="bg-copart-orange hover:bg-yellow-600 text-white px-8 py-6 text-lg">
                Faça seu cadastro
              </Button>
            </Link>
          </div>
        </div>
      </section>

      {/* Categories Section */}
      <section className="bg-gray-50 py-16">
        <div className="container">
          <h2 className="text-3xl font-bold text-center text-copart-blue mb-4">
            Copart: sua plataforma de compra e venda online de veículos!
          </h2>
          
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6 mt-12">
            {categories?.slice(0, 4).map((category) => (
              <Link key={category.id} href={`/find-vehicle?category=${category.id}`}>
                <Card className="hover:shadow-lg transition-shadow">
                  <CardContent className="p-6 text-center">
                    <h3 className="font-bold text-copart-blue">{category.name}</h3>
                  </CardContent>
                </Card>
              </Link>
            ))}
          </div>

          <div className="text-center mt-8">
            <p className="text-gray-700">
              Cadastre-se agora para explorar uma ampla variedade de veículos, caminhões, motos, SUVs e muito mais.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
