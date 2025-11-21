import { Link } from "wouter";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { trpc } from "@/lib/trpc";
import { Loader2 } from "lucide-react";
import type { inferRouterOutputs } from "@trpc/server";
import type { AppRouter } from "../../../server/routers";

export default function Home() {
  const { data: vehicles, isLoading } = trpc.vehicles.list.useQuery({ limit: 4 });

  type RouterOutputs = inferRouterOutputs<AppRouter>;
  type VehicleList = RouterOutputs["vehicles"]["list"];

  const fallbackVehicles: VehicleList = [
    {
      id: 1,
      lotNumber: "1030820",
      year: 2015,
      make: "VOLKSWAGEN",
      model: "AMAROK",
      description: null,
      imageUrl:
        "https://images.unsplash.com/photo-1582541556083-4e6a3c451ca8?auto=format&fit=crop&w=1200&q=80",
      currentBid: 44390,
      buyNowPrice: null,
      locationId: 1,
      categoryId: 1,
      saleType: "auction",
      status: "active",
      hasWarranty: false,
      hasReport: true,
      createdAt: new Date(),
      updatedAt: new Date(),
      locationName: "Pátio Vila de Cava",
      locationCity: "Pátio Vila de Cava",
      locationState: "RJ",
    },
    {
      id: 2,
      lotNumber: "1030828",
      year: 2018,
      make: "JEEP",
      model: "COMPASS",
      description: null,
      imageUrl:
        "https://images.unsplash.com/photo-1552519507-34a95f24dc86?auto=format&fit=crop&w=1200&q=80",
      currentBid: 34930,
      buyNowPrice: null,
      locationId: 1,
      categoryId: 1,
      saleType: "auction",
      status: "active",
      hasWarranty: false,
      hasReport: true,
      createdAt: new Date(),
      updatedAt: new Date(),
      locationName: "Pátio Vila de Cava",
      locationCity: "Pátio Vila de Cava",
      locationState: "RJ",
    },
    {
      id: 3,
      lotNumber: "1030871",
      year: 2023,
      make: "FERRARI",
      model: "SF90 STRADALE",
      description: null,
      imageUrl:
        "https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1200&q=80",
      currentBid: 34270,
      buyNowPrice: null,
      locationId: 1,
      categoryId: 1,
      saleType: "auction",
      status: "active",
      hasWarranty: false,
      hasReport: true,
      createdAt: new Date(),
      updatedAt: new Date(),
      locationName: "Pátio Vila de Cava",
      locationCity: "Pátio Vila de Cava",
      locationState: "RJ",
    },
    {
      id: 4,
      lotNumber: "1030829",
      year: 2016,
      make: "CHEVROLET",
      model: "S10 CABINE DUPLA",
      description: null,
      imageUrl:
        "https://images.unsplash.com/photo-1542293787938-4d4f0b8f3021?auto=format&fit=crop&w=1200&q=80",
      currentBid: 35480,
      buyNowPrice: null,
      locationId: 1,
      categoryId: 1,
      saleType: "auction",
      status: "active",
      hasWarranty: false,
      hasReport: true,
      createdAt: new Date(),
      updatedAt: new Date(),
      locationName: "Pátio Vila de Cava",
      locationCity: "Pátio Vila de Cava",
      locationState: "RJ",
    },
  ];

  const featuredVehicles =
    vehicles && vehicles.length > 0
      ? vehicles
      : process.env.NODE_ENV === "development"
        ? fallbackVehicles
        : [];

  const heroStats = [
    { label: "Lotes Hoje", value: "12,541" },
    { label: "Hoje", value: "0" },
    { label: "Amanhã", value: "0" },
    { label: "Semana", value: "7,038" },
    { label: "Coletores", value: "14" },
  ];

  const partnerRows = [
    [
      {
        name: "Consórcio Embracon",
        color: "#b2101c",
        tagline: "nacional líder no seu consórcio",
        weight: "font-black",
      },
      {
        name: "gente",
        color: "#0092c7",
        tagline: "seguros",
        weight: "font-extrabold",
      },
      {
        name: "gol plus",
        color: "#f99f00",
        tagline: "",
        weight: "font-black",
      },
      {
        name: "justos",
        color: "#0f1116",
        tagline: "",
        weight: "font-black",
      },
      {
        name: "usebens",
        color: "#00a3b4",
        tagline: "seguradora",
        weight: "font-extrabold",
      },
      {
        name: "Porto",
        color: "#1f4d9c",
        tagline: "",
        weight: "font-black",
      },
    ],
    [
      { name: "Allianz", color: "#003781", tagline: "", weight: "font-black" },
      {
        name: "BANCO TOYOTA",
        color: "#4b2d2d",
        tagline: "Tudo o que você busca em um Consórcio",
        weight: "font-black",
      },
      { name: "CNP Seguradora", color: "#0f1f3d", tagline: "", weight: "font-black" },
    ],
  ];

  return (
    <div className="min-h-screen">
      {/* Hero Section */}
      <section className="relative overflow-hidden bg-[#0a1a36] pb-16 pt-4 text-white">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_20%_20%,rgba(255,184,56,0.18),transparent_35%),radial-gradient(circle_at_80%_-10%,rgba(35,101,246,0.4),transparent_32%)]" />
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_30%_60%,rgba(255,255,255,0.08),transparent_35%)]" />
        <div className="absolute inset-0 bg-gradient-to-br from-[#071224] via-[#0c1d39] to-[#0d1f3e] opacity-90" />
        <div className="absolute -right-24 top-10 hidden w-[780px] opacity-70 lg:block">
          <img
            src="https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1500&q=80"
            alt="Car highlight"
            className="h-full w-full object-contain"
          />
        </div>

        <div className="container relative z-10 space-y-8">
          <div className="flex flex-col gap-4 rounded-2xl border border-white/10 bg-white/5 px-5 py-4 shadow-[0_12px_40px_rgba(0,0,0,0.35)] backdrop-blur-lg lg:px-7">
            <div className="flex flex-col items-start gap-4 lg:flex-row lg:items-center lg:justify-between">
              <div className="flex items-center gap-6">
                <div className="flex items-center gap-3 rounded-full bg-white/90 px-4 py-2 shadow-[0_8px_24px_rgba(0,0,0,0.2)]">
                  <img
                    src="https://upload.wikimedia.org/wikipedia/commons/9/99/Copart_logo.png"
                    alt="Copart"
                    className="h-10 w-auto drop-shadow"
                  />
                  <span className="hidden text-xs font-semibold uppercase tracking-[0.1em] text-[#0c1a34] sm:block">
                    Marketplace
                  </span>
                </div>
                <nav className="hidden items-center gap-4 text-sm font-semibold text-[#c8d6f2] xl:flex">
                  <Link href="#como-funciona" className="transition hover:text-white">
                    Como Funciona
                  </Link>
                  <Link href="#encontre-seu-veiculo" className="transition hover:text-white">
                    Encontre seu veículo
                  </Link>
                  <Link href="#quero-vender" className="transition hover:text-white">
                    Quero vender meu carro
                  </Link>
                  <Link href="#venda-direta" className="transition hover:text-white">
                    Venda Direta
                  </Link>
                  <Link href="#vender-meu-carro" className="transition hover:text-white">
                    Vender Meu Carro
                  </Link>
                </nav>
              </div>

              <div className="flex w-full flex-col gap-3 lg:w-auto lg:flex-row lg:items-center">
                <div className="flex flex-1 items-center gap-2 rounded-full border border-white/15 bg-white/15 px-4 py-2 text-sm text-[#dbe6ff] shadow-inner">
                  <input
                    type="text"
                    placeholder="Procurar por Marca, Modelo, Descrição, Chassis ou Número do Lote"
                    className="h-10 w-full bg-transparent text-sm text-white placeholder:text-[#9fb0d6] focus:outline-none"
                  />
                  <Button className="h-10 rounded-full bg-copart-orange px-5 text-sm font-semibold text-copart-blue hover:bg-[#ffca65]">
                    Buscar
                  </Button>
                </div>
                <div className="flex items-center gap-2 text-[11px] font-semibold text-[#dbe6ff]">
                  <Button variant="outline" className="h-10 rounded-full border-white/30 px-4 text-xs text-white hover:bg-white/10">
                    🇧🇷 BRAZIL
                  </Button>
                  <Button variant="outline" className="h-10 rounded-full border-white/30 px-4 text-xs text-white hover:bg-white/10">
                    Português
                  </Button>
                  <Link href="/auth/login">
                    <Button className="h-10 rounded-full bg-[#f9ad29] px-4 text-xs font-semibold text-[#142a4f] shadow-md hover:bg-[#ffbe4f]">
                      Registrar
                    </Button>
                  </Link>
                  <Link href="/auth/register">
                    <Button variant="outline" className="h-10 rounded-full border-white/30 px-4 text-xs text-white hover:bg-white/10">
                      Entrar
                    </Button>
                  </Link>
                </div>
              </div>
            </div>
          </div>

          <div className="grid items-start gap-8 lg:grid-cols-[1.15fr_0.85fr]">
            <div className="space-y-6 rounded-3xl border border-white/10 bg-white/5 p-8 shadow-[0_24px_48px_rgba(0,0,0,0.35)] backdrop-blur-lg">
              <div className="flex flex-wrap items-center gap-2 text-[13px] font-semibold uppercase tracking-wide text-[#f7c560]">
                <span className="rounded-full bg-white/10 px-3 py-1">A venda dos veículos se inicia ao fim do prazo</span>
                <span className="rounded-full bg-white/10 px-3 py-1">Online e Transparente</span>
              </div>

              <h1 className="text-4xl font-black leading-[1.05] text-white md:text-5xl">
                Conectando compradores e vendedores ao redor do mundo.
              </h1>

              <div className="rounded-2xl bg-white/95 p-5 text-copart-blue shadow-2xl">
                <div className="grid gap-3 md:grid-cols-4">
                  <select className="rounded-lg border border-gray-200 bg-white px-3 py-3 text-sm font-medium shadow-sm focus:border-copart-orange focus:outline-none md:col-span-1">
                    <option>Disponibilidade</option>
                  </select>
                  <select className="rounded-lg border border-gray-200 bg-white px-3 py-3 text-sm font-medium shadow-sm focus:border-copart-orange focus:outline-none md:col-span-1">
                    <option>Localidade</option>
                  </select>
                  <div className="md:col-span-2">
                    <div className="flex overflow-hidden rounded-lg border border-gray-200 bg-white shadow-sm focus-within:border-copart-orange">
                      <input
                        type="text"
                        placeholder="Pesquisar por Marca, Modelo, Descrição, Chassis ou Número do Lote"
                        className="w-full px-4 py-3 text-sm text-gray-700 focus:outline-none"
                      />
                      <Button className="h-auto rounded-none bg-copart-orange px-6 text-base font-semibold text-copart-blue hover:bg-[#ffca65]">
                        Buscar
                      </Button>
                    </div>
                  </div>
                </div>
              </div>

              <p className="text-lg text-[#c7d4ec]">
                São + de 12,541 veículos disponíveis para compra online. De automóveis a caminhões, motocicletas e muito mais.
              </p>

              <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-5">
                {heroStats.map((stat) => (
                  <div
                    key={stat.label}
                    className="rounded-xl border border-white/10 bg-white/5 p-4 text-center shadow-inner shadow-black/10"
                  >
                    <div className="text-xl font-extrabold text-white md:text-2xl">{stat.value}</div>
                    <div className="text-xs font-medium uppercase tracking-wide text-[#a8b8d8]">{stat.label}</div>
                  </div>
                ))}
              </div>
            </div>

            <div className="space-y-4">
              <Link href="/sell-my-car" className="block">
                <div className="rounded-xl bg-gradient-to-r from-[#f9ad29] to-[#ffca65] px-4 py-3 text-center text-sm font-semibold text-[#1b2f55] shadow-lg shadow-black/20 transition hover:shadow-[0_12px_30px_rgba(0,0,0,0.25)]">
                  Venda seu veículo de forma segura. Acesse o link e saiba mais.
                </div>
              </Link>

              <div className="overflow-hidden rounded-3xl border border-white/15 bg-gradient-to-br from-[#1a2f58] via-[#142748] to-[#0f1e3a] p-6 shadow-[0_20px_50px_rgba(0,0,0,0.35)] backdrop-blur-lg">
                <div className="mb-6 flex items-center justify-between">
                  <h3 className="text-2xl font-bold text-white">Venda Direta</h3>
                  <span className="rounded-full bg-white/10 px-3 py-1 text-xs font-semibold uppercase text-[#f9ad29]">
                    +1200 ativos
                  </span>
                </div>
                <ul className="mb-8 space-y-2 text-sm text-[#e4ecff]">
                  <li className="flex items-start gap-2">
                    <span className="mt-0.5 h-2 w-2 rounded-full bg-copart-orange" />
                    Disponível 24h horas por dia
                  </li>
                  <li className="flex items-start gap-2">
                    <span className="mt-0.5 h-2 w-2 rounded-full bg-copart-orange" />
                    Veículos com laudo
                  </li>
                  <li className="flex items-start gap-2">
                    <span className="mt-0.5 h-2 w-2 rounded-full bg-copart-orange" />
                    Negociação intermediada
                  </li>
                  <li className="flex items-start gap-2">
                    <span className="mt-0.5 h-2 w-2 rounded-full bg-copart-orange" />
                    Diversas opções com garantia
                  </li>
                </ul>
                <div className="flex gap-3">
                  <Link href="/direct-sale">
                    <Button className="bg-copart-orange px-6 font-semibold text-copart-blue shadow-md hover:bg-[#ffca65]">
                      Comprar
                    </Button>
                  </Link>
                  <Link href="/sell-my-car">
                    <Button
                      variant="outline"
                      className="border-white text-white hover:bg-white/10 hover:text-white"
                    >
                      Vender
                    </Button>
                  </Link>
                </div>
              </div>

              <div className="overflow-hidden rounded-3xl border border-white/15 bg-gradient-to-br from-[#1a2f58] via-[#142748] to-[#0f1e3a] p-6 shadow-[0_20px_50px_rgba(0,0,0,0.35)] backdrop-blur-lg">
                <div className="mb-6 flex items-center justify-between">
                  <h3 className="text-2xl font-bold text-white">Leilão</h3>
                  <span className="rounded-full bg-white/10 px-3 py-1 text-xs font-semibold uppercase text-[#f9ad29]">
                    +70/mês
                  </span>
                </div>
                <ul className="mb-8 space-y-2 text-sm text-[#e4ecff]">
                  <li className="flex items-start gap-2">
                    <span className="mt-0.5 h-2 w-2 rounded-full bg-copart-orange" />
                    + de 70 leilões mensais
                  </li>
                  <li className="flex items-start gap-2">
                    <span className="mt-0.5 h-2 w-2 rounded-full bg-copart-orange" />
                    De Bancos, Seguradoras, e mais
                  </li>
                  <li className="flex items-start gap-2">
                    <span className="mt-0.5 h-2 w-2 rounded-full bg-copart-orange" />
                    Faça seus lances online
                  </li>
                  <li className="flex items-start gap-2">
                    <span className="mt-0.5 h-2 w-2 rounded-full bg-copart-orange" />
                    Veículos com procedência
                  </li>
                </ul>
                <div className="flex gap-3">
                  <Link href="/auctions">
                    <Button className="bg-copart-orange px-6 font-semibold text-copart-blue shadow-md hover:bg-[#ffca65]">
                      Comprar
                    </Button>
                  </Link>
                  <Link href="/sell-my-car">
                    <Button
                      variant="outline"
                      className="border-white text-white hover:bg-white/10 hover:text-white"
                    >
                      Vender
                    </Button>
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="py-16 bg-gradient-to-b from-white to-[#f5f7fb]">
        <div className="container">
          <div className="mb-8 flex items-center justify-between">
            <h2 className="text-3xl font-bold text-[#1e6bff]">Veículos em destaque</h2>
          </div>

          {isLoading ? (
            <div className="flex justify-center py-12">
              <Loader2 className="animate-spin" size={48} />
            </div>
          ) : (
            <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-4">
              {featuredVehicles.map((vehicle, index) => (
                <Link key={vehicle.id} href={`/vehicle/${vehicle.id}`} className="block h-full">
                  <Card className="group relative h-full overflow-hidden rounded-xl border border-[#d6e4ff] bg-white shadow-[0_8px_24px_rgba(20,99,231,0.08)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_12px_32px_rgba(20,99,231,0.15)]">
                    <div className="relative aspect-[4/3] overflow-hidden">
                      {index === 0 && (
                        <div className="absolute left-0 top-3 z-10 flex items-center gap-2 rounded-r-full bg-[#2462e7] px-3 py-1 text-[11px] font-semibold uppercase tracking-wide text-white shadow-md">
                          <span className="h-2 w-2 rounded-full bg-white" />
                          Super Destaques
                        </div>
                      )}
                      {vehicle.imageUrl ? (
                        <img
                          src={vehicle.imageUrl}
                          alt={`${vehicle.year} ${vehicle.make} ${vehicle.model}`}
                          className="h-full w-full object-cover transition duration-200 group-hover:scale-105"
                        />
                      ) : (
                        <div className="flex h-full w-full items-center justify-center bg-gray-100 text-gray-400">
                          Sem imagem
                        </div>
                      )}
                    </div>

                    <CardContent className="space-y-2 px-4 pb-5 pt-4">
                      <h3 className="text-base font-semibold leading-tight text-gray-900 line-clamp-2">
                        {vehicle.year} {vehicle.make} {vehicle.model}
                      </h3>
                      <p className="text-sm font-semibold text-[#1e6bff] underline decoration-[#1e6bff]/40">
                        Nº Lote {vehicle.lotNumber}
                      </p>
                      <p className="text-xs text-gray-600">
                        {vehicle.locationCity && vehicle.locationState
                          ? `${vehicle.locationCity} - ${vehicle.locationState}`
                          : "Localidade não informada"}
                      </p>
                      <div className="pt-1 text-sm font-semibold text-[#0aa156]">
                        <span className="font-medium text-gray-700">Lance Atual:</span>{" "}
                        R$ {vehicle.currentBid.toLocaleString("pt-BR", { minimumFractionDigits: 2 })} BRL
                      </div>
                      <Button className="mt-3 w-full rounded-md bg-[#1e6bff] text-sm font-semibold text-white shadow-sm hover:bg-[#1657d4]">
                        Visualizar Veículo
                      </Button>
                    </CardContent>
                  </Card>
                </Link>
              ))}
            </div>
          )}
        </div>
      </section>

      {/* Info Section */}
      <section className="relative overflow-hidden bg-gradient-to-b from-[#f7f9fc] to-[#eef2fb] py-20">
        <div className="pointer-events-none absolute left-0 top-10 h-64 w-64 -translate-x-16 rounded-3xl bg-[radial-gradient(circle_at_center,_#b7c7ff_2px,_transparent_2px)] bg-[length:18px_18px]" />

        <div className="container relative">
          <div className="text-center">
            <h2 className="text-3xl font-extrabold text-[#1f4fa1]">Um mar de oportunidades</h2>
            <p className="mt-3 text-base text-[#637093]">
              Mais opções, mais vantagens e <span className="text-copart-orange">toda a segurança</span> que você procura para comprar e vender.
            </p>
          </div>

          <div className="mt-14 grid gap-6 md:grid-cols-3">
            {[1, 2, 3].map((card) => (
              <div
                key={card}
                className="relative flex h-full flex-col rounded-xl bg-gradient-to-b from-[#0c1a3a] via-[#0c1a3a] to-[#0b1631] p-8 shadow-[0_18px_40px_rgba(13,30,66,0.45)]"
              >
                <div className="absolute inset-x-8 top-0 h-[3px] rounded-b-full bg-gradient-to-r from-[#7c8bff] via-white/40 to-[#3f7cff]" />

                {card === 1 && (
                  <>
                    <h3 className="pt-3 text-xl font-bold text-white">Compre nos Leilões</h3>
                    <p className="mt-2 text-sm text-[#b9c4e5]">Economia real com liberdade de escolha</p>
                    <ul className="mt-5 space-y-3 text-sm text-[#d6def8]">
                      <li className="flex gap-2">
                        <span className="mt-[6px] h-2 w-2 rounded-full bg-[#87b1ff]" />
                        Escolha seu veículo em nosso catálogo, veja as fotos e dados do veículo.
                      </li>
                      <li className="flex gap-2">
                        <span className="mt-[6px] h-2 w-2 rounded-full bg-[#87b1ff]" />
                        Lance preliminar ou definitivo e acompanhe o fechamento do leilão com datas e horários definidos.
                      </li>
                      <li className="flex gap-2">
                        <span className="mt-[6px] h-2 w-2 rounded-full bg-[#87b1ff]" />
                        Você leva o veículo se não houver lances firmes.
                      </li>
                      <li className="flex gap-2">
                        <span className="mt-[6px] h-2 w-2 rounded-full bg-[#87b1ff]" />
                        Veículos com documentação regular.
                      </li>
                    </ul>
                  </>
                )}

                {card === 2 && (
                  <>
                    <h3 className="pt-3 text-xl font-bold text-white">Compre na Venda Direta</h3>
                    <p className="mt-2 text-sm text-[#b9c4e5]">Segurança e tranquilidade para comprar e sair dirigindo</p>
                    <ul className="mt-5 space-y-3 text-sm text-[#d6def8]">
                      <li className="flex gap-2">
                        <span className="mt-[6px] h-2 w-2 rounded-full bg-[#87b1ff]" />
                        Selecione o veículo desejado e agende sua visita.
                      </li>
                      <li className="flex gap-2">
                        <span className="mt-[6px] h-2 w-2 rounded-full bg-[#87b1ff]" />
                        Sem o processo de leilão - conte com as vantagens do botão “Compre Agora”.
                      </li>
                      <li className="flex gap-2">
                        <span className="mt-[6px] h-2 w-2 rounded-full bg-[#87b1ff]" />
                        Veículos sem registro de sinistro.
                      </li>
                    </ul>
                  </>
                )}

                {card === 3 && (
                  <>
                    <h3 className="pt-3 text-xl font-bold text-white">Venda com a Copart</h3>
                    <p className="mt-2 text-sm text-[#b9c4e5]">Mais agilidade e segurança da Copart</p>
                    <ul className="mt-5 space-y-3 text-sm text-[#d6def8]">
                      <li className="flex gap-2">
                        <span className="mt-[6px] h-2 w-2 rounded-full bg-[#87b1ff]" />
                        Veículos com ou sem documentação, danificados, sinistrados ou recuperados.
                      </li>
                      <li className="flex gap-2">
                        <span className="mt-[6px] h-2 w-2 rounded-full bg-[#87b1ff]" />
                        Conte com o acompanhamento de especialistas para definir o valor do seu veículo.
                      </li>
                      <li className="flex gap-2">
                        <span className="mt-[6px] h-2 w-2 rounded-full bg-[#87b1ff]" />
                        Veículos sem documentos ou sucatas podem ser arrematados.
                      </li>
                    </ul>
                  </>
                )}
              </div>
            ))}
          </div>

          <div className="mt-12 text-center">
            <Link href="/auth/register">
              <Button className="rounded-full bg-gradient-to-r from-[#7056ff] via-[#6c50f6] to-[#8a73ff] px-10 py-6 text-lg font-semibold text-white shadow-[0_14px_30px_rgba(73,63,183,0.35)] hover:shadow-[0_18px_40px_rgba(73,63,183,0.45)]">
                Cadastre-se Agora
              </Button>
            </Link>
          </div>
        </div>
      </section>

      {/* Inventory Search */}
      <section className="bg-white py-16">
        <div className="container">
          <div className="rounded-[28px] border border-[#e1e8f5] bg-white shadow-[0_12px_40px_rgba(16,48,118,0.1)]">
            <div className="px-6 pt-10 text-center md:px-10">
              <h2 className="text-3xl font-bold text-[#1f4fa1] md:text-[32px]">Pesquisar Inventário da Copart</h2>
            </div>

            <div className="mt-10 border-t border-[#e6ecf7] px-4 md:px-8">
              <div className="-mt-[1px] flex flex-wrap gap-6 text-sm font-semibold text-[#7a8cae] md:gap-10">
                {[
                  "Pesquisas Populares",
                  "Destaques",
                  "Marcas",
                  "Categorias",
                ].map((tab, index) => (
                  <button
                    key={tab}
                    className={`relative pb-4 transition ${index === 0 ? "text-[#0c56d3]" : "hover:text-[#0c56d3]"}`}
                  >
                    {tab}
                    {index === 0 && (
                      <span className="absolute inset-x-0 -bottom-[1px] h-0.5 rounded-full bg-[#0c56d3]" />
                    )}
                  </button>
                ))}
              </div>
            </div>

            <div className="mt-2 grid gap-10 px-4 pb-10 pt-8 md:grid-cols-[1.2fr_0.8fr] md:px-10">
              <div className="grid gap-8 md:grid-cols-[0.9fr_1.1fr]">
                <div className="space-y-4">
                  <h3 className="text-base font-semibold text-[#2a3f68]">Itens Mais Populares</h3>
                  <div className="grid grid-cols-2 gap-x-10 gap-y-3 text-[15px] font-medium text-[#153b77] sm:grid-cols-3 lg:grid-cols-4">
                    {["FIAT", "VOLKSWAGEN", "HONDA", "FORD", "PEUGEOT", "BMW", "HYUNDAI", "TOYOTA", "RENAULT", "MITSUBISHI", "CNM", "CNH"].map((brand) => (
                      <span key={brand} className="leading-6">
                        {brand}
                      </span>
                    ))}
                  </div>
                </div>

                <div className="space-y-4">
                  <h3 className="text-base font-semibold text-[#2a3f68]">Marcas / modelos</h3>
                  <div className="grid grid-cols-2 gap-x-10 gap-y-3 text-[15px] font-medium text-[#153b77] sm:grid-cols-3 lg:grid-cols-4">
                    {[
                      "GOL",
                      "ONIX",
                      "CELTA",
                      "S10",
                      "FIESTA",
                      "MOTOR DA PARTIDA",
                      "SPIN",
                      "ECOSPORT",
                      "FIORINO",
                      "FINANCIAMENTO",
                      "PICAPES PEQUENAS",
                      "MÉDIA MONTA",
                      "MOTOR DA PARTIDA",
                      "MONTANA",
                      "PALIO",
                      "MOTOR FIRE",
                      "AUTOMÓVEIS",
                      "PICKUP DIESEL",
                      "REPARÁVEIS",
                      "PICAPE MEDIA",
                      "PICAPE MEDIA",
                      "UNIVERSAL",
                      "UNIVERSAL",
                      "BLINDADO",
                    ].map((item, idx) => (
                      <span key={`${item}-${idx}`} className="leading-6">
                        {item}
                      </span>
                    ))}
                  </div>
                </div>

                <div className="md:col-span-2">
                  <Button className="mx-auto block rounded-full bg-[#165be0] px-8 py-3 text-sm font-semibold text-white shadow-lg shadow-[#165be0]/30 hover:bg-[#0f4ec2]">
                    VER MAIS
                  </Button>
                </div>
              </div>

              <div className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-[#0c4cdb] via-[#0d5ce4] to-[#0f78e6] p-2 shadow-[0_16px_40px_rgba(12,83,223,0.35)]">
                <div className="absolute inset-0 bg-[radial-gradient(circle_at_20%_20%,rgba(255,255,255,0.16),transparent_35%),radial-gradient(circle_at_80%_10%,rgba(255,255,255,0.14),transparent_32%)]" />
                <div className="relative h-full rounded-[22px] bg-white/5 p-3">
                  <div className="relative h-full overflow-hidden rounded-[18px] bg-[#0d62e0]">
                    <img
                      src="https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=900&q=80"
                      alt="Lojista"
                      className="h-full w-full object-cover opacity-95"
                    />
                    <div className="absolute inset-0 bg-gradient-to-b from-transparent via-[#0a3ea3]/30 to-[#0a3ea3]/75" />
                    <div className="absolute inset-0 flex flex-col items-center justify-center px-6 text-center text-white">
                      <p className="text-lg font-extrabold uppercase tracking-[0.08em] text-white/95">LOJISTA,</p>
                      <p className="mt-1 text-base font-semibold">Você também pode vender conosco!</p>
                      <div className="mt-6 w-full max-w-[240px] rounded-md bg-white/95 px-4 py-3 text-center text-sm font-bold uppercase text-[#0c4cdb] shadow-[0_10px_30px_rgba(0,0,0,0.15)]">
                        Confira
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* About + Categories Section */}
      <section className="relative overflow-hidden bg-gradient-to-br from-[#0d2046] via-[#0a3982] to-[#0e7be4] py-16 text-white">
        <div className="absolute inset-0 opacity-40" style={{
          backgroundImage:
            "radial-gradient(circle at 20% 30%, rgba(255,255,255,0.15), transparent 28%), radial-gradient(circle at 80% 20%, rgba(255,255,255,0.18), transparent 30%), radial-gradient(circle at 50% 70%, rgba(255,255,255,0.12), transparent 32%)",
        }} />
        <div className="container relative grid gap-12 lg:grid-cols-[1.05fr_1fr] items-center">
          <div className="space-y-5">
            <h2 className="text-3xl font-bold">Quem é a Copart?</h2>
            <p className="leading-relaxed text-white/90">
              Descubra a Copart, a plataforma líder em compra e venda de veículos. Reunimos em um só lugar um amplo catálogo de carros usados, recuperáveis e irrecuperáveis, oferecendo uma experiência simples, segura e eficiente tanto para quem quer comprar quanto para quem quer vender.
            </p>
            <p className="leading-relaxed text-white/90">
              Na Copart, você escolhe como quer negociar: comprando por meio de leilões dinâmicos ou através da Venda Direta, onde é possível adquirir veículos com valores fixos e imediatos, sem a necessidade de participar de um leilão. Para quem deseja vender, a Copart oferece uma oportunidade prática e segura de anunciar veículos de qualquer condição, alcançando milhares de compradores em todo o país.
            </p>
            <p className="leading-relaxed text-white/90">
              Atendemos a uma audiência diversificada, de consumidores finais e revendedores a desmontadores e oficinas, com total transparência e flexibilidade. Seja participando de um leilão ou comprando direto, a Copart transforma sua experiência automotiva. Cadastre-se e descubra como é simples comprar ou vender com quem mais entende de veículos.
            </p>
            <Link href="/auth/register" className="inline-block">
              <Button className="rounded-md bg-gradient-to-r from-[#f5b400] via-[#faae3f] to-[#f5b400] px-8 py-6 text-lg font-semibold text-[#0b1e3c] shadow-[0_15px_40px_rgba(0,0,0,0.25)] transition hover:brightness-[1.08]">
                Faça seu cadastro
              </Button>
            </Link>
          </div>

          <div className="grid gap-4 md:grid-cols-2">
            {[
              {
                title: "Venda Direta",
                accent: "Confira",
                items: ["Volkswagen", "Pequena Monta", "Grande Monta"],
                image:
                  "https://images.unsplash.com/photo-1493238792000-8113da705763?auto=format&fit=crop&w=1000&q=80",
              },
              {
                title: "Automóveis",
                accent: "Confira",
                items: ["Volkswagen", "Pequena Monta", "Grande Monta"],
                image:
                  "https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1000&q=80",
              },
              {
                title: "Caminhões",
                accent: "Confira",
                items: ["Placas Grandes", "Pequena Monta", "Grande Monta"],
                image:
                  "https://images.unsplash.com/photo-1523987355523-c7b5b84bec92?auto=format&fit=crop&w=1000&q=80",
              },
              {
                title: "Motocicletas",
                accent: "Confira",
                items: ["CG-150", "Pequena Monta", "Grande Monta"],
                image:
                  "https://images.unsplash.com/photo-1502877828070-33dc21e1ee05?auto=format&fit=crop&w=1000&q=80",
              },
            ].map((card) => (
              <Link key={card.title} href="/find-vehicle">
                <Card className="group h-full overflow-hidden rounded-xl border-0 bg-gradient-to-b from-white/10 via-white/8 to-white/5 shadow-[0_18px_40px_rgba(0,0,0,0.2)] transition hover:-translate-y-1 hover:shadow-[0_24px_60px_rgba(0,0,0,0.25)]">
                  <div className="relative h-24">
                    <img
                      src={card.image}
                      alt={card.title}
                      className="h-full w-full object-cover"
                    />
                    <div className="absolute inset-0 bg-gradient-to-b from-black/20 via-black/0 to-black/30" />
                  </div>
                  <CardContent className="p-5 text-white">
                    <div className="flex items-center justify-between">
                      <h3 className="text-lg font-semibold">{card.title}</h3>
                      <span className="text-sm font-semibold uppercase tracking-wide text-[#f3c24b]">
                        {card.accent}
                      </span>
                    </div>
                    <div className="mt-3 space-y-1 text-sm text-white/90">
                      {card.items.map((item) => (
                        <div key={item} className="flex items-center gap-2">
                          <span className="inline-block h-1.5 w-1.5 rounded-full bg-[#f3c24b]" />
                          <span>{item}</span>
                        </div>
                      ))}
                    </div>
                  </CardContent>
                </Card>
              </Link>
            ))}
          </div>
        </div>

        <div className="container relative mt-12 space-y-10">
          <div className="rounded-3xl bg-white px-6 py-10 shadow-[0_18px_50px_rgba(0,0,0,0.18)] sm:px-10">
            <div className="grid items-center gap-8 md:grid-cols-[1.1fr_0.9fr]">
              <div className="space-y-5 text-center md:text-left">
                <h3 className="text-3xl font-bold text-[#0c1e3d]">Nossas Mídias Sociais</h3>
                <p className="text-base leading-7 text-[#1f2f4d]">
                  Cadastre-se agora para explorar uma ampla variedade de veículos, caminhões, motos, SUVs e muito mais.
                </p>
              </div>

              <div className="flex flex-col items-center justify-center gap-4 md:items-end">
                <div className="flex items-center gap-3 text-[#0c1e3d]">
                  {[
                    { key: "facebook", url: "https://cdn.simpleicons.org/facebook/0c1e3d" },
                    { key: "linkedin", url: "https://cdn.simpleicons.org/linkedin/0c1e3d" },
                    { key: "instagram", url: "https://cdn.simpleicons.org/instagram/0c1e3d" },
                    { key: "youtube", url: "https://cdn.simpleicons.org/youtube/0c1e3d" },
                    { key: "whatsapp", url: "https://cdn.simpleicons.org/whatsapp/0c1e3d" },
                  ].map((platform) => (
                    <div
                      key={platform.key}
                      className="flex h-11 w-11 items-center justify-center rounded-full border border-[#d7deed] bg-white text-[#0c1e3d] shadow-[0_6px_20px_rgba(12,30,61,0.08)]"
                    >
                      <span className="sr-only">{platform.key}</span>
                      <img src={platform.url} alt={platform.key} className="h-5 w-5" />
                    </div>
                  ))}
                </div>
                <Button className="rounded-full bg-[#f4a300] px-6 py-3 text-base font-semibold text-[#0c1e3d] shadow-[0_10px_24px_rgba(244,163,0,0.35)] transition hover:brightness-[1.05]">
                  Cadastre-se
                </Button>
              </div>
            </div>
          </div>

          <div className="space-y-6 text-center">
            <h3 className="text-2xl font-bold text-white">Nossos Parceiros</h3>
            <div className="space-y-4 rounded-3xl bg-white/10 px-6 py-6 shadow-[0_16px_40px_rgba(0,0,0,0.18)] backdrop-blur-sm">
              {partnerRows.map((row, index) => (
                <div key={index} className="flex flex-wrap items-center justify-center gap-6 lg:gap-10">
                  {row.map((partner) => (
                    <div
                      key={partner.name}
                      className="flex h-16 min-w-[180px] items-center justify-center rounded-xl bg-white/90 px-5 py-3 shadow-[0_12px_28px_rgba(0,0,0,0.12)] transition hover:-translate-y-0.5 hover:shadow-[0_18px_36px_rgba(0,0,0,0.16)]"
                    >
                      <div className="flex flex-col items-center leading-tight text-center">
                        <span
                          className={`text-lg ${partner.weight}`}
                          style={{ color: partner.color }}
                        >
                          {partner.name}
                        </span>
                        {partner.tagline && (
                          <span className="text-[11px] font-semibold uppercase tracking-wide text-[#2e3b55]">
                            {partner.tagline}
                          </span>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
