import { useState, useEffect } from 'react';
import veiculosData from '@/data/veiculos.json';
import leiloesData from '@/data/leiloes.json';
import sistemaData from '@/data/sistema.json';

export interface Veiculo {
  id: number;
  lote: string;
  ano: number;
  marca: string;
  modelo: string;
  descricao: string;
  lanceAtual: number;
  moeda: string;
  patio: string;
  tipo: string;
  imagem: string;
  status: string;
  destaque?: boolean;
  valorFipe?: number;
  valorIncremento?: number;
}

export interface Leilao {
  id: number;
  titulo: string;
  data: string;
  horario: string;
  local: string;
  tipo: string;
  status: string;
  totalVeiculos: number;
  descricao: string;
  categorias: string[];
  veiculosDestaque?: number[];
}

export interface Sistema {
  estatisticas: {
    totalVeiculos: number;
    leiloesMensais: number;
    veiculosDisponiveis: number;
    categorias: string[];
  };
  vendaDireta: {
    titulo: string;
    caracteristicas: string[];
    vantagens: string[];
  };
  leilao: {
    titulo: string;
    caracteristicas: string[];
    vantagens: string[];
  };
  venderComCopart: {
    titulo: string;
    caracteristicas: string[];
    descricao: string;
  };
  patios: Array<{
    id: number;
    nome: string;
    endereco: string;
    telefone: string;
    email: string;
  }>;
}

export function useVeiculos() {
  const [veiculos, setVeiculos] = useState<Veiculo[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setVeiculos(veiculosData as Veiculo[]);
    setLoading(false);
  }, []);

  return { veiculos, loading };
}

export function useLeiloes() {
  const [leiloes, setLeiloes] = useState<Leilao[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLeiloes(leiloesData as Leilao[]);
    setLoading(false);
  }, []);

  return { leiloes, loading };
}

export function useSistema() {
  const [sistema, setSistema] = useState<Sistema | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setSistema(sistemaData as Sistema);
    setLoading(false);
  }, []);

  return { sistema, loading };
}

export function useVeiculoById(id: number) {
  const { veiculos, loading } = useVeiculos();
  const veiculo = veiculos.find(v => v.id === id);
  
  return { veiculo, loading };
}

export function useLeilaoById(id: number) {
  const { leiloes, loading } = useLeiloes();
  const leilao = leiloes.find(l => l.id === id);
  
  return { leilao, loading };
}
