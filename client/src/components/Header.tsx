import { Link } from "wouter";
import { APP_LOGO } from "@/const";
import { Button } from "@/components/ui/button";
import { Search } from "lucide-react";
import { useState } from "react";

export default function Header() {
  const [searchQuery, setSearchQuery] = useState("");

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (searchQuery.trim()) {
      window.location.href = `/find-vehicle?search=${encodeURIComponent(searchQuery)}`;
    }
  };

  return (
    <>
      {/* Alert Banner */}
      <div className="bg-copart-orange text-white py-2 px-4 text-center text-sm">
        <span className="font-medium">Venda Seu Veículo De Forma Segura.</span> Acesse o link e{" "}
        <Link href="/sell-my-car" className="underline font-semibold">
          Saiba Mais ...&gt;
        </Link>
      </div>

      {/* Main Header */}
      <header className="bg-copart-blue text-white">
        <div className="container py-4">
          <div className="flex items-center justify-between gap-4 flex-wrap">
            {/* Logo */}
            <Link href="/">
              <img src={APP_LOGO} alt="Copart" className="h-10 md:h-12" />
            </Link>

            {/* Search Bar */}
            <form onSubmit={handleSearch} className="flex-1 max-w-2xl">
              <div className="relative flex items-center">
                <Search className="absolute left-3 text-gray-400" size={20} />
                <input
                  type="text"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  placeholder="Procurar por Marca, Modelo, Descrição, Chassis ou Número do Lote"
                  className="w-full pl-10 pr-24 py-2 rounded-md text-gray-900"
                />
                <Button
                  type="submit"
                  className="absolute right-1 bg-copart-blue-light hover:bg-blue-700 text-white"
                >
                  Buscar
                </Button>
              </div>
            </form>

            {/* Language & Auth */}
            <div className="flex items-center gap-3">
              <button className="text-sm hidden md:block">BRAZIL | Português</button>
              <Link href="/auth/register">
                <Button className="bg-copart-orange hover:bg-yellow-600 text-white">
                  Registrar
                </Button>
              </Link>
              <Link href="/auth/login">
                <Button variant="outline" className="bg-copart-blue-light hover:bg-blue-700 text-white border-0">
                  Entrar
                </Button>
              </Link>
            </div>
          </div>
        </div>

        {/* Navigation Menu */}
        <nav className="bg-copart-blue border-t border-gray-700">
          <div className="container">
            <ul className="flex items-center justify-center gap-6 py-3 text-sm flex-wrap">
              <li>
                <Link href="/" className="hover:text-copart-orange transition-colors">
                  Início
                </Link>
              </li>
              <li>
                <Link href="/how-it-works" className="hover:text-copart-orange transition-colors">
                  Como Funciona
                </Link>
              </li>
              <li>
                <Link href="/find-vehicle" className="hover:text-copart-orange transition-colors">
                  Encontrar um Veículo
                </Link>
              </li>
              <li>
                <Link href="/auctions" className="hover:text-copart-orange transition-colors">
                  Leilões
                </Link>
              </li>
              <li>
                <Link href="/locations" className="hover:text-copart-orange transition-colors">
                  Localizações
                </Link>
              </li>
              <li>
                <Link href="/support" className="hover:text-copart-orange transition-colors">
                  Suporte
                </Link>
              </li>
              <li>
                <Link href="/sell-my-car" className="hover:text-copart-orange transition-colors">
                  Vender Meu Carro
                </Link>
              </li>
              <li>
                <Link href="/direct-sale" className="hover:text-copart-orange transition-colors">
                  Venda Direta
                </Link>
              </li>
              <li>
                <Link href="/find-parts" className="hover:text-copart-orange transition-colors">
                  Achar Peças
                </Link>
              </li>
            </ul>
          </div>
        </nav>
      </header>
    </>
  );
}
