import { Link } from "wouter";
import { APP_LOGO } from "@/const";

export default function Footer() {
  return (
    <footer className="bg-copart-blue text-white mt-20">
      <div className="container py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Logo and Description */}
          <div>
            <img src={APP_LOGO} alt="Copart" className="h-10 mb-4" />
            <p className="text-sm text-gray-300">
              Conectando compradores e vendedores ao redor do mundo.
            </p>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="font-semibold mb-4">Links Rápidos</h3>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/how-it-works" className="text-gray-300 hover:text-copart-orange">
                  Como Funciona
                </Link>
              </li>
              <li>
                <Link href="/find-vehicle" className="text-gray-300 hover:text-copart-orange">
                  Encontrar Veículo
                </Link>
              </li>
              <li>
                <Link href="/auctions" className="text-gray-300 hover:text-copart-orange">
                  Leilões
                </Link>
              </li>
              <li>
                <Link href="/locations" className="text-gray-300 hover:text-copart-orange">
                  Localizações
                </Link>
              </li>
            </ul>
          </div>

          {/* Services */}
          <div>
            <h3 className="font-semibold mb-4">Serviços</h3>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/sell-my-car" className="text-gray-300 hover:text-copart-orange">
                  Vender Meu Carro
                </Link>
              </li>
              <li>
                <Link href="/direct-sale" className="text-gray-300 hover:text-copart-orange">
                  Venda Direta
                </Link>
              </li>
              <li>
                <Link href="/find-parts" className="text-gray-300 hover:text-copart-orange">
                  Achar Peças
                </Link>
              </li>
              <li>
                <Link href="/support" className="text-gray-300 hover:text-copart-orange">
                  Suporte
                </Link>
              </li>
            </ul>
          </div>

          {/* Contact */}
          <div>
            <h3 className="font-semibold mb-4">Contato</h3>
            <ul className="space-y-2 text-sm text-gray-300">
              <li>Email: contato@copartosasco.com.br</li>
              <li>Telefone: (11) 92127-1104</li>
              <li>WhatsApp: (11) 92127-1104</li>
            </ul>
          </div>
        </div>

        <div className="border-t border-gray-700 mt-8 pt-8 text-center text-sm text-gray-400">
          <p>&copy; {new Date().getFullYear()} Copart Brasil. Todos os direitos reservados.</p>
        </div>
      </div>
    </footer>
  );
}
