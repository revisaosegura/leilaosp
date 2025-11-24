import fs from 'node:fs/promises';
import path from 'node:path';
import process from 'node:process';
import axios from 'axios';

type RawVehicle = Record<string, unknown> & {
  lotNumber?: string | number;
  make?: string;
  model?: string;
  year?: string | number;
  currentBid?: number;
  currency?: string;
  images?: Array<{ url?: string }> | Array<string>;
  image?: string;
  location?: string;
  description?: string;
  lane?: string;
  item?: string | number;
};

type ScrapedVehicle = {
  lotNumber: string;
  title: string;
  make?: string;
  model?: string;
  year?: number;
  currentBid?: number;
  currency?: string;
  location?: string;
  lane?: string;
  item?: string;
  images: string[];
};

type ScrapeResult = {
  url: string;
  capturedAt: string;
  vehicles: ScrapedVehicle[];
};

function getTargetUrl(): string {
  const [, , urlArg] = process.argv;
  return (
    urlArg ??
    'https://www.copart.com.br/search/leil%C3%A3o/?displayStr=Leil%C3%A3o&from=%2FvehicleFinder'
  );
}

async function fetchListingHtml(url: string): Promise<string> {
  const response = await axios.get(url, {
    responseType: 'text',
    headers: {
      'User-Agent':
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0 Safari/537.36',
      Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
      'Accept-Language': 'pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7',
      // Alguns provedores retornam 403 sem o cookie de sessão; permita o usuário
      // informar via variável de ambiente.
      ...(process.env.COPART_COOKIE ? { Cookie: process.env.COPART_COOKIE } : {}),
    },
    // O site usa TLS SNI; desabilitar proxy evita alguns 403 de rede corporativa.
    proxy: false,
    validateStatus: (status) => status >= 200 && status < 400,
  });

  return response.data;
}

function extractNextData(html: string): unknown | null {
  const match = html.match(/<script[^>]*id="__NEXT_DATA__"[^>]*>([\s\S]*?)<\/script>/);
  if (!match) return null;

  try {
    return JSON.parse(match[1]);
  } catch (error) {
    console.error('Falha ao converter o payload do __NEXT_DATA__:', error);
    return null;
  }
}

function flattenResults(data: unknown): RawVehicle[] {
  const results: RawVehicle[] = [];

  function visit(node: unknown) {
    if (!node) return;

    if (Array.isArray(node)) {
      for (const entry of node) visit(entry);
      return;
    }

    if (typeof node === 'object') {
      const value = node as Record<string, unknown>;
      const keys = Object.keys(value);
      const looksLikeVehicle = ['lotNumber', 'make', 'model', 'year'].some((key) => key in value);

      if (looksLikeVehicle && keys.length > 1) {
        results.push(value as RawVehicle);
      }

      for (const key of keys) visit(value[key]);
    }
  }

  visit(data);
  return results;
}

function normalizeVehicle(entry: RawVehicle): ScrapedVehicle {
  const images: string[] = [];

  if (Array.isArray(entry.images)) {
    for (const item of entry.images) {
      if (typeof item === 'string') images.push(item);
      else if (item && typeof item === 'object' && 'url' in item && typeof item.url === 'string') {
        images.push(item.url);
      }
    }
  }

  if (typeof entry.image === 'string') {
    images.push(entry.image);
  }

  return {
    lotNumber: String(entry.lotNumber ?? entry.item ?? 'sem-lote'),
    title: entry.description
      ? String(entry.description)
      : [entry.year, entry.make, entry.model].filter(Boolean).join(' ').trim() || 'Veículo',
    make: entry.make,
    model: entry.model,
    year: typeof entry.year === 'string' || typeof entry.year === 'number' ? Number(entry.year) : undefined,
    currentBid: typeof entry.currentBid === 'number' ? entry.currentBid : undefined,
    currency: typeof entry.currency === 'string' ? entry.currency : undefined,
    location: typeof entry.location === 'string' ? entry.location : undefined,
    lane: typeof entry.lane === 'string' ? entry.lane : undefined,
    item: typeof entry.item === 'string' || typeof entry.item === 'number' ? String(entry.item) : undefined,
    images,
  };
}

async function writePreview(result: ScrapeResult) {
  const outputDir = path.resolve('scripts', 'output');
  await fs.mkdir(outputDir, { recursive: true });
  const filePath = path.join(outputDir, 'copart-preview.json');
  await fs.writeFile(filePath, JSON.stringify(result, null, 2), 'utf-8');
  console.log(`Prévia salva em: ${filePath}`);
}

async function main() {
  const url = getTargetUrl();
  console.log(`Iniciando scraping de ${url}`);

  const htmlFile = process.env.COPART_HTML_FILE;
  const html = htmlFile ? await fs.readFile(htmlFile, 'utf-8') : await fetchListingHtml(url);
  const nextData = extractNextData(html);

  if (!nextData) {
    throw new Error('Não foi possível localizar o payload __NEXT_DATA__ na página.');
  }

  const rawVehicles = flattenResults(nextData);
  if (!rawVehicles.length) {
    throw new Error('Nenhum veículo foi identificado no payload processado.');
  }

  const vehicles = rawVehicles.map(normalizeVehicle);
  const result: ScrapeResult = {
    url,
    capturedAt: new Date().toISOString(),
    vehicles,
  };

  await writePreview(result);
}

main().catch((error) => {
  console.error('Erro ao executar o scraper:', error);
  process.exitCode = 1;
});
