import { Link } from "wouter";
import { APP_LOGO } from "@/const";
import { Button } from "@/components/ui/button";
import { Search, User } from "lucide-react";
import { useState } from "react";
import { useAuth } from "@/_core/hooks/useAuth";
import "./Header.css";

export default function Header() {
  const [searchQuery, setSearchQuery] = useState("");
  const { user } = useAuth();

  const navLinks = [
    { label: "Início", href: "/" },
    { label: "Como Funciona", href: "/how-it-works" },
    { label: "Encontrar um Veículo", href: "/find-vehicle" },
    { label: "Leilões", href: "/auctions" },
    { label: "Localizações", href: "/locations" },
    { label: "Suporte", href: "/support" },
    { label: "Vender Meu Carro", href: "/sell-my-car" },
    { label: "Venda Direta", href: "/direct-sale" },
    { label: "Achar Peças", href: "/find-parts" },
  ];

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (searchQuery.trim()) {
      window.location.href = `/find-vehicle?search=${encodeURIComponent(searchQuery)}`;
    }
  };

  return (
    <>
      <header className="bg-[#0b1834] text-white shadow-[0_12px_42px_rgba(0,0,0,0.5)]">
        <div className="border-b border-white/12 bg-[#0f1f41]/95 backdrop-blur">
          <div className="container flex flex-col gap-4 py-4 lg:flex-row lg:items-center">
            <div className="flex w-full flex-col gap-3 lg:flex-row lg:items-center lg:gap-4 lg:max-w-4xl">
              <Link href="/" className="shrink-0">
                <img
                  src={APP_LOGO}
                  alt="Copart"
                  className="h-10 drop-shadow-[0_10px_20px_rgba(0,0,0,0.35)] lg:h-12"
                />
              </Link>

              <form onSubmit={handleSearch} className="w-full min-w-0">
                <div className="relative flex flex-wrap items-stretch gap-2 overflow-hidden rounded-2xl border border-[#dfe3ec] bg-white/98 p-2 shadow-[0_18px_42px_rgba(0,0,0,0.38)] sm:flex-nowrap sm:gap-0 sm:rounded-full sm:p-0">
                  <div className="flex h-11 items-center rounded-xl border-b border-[#e4e6ed] px-4 sm:h-auto sm:rounded-none sm:border-b-0 sm:border-r">
                    <Search className="text-[#8b97b5]" size={20} />
                  </div>
                  <input
                    type="text"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    placeholder="Procurar por Marca, Modelo, Descrição, Chassis ou Número do Lote"
                    className="min-w-0 flex-1 rounded-xl px-3 py-2 text-[15px] font-semibold text-[#1b2f55] placeholder:text-[#97a4c4] focus:outline-none sm:rounded-none sm:py-3"
                  />
                  <Button
                    type="submit"
                    className="h-11 w-full rounded-xl bg-[#f6b330] px-6 text-[15px] font-bold uppercase tracking-[0.1em] text-[#0f254f] shadow-none hover:bg-[#ffc850] sm:h-auto sm:w-auto sm:rounded-none sm:rounded-r-full"
                  >
                    Buscar
                  </Button>
                </div>
              </form>
            </div>

            <div className="flex flex-wrap items-center justify-between gap-2 text-[11px] font-semibold lg:ml-auto">
              <Button
                variant="outline"
                className="hidden h-10 rounded-full border-white/25 px-4 text-[11px] uppercase tracking-[0.1em] text-white hover:bg-white/10 md:inline-flex"
              >
                🇧🇷 Brazil
              </Button>
              <Button
                variant="outline"
                className="hidden h-10 rounded-full border-white/25 px-4 text-[11px] uppercase tracking-[0.1em] text-white hover:bg-white/10 md:inline-flex"
              >
                Português
              </Button>
              {user ? (
                <Link href={user.role === "admin" ? "/admin" : "/dashboard"}>
                  <Button className="h-10 rounded-full bg-copart-orange px-4 text-[11px] font-semibold uppercase tracking-[0.12em] text-[#142a4f] shadow-[0_12px_20px_rgba(0,0,0,0.26)] hover:bg-[#ffbe4f]">
                    <User size={16} className="mr-2" />
                    {user.role === "admin" ? "Painel Admin" : "Meu Painel"}
                  </Button>
                </Link>
              ) : (
                <div className="flex items-center gap-2">
                  <Link href="/login">
                    <Button className="h-10 rounded-full bg-[#f7ae2d] px-4 text-[11px] font-semibold uppercase tracking-[0.12em] text-[#142a4f] shadow-[0_12px_20px_rgba(0,0,0,0.26)] hover:bg-[#ffbe4f]">
                      Registrar
                    </Button>
                  </Link>
                  <Link href="/login">
                    <Button variant="outline" className="h-10 rounded-full border-white/25 px-4 text-[11px] font-semibold uppercase tracking-[0.12em] text-white hover:bg-white/10">
                      Entrar
                    </Button>
                  </Link>
                </div>
              )}
            </div>
          </div>
        </div>

        <div className="bg-gradient-to-r from-[#0c1b39] via-[#0c1834] to-[#0b1834]">
          <div className="container py-5">
            <nav className="hidden flex items-center justify-center gap-1 text-[14px] font-semibold uppercase tracking-[0.11em] xl:flex">
              {navLinks.map(({ label, href }, index, arr) => (
                <Link
                  key={label}
                  href={href}
                  className="relative px-3 py-2 transition hover:text-copart-orange"
                >
                  {label}
                  {index < arr.length - 1 && <span className="absolute right-0 top-1/2 h-4 w-px -translate-y-1/2 bg-white/12" />}
                </Link>
              ))}
            </nav>
          </div>
        </div>

        <nav className="border-t border-white/10 bg-[#0b1932] xl:hidden">
          <div className="container">
            <ul className="flex flex-nowrap items-center gap-5 overflow-x-auto py-3 text-sm scrollbar-none" aria-label="Navegação principal mobile">
              {navLinks.map(({ label, href }) => (
                <li key={label}>
                  <Link href={href} className="transition hover:text-copart-orange">
                    {label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        </nav>
      </header>
    </>
  );
}
