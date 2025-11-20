# Dados Extraídos do Site Copart

Este documento descreve os dados extraídos do site oficial da Copart (https://www.copart.com.br/) e como eles foram estruturados no projeto.

## Estrutura de Dados

### 1. Veículos (`client/src/data/veiculos.json`)

Arquivo JSON contendo informações detalhadas dos veículos disponíveis para leilão e venda direta.

**Campos:**
- `id`: Identificador único do veículo
- `lote`: Número do lote no leilão
- `ano`: Ano de fabricação do veículo
- `marca`: Marca do veículo (ex: VOLKSWAGEN, JEEP, FERRARI)
- `modelo`: Modelo do veículo
- `descricao`: Descrição completa do veículo
- `lanceAtual`: Valor atual do lance em reais
- `moeda`: Moeda utilizada (BRL)
- `patio`: Localização do pátio onde o veículo está
- `tipo`: Tipo de venda (leilao ou venda_direta)
- `imagem`: Caminho para a imagem do veículo
- `status`: Status do veículo (ativo, vendido, etc.)
- `destaque`: (opcional) Indica se o veículo é destaque

**Exemplo de veículo:**
```json
{
  "id": 1,
  "lote": "1020384",
  "ano": 2016,
  "marca": "VOLKSWAGEN",
  "modelo": "AMAROK",
  "descricao": "2016 VOLKSWAGEN AMAROK",
  "lanceAtual": 40000,
  "moeda": "BRL",
  "patio": "Goiânia - GO",
  "tipo": "leilao",
  "imagem": "/images/veiculos/amarok.jpg",
  "status": "ativo"
}
```

### 2. Leilões (`client/src/data/leiloes.json`)

Arquivo JSON contendo informações sobre os leilões programados e ativos.

**Campos:**
- `id`: Identificador único do leilão
- `titulo`: Título do leilão
- `data`: Data do leilão (formato: YYYY-MM-DD)
- `horario`: Horário de início (formato: HH:MM)
- `local`: Localização do leilão
- `tipo`: Tipo de leilão (Presencial, Online, Presencial e Online)
- `status`: Status do leilão (programado, ativo, encerrado)
- `totalVeiculos`: Quantidade total de veículos no leilão
- `descricao`: Descrição do leilão
- `categorias`: Array de categorias de veículos disponíveis
- `veiculosDestaque`: (opcional) Array de IDs de veículos em destaque

**Exemplo de leilão:**
```json
{
  "id": 1,
  "titulo": "Leilão Goiânia - GO",
  "data": "2025-11-25",
  "horario": "10:00",
  "local": "Goiânia - GO",
  "tipo": "Presencial e Online",
  "status": "programado",
  "totalVeiculos": 150,
  "descricao": "Leilão de veículos de bancos, seguradoras e consórcios",
  "categorias": ["Automóveis", "Caminhões", "Motocicletas"],
  "veiculosDestaque": [1, 2, 4]
}
```

### 3. Sistema (`client/src/data/sistema.json`)

Arquivo JSON contendo informações gerais do sistema, estatísticas e configurações.

**Estrutura:**

#### Estatísticas
```json
"estatisticas": {
  "totalVeiculos": 12496,
  "leiloesMensais": 70,
  "veiculosDisponiveis": 6000,
  "categorias": ["Automóveis", "Caminhões", "Motocicletas", "SUVs", "Vans", "Ônibus"]
}
```

#### Venda Direta
```json
"vendaDireta": {
  "titulo": "Venda Direta",
  "caracteristicas": [
    "Disponível 24h horas por dia",
    "Veículos com laudo",
    "Negociação intermediada",
    "Diversas opções com garantia"
  ],
  "vantagens": [
    "Selecione o veículo desejado",
    "Compre Agora sem leilão",
    "Veículos sem registro de sinistro"
  ]
}
```

#### Leilão
```json
"leilao": {
  "titulo": "Leilão",
  "caracteristicas": [
    "+ de 70 leilões mensais",
    "De Bancos, Seguradoras, e mais",
    "Faça seus lances online",
    "Veículos com procedência"
  ],
  "vantagens": [
    "Escolha o seu veículo em nosso catálogo",
    "Lance preliminar ou lances firmes",
    "Veículos com documentação regular"
  ]
}
```

#### Pátios
```json
"patios": [
  {
    "id": 1,
    "nome": "Goiânia - GO",
    "endereco": "Goiânia, Goiás",
    "telefone": "",
    "email": ""
  }
]
```

## Como Utilizar os Dados

### Hooks Personalizados

Foram criados hooks React personalizados para facilitar o acesso aos dados:

**Arquivo:** `client/src/hooks/useCopartData.ts`

#### Hooks disponíveis:

1. **useVeiculos()** - Retorna todos os veículos
```typescript
const { veiculos, loading } = useVeiculos();
```

2. **useLeiloes()** - Retorna todos os leilões
```typescript
const { leiloes, loading } = useLeiloes();
```

3. **useSistema()** - Retorna informações do sistema
```typescript
const { sistema, loading } = useSistema();
```

4. **useVeiculoById(id)** - Retorna um veículo específico
```typescript
const { veiculo, loading } = useVeiculoById(1);
```

5. **useLeilaoById(id)** - Retorna um leilão específico
```typescript
const { leilao, loading } = useLeilaoById(1);
```

### Componentes

#### VehicleCard

Componente para exibir um card de veículo com todas as informações formatadas.

**Arquivo:** `client/src/components/VehicleCard.tsx`

**Uso:**
```tsx
import VehicleCard from '@/components/VehicleCard';
import { useVeiculos } from '@/hooks/useCopartData';

function MeuComponente() {
  const { veiculos, loading } = useVeiculos();
  
  return (
    <div className="grid grid-cols-4 gap-4">
      {veiculos.map(veiculo => (
        <VehicleCard key={veiculo.id} veiculo={veiculo} />
      ))}
    </div>
  );
}
```

## Dados Extraídos do Site Original

Os seguintes dados foram extraídos diretamente do site da Copart:

### Veículos em Destaque (Página Inicial)

1. **2016 VOLKSWAGEN AMAROK**
   - Lote: 1020384
   - Lance: R$ 40.000
   - Pátio: Goiânia - GO

2. **2018 JEEP COMPASS**
   - Lote: 1038703
   - Lance: R$ 44.300
   - Pátio: Goiânia - GO

3. **2023 FERRARI SF90 STRADALE 4.0 V8 BITURBO HIBRID**
   - Lote: 1036018
   - Lance: R$ 0
   - Pátio: Leilão Pátio Porto Seguro - SP

4. **2016 CHEVROLET S10 CABINE DUPLA**
   - Lote: 1042892
   - Lance: R$ 44.750
   - Pátio: Goiânia - GO

### Estatísticas Gerais

- **Total de veículos disponíveis:** 12.496
- **Leilões mensais:** +70
- **Veículos disponíveis para lance:** 6.000+

## Próximos Passos

Para expandir os dados, você pode:

1. Adicionar mais veículos ao arquivo `veiculos.json`
2. Criar novos leilões em `leiloes.json`
3. Atualizar as estatísticas em `sistema.json`
4. Adicionar imagens reais dos veículos na pasta `/public/images/veiculos/`
5. Integrar com uma API backend para dados dinâmicos

## Observações

- Os dados são estáticos e armazenados em arquivos JSON
- Para produção, recomenda-se integrar com uma API backend
- As imagens dos veículos precisam ser adicionadas manualmente
- Os valores e datas são exemplos baseados nos dados extraídos
