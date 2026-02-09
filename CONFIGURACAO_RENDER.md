# Configuração do Render

## Variáveis de Ambiente Necessárias

Para que o sistema funcione corretamente no Render, você precisa configurar as seguintes variáveis de ambiente:

### 1. OAuth (Autenticação Manus)

```
VITE_OAUTH_PORTAL_URL=https://oauth.manus.im
VITE_APP_ID=seu-app-id-aqui
```

**Como obter o APP_ID:**
1. Acesse https://manus.im
2. Vá em configurações do projeto
3. Copie o App ID

### 2. Banco de Dados

```
DATABASE_URL=postgresql://leilaosp_user:ZBI9see0qaBUUuSFJJwrkzrCXuAwUpsi@dpg-d5hg446mcj7s73b0oou0-a/leilaosp
```

**Exemplo:**
```
DATABASE_URL=postgresql://leilaosp_user:ZBI9see0qaBUUuSFJJwrkzrCXuAwUpsi@dpg-d5hg446mcj7s73b0oou0-a/leilaosp
```

### 3. Configuração do App

```
VITE_APP_TITLE=Copart Brasil
```

### 4. Admin (Opcional)

Para definir um usuário como administrador:

```
OWNER_OPENID=seu-openid-aqui
```

**Como obter o OPENID:**
1. Faça login no sistema
2. Abra o console do navegador (F12)
3. Digite: `localStorage.getItem('manus-runtime-user-info')`
4. Copie o valor do campo `openId`

### 5. Analytics (Opcional)

Para evitar erros de conexão no frontend, defina estas variáveis (pode deixar vazio se não usar):

```
VITE_ANALYTICS_ENDPOINT=""
VITE_ANALYTICS_WEBSITE_ID=""
```

---

## Como Configurar no Render

**⚠️ MUITO IMPORTANTE:**
Ao criar o serviço no Render, selecione **"Web Service"** (Serviço Web).
**NÃO** selecione "Static Site", pois isso fará com que apenas o frontend funcione e a API (login, veículos) retorne erro 404.

1. Acesse o dashboard do Render
2. Crie um novo **Web Service**
3. Vá em **Environment**
4. Clique em **Add Environment Variable**
5. Adicione cada variável listada acima
6. Clique em **Save Changes**
7. O Render fará redeploy automaticamente

---

## Caminhos Corretos


### Para Usuários:
- **Home:** `https://copart.website/`
- **Login:** Clique em "Entrar" no header
- **Painel do Usuário:** `https://copart.website/dashboard`


### Para Administradores:
- **Painel Admin:** `https://copart.website/admin`
- **Gerenciar Veículos:** `https://copart.website/admin/vehicles`
- **Gerenciar Usuários:** `https://copart.website/admin/users`
- **Gerenciar Lances:** `https://copart.website/admin/bids`

**Importante:** Você precisa estar logado com uma conta que tenha `role: "admin"` para acessar o painel administrativo.

---

## Tornando um Usuário Admin

### Opção 1: Via Variável de Ambiente (Recomendado)
1. Configure `OWNER_OPENID` com o openId do usuário
2. Faça logout e login novamente
3. O usuário será automaticamente admin

### Opção 2: Via Banco de Dados
Execute no banco de dados:

```sql
UPDATE users 
SET role = 'admin' 
WHERE email = 'seu-email@exemplo.com';
```

---

## Solução de Problemas

### Erro: "An unexpected error occurred. TypeError: Failed to construct 'URL': Invalid URL"

**Causa:** Variáveis de ambiente `VITE_OAUTH_PORTAL_URL` ou `VITE_APP_ID` não estão configuradas.

**Solução:**
1. Configure as variáveis de ambiente no Render
2. Faça redeploy
3. Aguarde o build completar

### Erro: "Acesso Negado"

**Causa:** Usuário não tem role de admin.

**Solução:**
1. Configure `OWNER_OPENID` ou
2. Altere o role no banco de dados

### Erro: "Cannot connect to database"

**Causa:** `DATABASE_URL` não configurada ou incorreta.

**Solução:**
1. Verifique a string de conexão
2. Certifique-se que o banco MySQL está acessível
3. Teste a conexão

---
### Erro: "vite: not found" ou "esbuild: not found" no log do build

**Causa:** O Render executou o comando de build (`pnpm build` ou `npm run build`) sem antes instalar as dependências do projeto (`pnpm install`).

**Solução:**
1. No painel do seu serviço no Render, vá para a aba **Settings**.
2. Encontre a seção **Build & Deploy**.
3. Altere o campo **Build Command** para: `pnpm install && pnpm build`
4. Salve as alterações e faça um novo deploy manual.

## Build Command

```bash
pnpm install && pnpm build
```

## Start Command

```bash
pnpm start
```

postgresql://leilaosp_user:ZBI9see0qaBUUuSFJJwrkzrCXuAwUpsi@dpg-d5hg446mcj7s73b0oou0-a.oregon-postgres.render.com/leilaosp
---

## Checklist de Deploy

- [ ] Variáveis de ambiente configuradas
- [ ] Banco de dados MySQL criado
- [ ] DATABASE_URL configurada
- [ ] VITE_APP_ID configurada
- [ ] VITE_OAUTH_PORTAL_URL configurada
- [ ] Build executado com sucesso
- [ ] Pelo menos um usuário admin configurado
- [ ] Testado acesso ao painel admin

---

## Suporte

Se tiver problemas, verifique:
1. Logs do Render (aba "Logs")
2. Console do navegador (F12)
3. Variáveis de ambiente configuradas corretamente

---

## Configuração do Git

Configure seu nome e email para commits:

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
```

---

## Configuração Adicional para Vite

Se você estiver usando o Vite como ferramenta de build, adicione a seguinte configuração:

```javascript
// vite.config.js ou vite.config.ts
export default defineConfig({
  // ...outras configs...
  preview: {
    allowedHosts: ['copart.website'],
    // ...outras configs...
  }
});
```
