# Scripts do Banco de Dados

## seed-database.sql

Script para popular o banco de dados **PostgreSQL** com dados de exemplo para desenvolvimento e testes.

### O que este script faz:

- Limpa dados existentes (veículos, categorias, localizações, parceiros)
- Insere 5 localizações (pátios) em diferentes cidades
- Insere 7 categorias de veículos
- Insere 20 veículos de exemplo com diferentes características
- Insere 5 parceiros

### Como executar:

```bash
# Via psql
psql -U postgres -d leilaosp -f scripts/seed-database.sql

# Ou com variável de ambiente
PGPASSWORD=sua_senha psql -U postgres -d leilaosp -f scripts/seed-database.sql

# Ou conectando via URL
psql postgresql://postgres:senha@localhost:5432/leilaosp -f scripts/seed-database.sql
```

### ⚠️ Atenção

Este script **deleta todos os dados** das tabelas antes de inserir os novos dados usando `TRUNCATE`. 
**NÃO execute em ambiente de produção** sem fazer backup primeiro!

### Requisitos

- PostgreSQL 12 ou superior (testado com PostgreSQL 18)
- Banco de dados `leilaosp` já criado
- Permissões para executar TRUNCATE e INSERT

### Dados inseridos:

#### Localizações (5)
- Pátio São Paulo - Guarulhos
- Pátio Campinas
- Pátio Rio de Janeiro
- Pátio Belo Horizonte
- Pátio Curitiba

#### Categorias (7)
- Carros de Passeio
- SUVs e Utilitários
- Caminhonetes
- Motos
- Veículos Comerciais
- Veículos Salvados
- Veículos Premium

#### Veículos (20)
Diversos veículos incluindo:
- Volkswagen Gol, Chevrolet Onix, Fiat Argo
- Honda Civic, Toyota Corolla
- Jeep Compass, Hyundai Creta, VW T-Cross
- Fiat Toro, Toyota Hilux, Chevrolet S10
- Motos Honda e Yamaha
- BMW 320i, Mercedes-Benz C180
- E mais...

#### Parceiros (5)
- Banco do Brasil
- Caixa Econômica
- Bradesco
- Itaú
- Santander

### Criar o banco de dados (se necessário)

```bash
# Conectar ao PostgreSQL como superuser
psql -U postgres

# Criar o banco de dados
CREATE DATABASE leilaosp;

# Sair
\q
```

### Aplicar migrations do Drizzle

Antes de executar o seed, certifique-se de que as tabelas foram criadas:

```bash
# Gerar e aplicar migrations
pnpm db:push
```

## copart-scraper.ts

Script para realizar scraping da página de listagem de veículos da Copart Brasil, extraindo dados como lote, modelo, imagens e lances atuais a partir do payload `__NEXT_DATA__` da aplicação Next.js.

### Como executar

Alguns provedores da Copart devolvem **403 Forbidden** se o acesso não inclui o cookie de sessão do usuário autenticado. Informe-o via
variável de ambiente `COPART_COOKIE` (no formato `NOME=valor; OUTRO=valor`), por exemplo:

```bash
# Usando a URL padrão da listagem de Leilão
COPART_COOKIE="SSO=...; locale=pt_BR" npx tsx scripts/copart-scraper.ts

# Ou informando outra URL da Copart Brasil
COPART_COOKIE="SSO=...; locale=pt_BR" npx tsx scripts/copart-scraper.ts "https://www.copart.com.br/search/leil%C3%A3o/?displayStr=Leil%C3%A3o&from=%2FvehicleFinder"

# Caso já tenha salvo o HTML da página (por exemplo, via navegador autenticado), processe-o offline:
COPART_HTML_FILE=./pagina.html npx tsx scripts/copart-scraper.ts
```

O resultado é salvo em `scripts/output/copart-preview.json` com o horário da captura e a lista completa de veículos normalizados.

### Prévia do formato de saída

Um exemplo gerado manualmente pode ser consultado em `scripts/output/copart-preview.sample.json` para visualizar o formato esperado do arquivo final.
