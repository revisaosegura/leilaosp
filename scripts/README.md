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
