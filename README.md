# Copart Brasil - Réplica do Site Oficial

Réplica completa do site da Copart Brasil (www.copart.com.br) desenvolvida com React, TypeScript, Tailwind CSS, Node.js e MySQL.

## 🚀 Tecnologias Utilizadas

- **Frontend**: React 19 + TypeScript + Tailwind CSS 4
- **Backend**: Node.js + Express + tRPC
- **Banco de Dados**: MySQL (TiDB)
- **Autenticação**: Manus OAuth
- **Testes**: Vitest
- **Deploy**: Render (plano gratuito)

## 📋 Funcionalidades

### Frontend
- ✅ Página inicial com hero section e veículos em destaque
- ✅ Página "Como Funciona" com FAQ
- ✅ Busca de veículos com filtros (categoria, tipo de venda, busca por texto)
- ✅ Página de detalhes do veículo
- ✅ Páginas de Leilões, Localizações, Suporte
- ✅ Páginas de Venda Direta e Vender Meu Carro
- ✅ Botão flutuante do WhatsApp (http://wa.me/5511921271104)
- ✅ Design responsivo (desktop e mobile)
- ✅ Cores fiéis ao original (#1a2332 azul escuro, #f7a600 laranja)

### Backend
- ✅ API tRPC com endpoints para veículos, categorias, localizações
- ✅ Sistema de lances
- ✅ Painel administrativo com controle de acesso
- ✅ Autenticação com Manus OAuth
- ✅ Banco de dados MySQL com seeds

### Painel Administrativo
- ✅ Dashboard com estatísticas
- ✅ Gerenciamento de veículos (CRUD)
- ✅ Gerenciamento de usuários
- ✅ Gerenciamento de leilões
- ✅ Controle de acesso por role (admin/user)

## 🗄️ Estrutura do Banco de Dados

- **users**: Usuários do sistema (com role: admin/user)
- **vehicles**: Veículos disponíveis para leilão ou venda direta
- **categories**: Categorias de veículos (Automóveis, Caminhões, Motocicletas, etc.)
- **locations**: Pátios/localizações da Copart
- **auctions**: Leilões
- **bids**: Lances dos usuários
- **partners**: Parceiros da Copart

## 🔧 Instalação e Desenvolvimento

### Pré-requisitos
- Node.js 22+
- pnpm
- Acesso ao banco de dados MySQL

### Instalação

```bash
# Clonar o repositório
git clone https://github.com/SEU_USUARIO/copart-brasil-replica.git
cd copart-brasil-replica

# Instalar dependências
pnpm install

# Configurar variáveis de ambiente
# As variáveis já estão configuradas automaticamente pelo Manus

# Aplicar migrations do banco de dados
pnpm db:push

# Popular banco de dados com dados de exemplo
node seed.mjs

# Iniciar servidor de desenvolvimento
pnpm dev
```

O servidor estará disponível em `http://localhost:3000`

### Executar Testes

```bash
pnpm test
```

## 🚀 Deploy no Render

### Opção 1: Deploy Manual

1. Crie uma conta no [Render](https://render.com)
2. Crie um novo Web Service
3. Conecte seu repositório GitHub
4. Configure as variáveis de ambiente:
   - `DATABASE_URL`: String de conexão MySQL
   - Outras variáveis serão configuradas automaticamente

5. Deploy será feito automaticamente

### Opção 2: Deploy com render.yaml

O projeto já inclui um arquivo `render.yaml` para configuração automática:

```yaml
services:
  - type: web
    name: copart-brasil
    env: node
    buildCommand: pnpm install && pnpm build
    startCommand: pnpm start
    envVars:
      - key: NODE_ENV
        value: production
```

### Banco de Dados no Render

1. No Render, crie um novo MySQL database
2. Copie a string de conexão
3. Configure como variável de ambiente `DATABASE_URL`
4. Execute as migrations: `pnpm db:push`
5. Popule o banco: `node seed.mjs`

## 📝 Credenciais de Acesso

### Painel Administrativo
- **URL**: `/admin`
- **Acesso**: Requer autenticação via Manus OAuth
- **Role**: Apenas usuários com role "admin" podem acessar

Para tornar um usuário admin, execute no banco de dados:
```sql
UPDATE users SET role = 'admin' WHERE email = 'seu-email@exemplo.com';
```

## 🔗 Links Importantes

- **Site em Produção**: [Será configurado após deploy]
- **Repositório GitHub**: [Será configurado]
- **Documentação Manus**: https://manus.im

## 📱 Contato WhatsApp

O botão flutuante do WhatsApp redireciona para: http://wa.me/5511921271104

## 🎨 Design

O design replica fielmente o site original da Copart Brasil:
- Cores: Azul escuro (#1a2332) e Laranja (#f7a600)
- Layout responsivo
- Componentes shadcn/ui
- Tailwind CSS para estilização

## 🧪 Testes

O projeto inclui testes unitários para:
- Endpoints de veículos (list, getById)
- Filtros de busca
- Controle de acesso administrativo
- Autenticação

Execute com: `pnpm test`

## 📦 Scripts Disponíveis

```bash
pnpm dev          # Inicia servidor de desenvolvimento
pnpm build        # Build para produção
pnpm start        # Inicia servidor de produção
pnpm test         # Executa testes
pnpm db:push      # Aplica migrations do banco de dados
```

## 🤝 Contribuindo

Este é um projeto de réplica para fins educacionais. Contribuições são bem-vindas!

## 📄 Licença

Este projeto é uma réplica não oficial do site da Copart Brasil, desenvolvido para fins educacionais.

## ✨ Próximos Passos Sugeridos

1. **Integração com Gateway de Pagamento**: Adicionar Stripe ou PagSeguro para processar pagamentos
2. **Sistema de Notificações**: Implementar notificações em tempo real para lances
3. **Upload de Imagens**: Permitir upload de múltiplas imagens para veículos
4. **Relatórios**: Adicionar relatórios de vendas e estatísticas no painel admin
5. **API de Busca Avançada**: Implementar busca com Elasticsearch para melhor performance

---

Desenvolvido com ❤️ usando Manus AI
