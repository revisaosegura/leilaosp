import React, { useEffect, useMemo, useState } from "react";
import { useAuth } from "@/_core/hooks/useAuth";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { Badge } from "@/components/ui/badge";
import { trpc } from "@/lib/trpc";
import type { inferProcedureOutput } from "@trpc/server";
import type { AppRouter } from "@server/trpc/router";
import { ArrowDown, ArrowUp, Loader2, Plus, Edit2, Trash2, X, Eye, Star } from "lucide-react";
import { Link, useLocation, useRoute } from "wouter";
import { toast } from "sonner";

type Vehicle = inferProcedureOutput<AppRouter["vehicles"]["list"]>[number];

const MAX_UPLOAD_FILES = 30;

type VehicleImageItem = {
  id: string;
  type: "existing" | "new";
  url: string;
  file?: File;
};

type VehicleFormValues = {
  lotNumber: string;
  year: string;
  make: string;
  model: string;
  description: string;
  documentStatus: string;
  categoryDetail: string;
  condition: string;
  runningCondition: string;
  montaType: string;
  chassisType: string;
  comitente: string;
  patio: string;
  imageUrl: string;
  images: string[];
  currentBid: string;
  buyNowPrice: string;
  fipeValue: string;
  bidIncrement: string;
  locationId: number;
  categoryId: number;
  saleType: "auction" | "direct";
  status: "active" | "pending" | "sold";
  hasWarranty: boolean;
  hasReport: boolean;
};

const DOCUMENT_STATUS_OPTIONS = ["Aguardando classificação", "Recuperação", "Irrecuperável", "Normal"];
const CATEGORY_DETAIL_OPTIONS = [
  "Automóveis",
  "Motos",
  "Caminhões e Rebocadores",
  "SUV Pequenos",
  "SUV Grandes",
  "Utilitários Grandes",
  "Utilitários Pequenos",
  "Implementos Rodoviários",
  "Ônibus e Microônibus",
  "Outros",
  "Picapes Grandes",
  "Picapes Pequenas",
  "Tratores",
];
const CONDITION_OPTIONS = [
  "Colisão",
  "Queimado",
  "Avarias em Transporte",
  "Consórcio",
  "enchente",
  "Financiamento",
  "Frota",
  "Inteiro",
  "Roubo/Furto",
  "Sinistrado",
  "Uso Normal",
];
const RUNNING_CONDITION_OPTIONS = ["Motor dá partida e engrena", "Desconhecido", "Motor dá partida"];
const MONTA_TYPE_OPTIONS = ["Pequena Monta", "Grande Monta", "Média Monta", "Aguardando Classificação", "Não aplicável"];
const CHASSIS_TYPE_OPTIONS = ["Normal", "Recortado", "Remarcado", "Avariado", "Aguardando Classificação"];
const COMITENTE_OPTIONS = [
  "AZUL COMPANHIA DE SEGUROS GERAIS",
  "PORTO SEGURO CIA DE SEGUROS GERAIS",
  "PORTO SEGURO ADMINISTRAÇÃO DE CONSÓRCIOS S/C LTDA",
  "LOCALIZA FLEET SA",
  "LOCALIZA RENT A CAR",
  "COMPANHIA DE LOCACAO DAS AMERICAS",
  "PREVISUL",
  "SUHAI SEGURADORA",
  "YOUSE CAIXA SEGUROS",
  "TOKIO MARINE SEGURADORA S A  VEICULOS TMS NOVO",
  "PARTICULAR/EMPRESA",
  "HDI SEGUROS SA  NOVO",
  "YELUM SEGUROS S.A",
  "ALD AUTOMOTIVE S.A.",
  "BEM EMERGENCIAS MEDICAS LTDA",
  "CHUBB SEGUROS BRASIL SA",
  "SEGUROS SURA S/A (RSA SURA)",
  "LTI SEGUROS S/A",
  "ALFA SEGURADORA S A",
  "PORTO SEGURO CIA DE SEGUROS GERAIS - VL JAGUARA",
  "ITAÚ SEGUROS DE AUTO E RESIDÊNCIA - VEÍCULOS",
  "PORTOSEG S/A - CREDITO FINANCIAMENTO E INVESTIMENTO",
  "AZUL COMPANHIA DE SEGUROS GERAIS",
  "PORTOSEG S/A - CREDITO FINANCIAMENTO E INVESTIMENTO",
  "LOOVI TECHNOLOGY",
  "outros",
];
const PATIO_OPTIONS = [
  "ITAQUAQUECETUBA - SP",
  "Leilão Pátio Porto Seguro - SP",
  "Curitiba - PR",
  "Eusébio - CE",
  "Goiânia - GO",
  "Fortaleza - CE",
  "Vitória de Santo Antão - PE",
  "Betim - MG",
  "Osasco - SP",
  "Não Preenchido",
];
const STATUS_OPTIONS = [
  { value: "active", label: "Ativo" },
  { value: "pending", label: "Pendente" },
  { value: "sold", label: "Vendido" },
];

// MANTENHA todo o resto do código e substitua APENAS o EMPTY_FORM:

const EMPTY_FORM: VehicleFormValues = {
  lotNumber: "",
  year: new Date().getFullYear().toString(),
  make: "",
  model: "",
  description: "",
  documentStatus: "Aguardando classificação",
  categoryDetail: "Automóveis",
  condition: "Colisão",
  runningCondition: "Motor dá partida e engrena",
  montaType: "Pequena Monta",
  chassisType: "Normal",
  comitente: "AZUL COMPANHIA DE SEGUROS GERAIS",
  patio: "ITAQUAQUECETUBA - SP",
  imageUrl: "",
  images: [],
  currentBid: "",  // ← DEIXE VAZIO
  buyNowPrice: "", // ← DEIXE VAZIO
  fipeValue: "",   // ← DEIXE VAZIO
  bidIncrement: "", // ← DEIXE VAZIO
  locationId: 1,
  categoryId: 1,
  saleType: "auction",
  status: "active",
  hasWarranty: false,
  hasReport: false,
};

export default function AdminVehicles() {
  const { user } = useAuth({ redirectOnUnauthenticated: true });
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [editingVehicle, setEditingVehicle] = useState<any>(null);
  const [imageItems, setImageItems] = useState<VehicleImageItem[]>([]);
  const [uploading, setUploading] = useState(false);

const { data: vehicles, isLoading, refetch } = trpc.vehicles.list.useQuery({ limit: 500 });

// DEBUG COMPLETO
useEffect(() => {
  console.log('🚗 VEHICLES DATA:', vehicles);
  console.log('🔍 VEHICLES COUNT:', vehicles?.length);
  console.log('📱 IS LOADING:', isLoading);
}, [vehicles, isLoading]);

// Adicione um botão de refresh temporário
// Adicione um botão de refresh temporário
/* 
<Button onClick={() => refetch()} variant="outline" className="mt-4">
  <RefreshCw size={16} className="mr-2" />
  Recarregar Veículos
</Button> 
*/
const [searchTerm, setSearchTerm] = useState("");
  const statusOptions = useMemo(() => STATUS_OPTIONS, []);

  const [, setLocation] = useLocation();
  const [matchCreate] = useRoute("/admin/vehicles/new");
  const [matchEdit, editParams] = useRoute("/admin/vehicles/edit/:id");
  const [previewVehicle, setPreviewVehicle] = useState<Vehicle | null>(null);

  const createVehicle = trpc.vehicles.create.useMutation({
    onSuccess: () => {
      toast.success("Veículo cadastrado com sucesso!");
      setIsCreateOpen(false);
      if (matchCreate) {
        setLocation("/admin/vehicles");
      }
      refetch();
      resetForm();
    },
    onError: (error: unknown) => {
      let message = "Ocorreu um erro desconhecido.";
      if (error instanceof Error) {
        message = error.message;
      }
      toast.error("Erro ao cadastrar veículo: " + message);
    },
  });
  const updateVehicle = trpc.vehicles.update.useMutation({
    onSuccess: () => {
      toast.success("Veículo atualizado com sucesso!");
      setIsEditOpen(false);
      if (matchEdit) {
        setLocation("/admin/vehicles");
      }
      refetch();
      resetForm();
    },
    onError: (error: unknown) => {
      let message = "Ocorreu um erro desconhecido.";
      if (error instanceof Error) {
        message = error.message;
      }
      toast.error("Erro ao atualizar veículo: " + message);
    },
  });

  const deleteVehicle = trpc.vehicles.delete.useMutation({
    onSuccess: () => {
      toast.success("Veículo deletado com sucesso!");
      refetch();
    },
    onError: (error: unknown) => {
      let message = "Ocorreu um erro desconhecido.";
      if (error instanceof Error) {
        message = error.message;
      }
      toast.error("Erro ao deletar veículo: " + message);
    },
  });

  const [formData, setFormData] = useState<VehicleFormValues>({ ...EMPTY_FORM });

  const resetForm = () => {
    setFormData({ ...EMPTY_FORM });
    setImageItems([]);
  };

  useEffect(() => {
    setFormData(prev => ({
      ...prev,
      images: imageItems.filter(item => item.type === "existing").map(item => item.url),
    }));
  }, [imageItems]);

  const sanitizeCurrencyInput = (value: string) => value.replace(/[^0-9.,]/g, "");

  const parseCurrencyToNumber = (value: string): number => {
  if (!value || value.trim() === "") return 0;
  
  const cleaned = value.replace(/[^\d,]/g, "").replace(",", ".");
  
  const parsed = parseFloat(cleaned);
  return isNaN(parsed) ? 0 : parsed;
};

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files || []);

    if (files.length === 0) return;

    setImageItems(prev => {
      const availableSlots = MAX_UPLOAD_FILES - prev.length;

      if (availableSlots <= 0) {
        toast.error(`Você pode enviar no máximo ${MAX_UPLOAD_FILES} imagens.`);
        return prev;
      }

      const filesToAdd = files.slice(0, availableSlots);

      if (filesToAdd.length < files.length) {
        toast.error(
          `Apenas ${MAX_UPLOAD_FILES} imagens podem ser adicionadas. ${files.length - filesToAdd.length} não foram incluídas.`,
        );
      }

      const newItems = filesToAdd.map(file => ({
        id: `${Date.now()}-${Math.random()}`,
        type: "new" as const,
        url: URL.createObjectURL(file),
        file,
      }));

      return [...prev, ...newItems];
    });
  };

  const handleRemoveImage = (id: string) => {
    setImageItems(prev => prev.filter(item => item.id !== id));
  };

  const moveImage = (index: number, direction: "up" | "down") => {
    setImageItems(prev => {
      const targetIndex = direction === "up" ? index - 1 : index + 1;

      if (targetIndex < 0 || targetIndex >= prev.length) return prev;

      const updated = [...prev];
      [updated[index], updated[targetIndex]] = [updated[targetIndex], updated[index]];
      return updated;
    });
  };

  const setImageAsCover = (index: number) => {
    setImageItems(prev => {
      if (index === 0) return prev;

      const selected = prev[index];
      const remaining = prev.filter((_, i) => i !== index);
      return [selected, ...remaining];
    });
  };

  const buildPayload = (images: string[]) => {
  // CORREÇÃO DO ANO - garante que seja número inteiro
  const yearValue = parseInt(formData.year, 10);
  const currentYear = new Date().getFullYear();
  const finalYear = (!isNaN(yearValue) && yearValue > 1900 && yearValue <= currentYear + 1) 
    ? yearValue 
    : currentYear;

  console.log('🔧 DEBUG - Year conversion:', {
    input: formData.year,
    parsed: yearValue,
});

  const payload = {
    ...formData,
    lotNumber: formData.lotNumber.trim(),
    year: finalYear, // ← CORRIGIDO
    make: formData.make.trim(),
    model: formData.model.trim(),
    
    // Campos de status/documento
    document_status: formData.documentStatus,
    category_detail: formData.categoryDetail,
    condition: formData.condition,
    running_condition: formData.runningCondition,
    monta_type: formData.montaType,
    chassis_type: formData.chassisType,
    comitente: formData.comitente,
    patio: formData.patio,
    
    // Imagens
    image_url: images[0] || formData.imageUrl || "",
    images: images,
    
    // Campos numéricos (COM VALORES PADRÃO)
    current_bid: parseCurrencyToNumber(formData.currentBid) || 50000,
    buy_now_price: parseCurrencyToNumber(formData.buyNowPrice) || 0,
    fipe_value: parseCurrencyToNumber(formData.fipeValue) || 0,
    bid_increment: parseCurrencyToNumber(formData.bidIncrement) || 500,
    
    // IDs e status
    location_id: formData.locationId || 1,
    category_id: formData.categoryId || 1,
    sale_type: formData.saleType,
  };

  return payload;
};
  const validateRequiredFields = () => {
  if (!formData.lotNumber.trim()) {
    toast.error("Informe o número do lote");
    return false;
  }

  if (!formData.make.trim()) {
    toast.error("Informe a marca do veículo");
    return false;
  }

  if (!formData.model.trim()) {
    toast.error("Informe o modelo do veículo");
    return false;
  }

  // Valida campos numéricos
  if (parseCurrencyToNumber(formData.currentBid) < 0) {
    toast.error("Lance atual não pode ser negativo");
    return false;
  }

  if (parseCurrencyToNumber(formData.bidIncrement) <= 0) {
    toast.error("Incremento de lance deve ser maior que zero");
    return false;
  }

  return true;
};

  const uploadImages = async (): Promise<string[]> => {
    const existingImages = imageItems.filter(item => item.type === "existing").map(item => item.url);
    const newFiles = imageItems.filter(item => item.type === "new" && item.file).map(item => item.file as File);

    if (newFiles.length === 0) return existingImages;

    setUploading(true);
    try {
      const formDataUpload = new FormData();
      newFiles.forEach(file => formDataUpload.append("images", file));

      console.log('📤 Uploading images:', newFiles.length, 'files');

      const response = await fetch("/api/upload/multiple", {
        method: "POST",
        body: formDataUpload,
      });

      if (!response.ok) {
        const contentType = response.headers.get("content-type") || "";
        let serverMessage = "";

        if (contentType.includes("application/json")) {
          const errorBody = await response.json().catch(() => ({}));
          serverMessage = (errorBody as { error?: string })?.error || "";
        }

        if (!serverMessage) {
          serverMessage = await response.text().catch(() => "");
        }

        const message = serverMessage?.trim() || "Erro desconhecido ao fazer upload";

        console.error('❌ Upload failed:', response.status, message);
        throw new Error(`Erro no upload: ${response.status} ${message}`.trim());
      }

      const data = await response.json();
      const uploadedUrls = (data.imageUrls as string[]) || [];

      if (uploadedUrls.length !== newFiles.length) {
        console.warn('⚠️ Upload retornou quantidade inesperada de imagens', {
          enviados: newFiles.length,
          recebidos: uploadedUrls.length,
        });
      }

      let uploadIndex = 0;
      const finalImages = imageItems.reduce<string[]>((result, item) => {
        if (item.type === "existing") {
          result.push(item.url);
          return result;
        }

        const uploadedUrl = uploadedUrls[uploadIndex];
        if (uploadedUrl) {
          result.push(uploadedUrl);
        }
        uploadIndex += 1;
        return result;
      }, []);

      return finalImages;
    } catch (error) {
      console.error('❌ Upload error:', error);
      let message = "Ocorreu um erro desconhecido.";
      if (error instanceof Error) {
        message = error.message;
      }
      toast.error("Erro ao fazer upload das imagens: " + message);
      throw error;
    } finally {
      setUploading(false);
    }
  };

const submitVehicle = async (mode: "create" | "update") => {
  let images: string[] = [];
  
  try {
    // Tenta fazer upload das imagens
    images = await uploadImages();
  } catch (uploadError) {
    // Se o upload falhar, PERGUNTA se quer continuar sem imagens
    const shouldContinue = confirm(
      "Falha no upload das imagens. Deseja continuar o cadastro sem as imagens?"
    );
    
    if (!shouldContinue) {
      throw uploadError; // Cancela o cadastro
    }
    
    // Continua com as imagens existentes (se houver)
    images = imageItems.filter(item => item.type === "existing").map(item => item.url);
  }

  const payload = buildPayload(images);

  console.log('🚀 FINAL PAYLOAD:', payload);

  if (mode === "create") {
    createVehicle.mutate(payload);
    return;
  }

  if (!editingVehicle?.id) {
    toast.error("Veículo para edição não encontrado");
    return;
  }

  updateVehicle.mutate({
    id: editingVehicle.id,
    ...payload,
  });
};

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validateRequiredFields()) return;
    try {
      await submitVehicle("create");
    } catch {
      // erros tratados no próprio fluxo de mutate/upload
    }
  };

  const handleUpdate = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validateRequiredFields()) return;
    try {
      await submitVehicle("update");
    } catch {
      // erros tratados no próprio fluxo de mutate/upload
    }
  };

  const handleEdit = (vehicle: Vehicle) => {
    setEditingVehicle(vehicle);
    const existingImages = (vehicle.images && vehicle.images.length > 0)
      ? vehicle.images
      : vehicle.imageUrl
        ? [vehicle.imageUrl]
        : [];

    setFormData({
      lotNumber: vehicle.lotNumber,
      year: vehicle.year?.toString() || new Date().getFullYear().toString(),
      make: vehicle.make,
      model: vehicle.model,
      description: vehicle.description || "",
      documentStatus: vehicle.documentStatus || "Aguardando classificação",
      categoryDetail: vehicle.categoryDetail || "Automóveis",
      condition: vehicle.condition || "Colisão",
      runningCondition: vehicle.runningCondition || "Motor dá partida e engrena",
      montaType: vehicle.montaType || "Pequena Monta",
      chassisType: vehicle.chassisType || "Normal",
      comitente: vehicle.comitente || "AZUL COMPANHIA DE SEGUROS GERAIS",
      patio: vehicle.patio || "ITAQUAQUECETUBA - SP",
      imageUrl: vehicle.imageUrl || "",
      images: vehicle.images || (vehicle.imageUrl ? [vehicle.imageUrl] : []),
      currentBid: vehicle.currentBid?.toString() || "",
      buyNowPrice: vehicle.buyNowPrice?.toString() || "",
      fipeValue: vehicle.fipeValue?.toString() || "",
      bidIncrement: vehicle.bidIncrement?.toString() || "",
      locationId: vehicle.locationId,
      categoryId: vehicle.categoryId,
      saleType: vehicle.saleType,
      status: vehicle.status ?? "active",
      hasWarranty: vehicle.hasWarranty,
      hasReport: vehicle.hasReport,
    });
    setImageItems(existingImages.map((url, index) => ({
      id: `existing-${vehicle.id}-${index}`,
      type: "existing",
      url,
    })));
    setIsEditOpen(true);
  };

  useEffect(() => {
    if (matchCreate) {
      setIsCreateOpen(true);
    }
  }, [matchCreate]);

  useEffect(() => {
    if (matchEdit && vehicles) {
      const vehicleId = Number(editParams?.id);
      const vehicle = vehicles.find((v: Vehicle) => v.id === vehicleId);

      if (vehicle) {
        handleEdit(vehicle);
      } else {
        toast.error("Veículo não encontrado");
        setLocation("/admin/vehicles");
      }
    }
  }, [matchEdit, editParams?.id, vehicles]);

  const handleDelete = (id: number) => {
    if (confirm("Tem certeza que deseja deletar este veículo?")) {
      deleteVehicle.mutate({ id });
    }
  };

  const closePreview = () => setPreviewVehicle(null);

  const filteredVehicles = (vehicles || []).filter((vehicle: Vehicle) => {
    const query = searchTerm.toLowerCase();
    return (
      vehicle.lotNumber?.toLowerCase().includes(query) ||
      vehicle.make?.toLowerCase().includes(query) ||
      vehicle.model?.toLowerCase().includes(query) ||
      `${vehicle.year}`.includes(query)
    );
  });

  if (user?.role !== "admin") {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-4">Acesso Negado</h1>
          <Link href="/">
            <Button>Voltar para Início</Button>
          </Link>
        </div>
      </div>
    );
  }

  const VehicleForm = ({ onSubmit, isEdit = false }: { onSubmit: (e: React.FormEvent) => void; isEdit?: boolean }) => (
    <form onSubmit={onSubmit} className="space-y-4">
      <div className="grid grid-cols-2 gap-4">
        <div>
          <Label htmlFor="lotNumber">Número do Lote *</Label>
          <Input
            id="lotNumber"
            value={formData.lotNumber}
            onChange={(e) => setFormData({ ...formData, lotNumber: e.target.value })}
            required
          />
        </div>
        <div>
          <Label htmlFor="year">Ano *</Label>
          <Input
            id="year"
            type="number"
            value={formData.year}
            onChange={(e) => setFormData({ ...formData, year: e.target.value })}
            required
          />
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <Label htmlFor="make">Marca *</Label>
          <Input
            id="make"
            value={formData.make}
            onChange={(e) => setFormData({ ...formData, make: e.target.value })}
            required
          />
        </div>
        <div>
          <Label htmlFor="model">Modelo *</Label>
          <Input
            id="model"
            value={formData.model}
            onChange={(e) => setFormData({ ...formData, model: e.target.value })}
            required
          />
        </div>
      </div>

      <div>
        <Label htmlFor="description">Descrição</Label>
        <Textarea
          id="description"
          value={formData.description}
          onChange={(e) => setFormData({ ...formData, description: e.target.value })}
          rows={6}
        />
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <Label>Documento</Label>
          <Select
            value={formData.documentStatus}
            onValueChange={(value) => setFormData({ ...formData, documentStatus: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Selecione o status do documento" />
            </SelectTrigger>
            <SelectContent>
              {DOCUMENT_STATUS_OPTIONS.map(option => (
                <SelectItem key={option} value={option}>
                  {option}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div>
          <Label>Categoria</Label>
          <Select
            value={formData.categoryDetail}
            onValueChange={(value) => setFormData({ ...formData, categoryDetail: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Selecione a categoria" />
            </SelectTrigger>
            <SelectContent>
              {CATEGORY_DETAIL_OPTIONS.map(option => (
                <SelectItem key={option} value={option}>
                  {option}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <Label>Condição</Label>
          <Select
            value={formData.condition}
            onValueChange={(value) => setFormData({ ...formData, condition: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Selecione a condição" />
            </SelectTrigger>
            <SelectContent>
              {CONDITION_OPTIONS.map(option => (
                <SelectItem key={option} value={option}>
                  {option}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div>
          <Label>Cond. de Funcionamento</Label>
          <Select
            value={formData.runningCondition}
            onValueChange={(value) => setFormData({ ...formData, runningCondition: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Selecione a condição" />
            </SelectTrigger>
            <SelectContent>
              {RUNNING_CONDITION_OPTIONS.map(option => (
                <SelectItem key={option} value={option}>
                  {option}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <Label>Tipo de Monta</Label>
          <Select
            value={formData.montaType}
            onValueChange={(value) => setFormData({ ...formData, montaType: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Selecione o tipo de monta" />
            </SelectTrigger>
            <SelectContent>
              {MONTA_TYPE_OPTIONS.map(option => (
                <SelectItem key={option} value={option}>
                  {option}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div>
          <Label>Tipo de Chassi</Label>
          <Select
            value={formData.chassisType}
            onValueChange={(value) => setFormData({ ...formData, chassisType: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Selecione o tipo de chassi" />
            </SelectTrigger>
            <SelectContent>
              {CHASSIS_TYPE_OPTIONS.map(option => (
                <SelectItem key={option} value={option}>
                  {option}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      <div className="grid grid-cols-1 gap-4">
        <div>
          <Label>Comitente</Label>
          <Select
            value={formData.comitente}
            onValueChange={(value) => setFormData({ ...formData, comitente: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Selecione o comitente" />
            </SelectTrigger>
            <SelectContent>
              {COMITENTE_OPTIONS.map(option => (
                <SelectItem key={option} value={option}>
                  {option}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div>
          <Label>Pátio do Veículo</Label>
          <Select
            value={formData.patio}
            onValueChange={(value) => setFormData({ ...formData, patio: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Selecione o pátio" />
            </SelectTrigger>
            <SelectContent>
              {PATIO_OPTIONS.map(option => (
                <SelectItem key={option} value={option}>
                  {option}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      <div>
        <Label htmlFor="images">Imagens do Veículo</Label>
        <Input
          id="images"
          type="file"
          accept="image/*"
          multiple
          onChange={handleImageChange}
        />

        {imageItems.length > 0 && (
          <div className="mt-3 grid grid-cols-2 md:grid-cols-3 gap-3">
            {imageItems.map((item, index) => (
              <div key={item.id} className="relative border rounded overflow-hidden group">
                <img src={item.url} alt={`Imagem ${index + 1}`} className="w-full h-32 object-cover" />

                {index === 0 && (
                  <span className="absolute left-2 top-2 bg-blue-600 text-white text-xs px-2 py-1 rounded-full shadow">
                    Capa
                  </span>
                )}

                <div className="absolute top-2 right-2 flex gap-1 opacity-100 md:opacity-0 md:group-hover:opacity-100 transition-opacity">
                  <Button
                    type="button"
                    variant="destructive"
                    size="icon"
                    className="h-8 w-8"
                    onClick={() => handleRemoveImage(item.id)}
                  >
                    <X className="h-4 w-4" />
                  </Button>
                </div>

                <div className="absolute inset-x-0 bottom-0 p-2 bg-gradient-to-t from-black/70 via-black/40 to-transparent">
                  <div className="flex items-center justify-between gap-2">
                    <div className="flex items-center gap-1">
                      <Button
                        type="button"
                        variant="secondary"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => moveImage(index, "up")}
                        disabled={index === 0}
                        title="Mover para cima"
                      >
                        <ArrowUp className="h-4 w-4" />
                      </Button>
                      <Button
                        type="button"
                        variant="secondary"
                        size="icon"
                        className="h-8 w-8"
                        onClick={() => moveImage(index, "down")}
                        disabled={index === imageItems.length - 1}
                        title="Mover para baixo"
                      >
                        <ArrowDown className="h-4 w-4" />
                      </Button>
                    </div>
                    <Button
                      type="button"
                      variant="secondary"
                      size="sm"
                      className="h-8"
                      onClick={() => setImageAsCover(index)}
                      disabled={index === 0}
                      title="Definir como capa"
                    >
                      <Star className="h-4 w-4 mr-1" />
                      Capa
                    </Button>
                  </div>
                  <p className="text-white text-xs mt-2">{item.type === "existing" ? "Imagem atual" : "Nova imagem"}</p>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <Label htmlFor="currentBid">Lance Atual (R$)</Label>
          <Input
            id="currentBid"
            type="text"
            inputMode="decimal"
            value={formData.currentBid}
            onChange={(e) => setFormData({ ...formData, currentBid: sanitizeCurrencyInput(e.target.value) })}
          />
        </div>
        <div>
          <Label htmlFor="buyNowPrice">Preço Compra Direta (R$)</Label>
          <Input
            id="buyNowPrice"
            type="text"
            inputMode="decimal"
            value={formData.buyNowPrice}
            onChange={(e) => setFormData({ ...formData, buyNowPrice: sanitizeCurrencyInput(e.target.value) })}
          />
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <Label htmlFor="fipeValue">Valor Tabela FIPE (R$)</Label>
          <Input
            id="fipeValue"
            type="text"
            inputMode="decimal"
            value={formData.fipeValue}
            onChange={(e) => setFormData({ ...formData, fipeValue: sanitizeCurrencyInput(e.target.value) })}
          />
        </div>
        <div>
          <Label htmlFor="bidIncrement">Incremento de Lance (R$)</Label>
          <Input
            id="bidIncrement"
            type="text"
            inputMode="decimal"
            value={formData.bidIncrement}
            onChange={(e) => setFormData({ ...formData, bidIncrement: sanitizeCurrencyInput(e.target.value) })}
          />
        </div>
      </div>

      <div>
        <Label htmlFor="saleType">Tipo de Venda *</Label>
        <Select
          value={formData.saleType}
          onValueChange={(value: "auction" | "direct") => setFormData({ ...formData, saleType: value })}
        >
          <SelectTrigger>
            <SelectValue />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="auction">Leilão</SelectItem>
            <SelectItem value="direct">Venda Direta</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <div>
        <Label htmlFor="status">Status *</Label>
        <Select
          value={formData.status}
          onValueChange={(value: "active" | "pending" | "sold") => setFormData({ ...formData, status: value })}
        >
          <SelectTrigger>
            <SelectValue />
          </SelectTrigger>
          <SelectContent>
            {statusOptions.map(option => (
              <SelectItem key={option.value} value={option.value}>
                {option.label}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>

      <div className="flex gap-4">
        <label className="flex items-center gap-2">
          <input
            type="checkbox"
            checked={formData.hasWarranty}
            onChange={(e) => setFormData({ ...formData, hasWarranty: e.target.checked })}
          />
          <span>Com Garantia</span>
        </label>
        <label className="flex items-center gap-2">
          <input
            type="checkbox"
            checked={formData.hasReport}
            onChange={(e) => setFormData({ ...formData, hasReport: e.target.checked })}
          />
          <span>Com Laudo</span>
        </label>
      </div>

      <Button
        type="submit"
        className="w-full bg-copart-blue hover:bg-blue-700"
        disabled={createVehicle.isPending || updateVehicle.isPending || uploading}
      >
        {(createVehicle.isPending || updateVehicle.isPending || uploading) ? (
          <>
            <Loader2 className="animate-spin mr-2" size={16} />
            {uploading ? "Fazendo upload..." : isEdit ? "Atualizando..." : "Cadastrando..."}
          </>
        ) : (
          <>{isEdit ? "Atualizar Veículo" : "Cadastrar Veículo"}</>
        )}
      </Button>
    </form> // Fecha a função VehicleForm
  );

  return ( // Início do return do componente AdminVehicles
    <div className="min-h-screen bg-slate-50">
      <div className="sticky top-0 z-30 border-b bg-white/80 backdrop-blur">
        <div className="max-w-6xl mx-auto px-4 py-4 flex items-center justify-between gap-3">
          <div>
            <p className="text-sm text-muted-foreground">Painel de Administração</p>
            <h1 className="text-3xl font-bold tracking-tight">Gerenciar Veículos</h1>
          </div>
          <Dialog
            open={isCreateOpen}
            onOpenChange={(open) => {
              setIsCreateOpen(open);
              if (!open && matchCreate) {
                setLocation("/admin/vehicles");
              }
            }}
          >
            <DialogTrigger asChild>
              <Button
                className="bg-copart-orange hover:bg-yellow-600 shadow-sm"
                onClick={() => setLocation("/admin/vehicles/new")}
              >
                <Plus size={16} className="mr-2" />
                Novo Veículo
              </Button>
            </DialogTrigger>
            <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
              <DialogHeader>
                <DialogTitle>Cadastrar Novo Veículo</DialogTitle>
              </DialogHeader>
              <VehicleForm onSubmit={handleSubmit} />
            </DialogContent>
          </Dialog>
        </div>
      </div>

      <main className="max-w-6xl mx-auto px-4 pb-12 space-y-8">
        <section className="grid gap-4 md:grid-cols-[2fr,1fr] pt-8">
          <Card className="shadow-sm border-dashed border-muted/60">
            <CardHeader>
              <CardTitle className="flex items-center justify-between text-lg">
                Visão geral
                <Badge variant="secondary">{vehicles?.length || 0} veículos</Badge>
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-3 text-muted-foreground text-sm leading-relaxed">
              <p>Cadastre, atualize ou remova veículos de forma rápida. Use o campo de busca para encontrar lotes por número, modelo ou marca.</p>
              <p className="text-xs">Dica: clique no card para editar ou no ícone de lixeira para remover.</p>
            </CardContent>
          </Card>

          <Card className="shadow-sm">
            <CardHeader>
              <CardTitle className="text-base">Busca rápida</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <Input
                placeholder="Buscar por lote, marca, modelo ou ano"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="h-11"
              />
              <p className="text-xs text-muted-foreground">
                {filteredVehicles.length} resultado{filteredVehicles.length === 1 ? "" : "s"} exibido{filteredVehicles.length === 1 ? "" : "s"}
              </p>
            </CardContent>
          </Card>
        </section>

        {isLoading ? (
          <div className="flex justify-center py-16">
            <Loader2 className="animate-spin" size={48} />
          </div>
        ) : (
          <div className="grid gap-4">
            {filteredVehicles.length === 0 ? (
              <Card className="border-dashed text-center text-muted-foreground py-12">
                <p>Nenhum veículo encontrado. Tente outra busca ou cadastre um novo.</p>
              </Card>
            ) : (
              filteredVehicles.map((vehicle: Vehicle) => (
                <Card
                  key={vehicle.id}
                  className="shadow-sm border-border/80 hover:border-primary/40 hover:shadow-md transition-all"
                >
                  <CardContent className="p-4 sm:p-5">
                    <div className="flex flex-col sm:flex-row gap-4 sm:items-center">
                      <div className="w-full sm:w-28 h-28 bg-gray-100 rounded-xl overflow-hidden border flex-shrink-0">
                        {(vehicle.images?.[0] || vehicle.imageUrl) ? (
                          <img
                            src={vehicle.images?.[0] || vehicle.imageUrl}
                            alt={`${vehicle.year} ${vehicle.make} ${vehicle.model}`}
                            className="w-full h-full object-cover"
                          />
                        ) : (
                          <div className="w-full h-full flex items-center justify-center text-gray-400 text-xs">Sem imagem</div>
                        )}
                      </div>

                      <div className="flex-1 space-y-2">
                        <div className="flex flex-wrap items-center gap-2">
                          <Badge variant="outline">Lote {vehicle.lotNumber}</Badge>
                          <Badge variant="secondary" className="capitalize">
                            {vehicle.saleType === "auction" ? "Leilão" : "Venda Direta"}
                          </Badge>
                        </div>
                        <h3 className="font-semibold text-lg leading-tight">
                          {vehicle.year} {vehicle.make} {vehicle.model}
                        </h3>
                        <p className="text-sm text-muted-foreground line-clamp-2">
                          {vehicle.description || "Sem descrição"}
                        </p>
                        <div className="flex flex-wrap gap-3 text-sm text-muted-foreground">
                          <span>
                            Lance atual: <span className="font-semibold text-foreground">R$ {vehicle.currentBid.toLocaleString("pt-BR")}</span>
                          </span>
                          {vehicle.buyNowPrice ? (
                            <span>
                              Compra já: <span className="font-semibold text-foreground">R$ {vehicle.buyNowPrice.toLocaleString("pt-BR")}</span>
                            </span>
                          ) : null}
                        </div>
                      </div>

                      <div className="flex items-center gap-2 self-start">
                        <Button
                          variant="ghost"
                          size="sm"
                          className="shadow-xs"
                          onClick={() => setPreviewVehicle(vehicle)}
                        >
                          <Eye size={16} className="mr-1" />
                          Prévia
                        </Button>
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => setLocation(`/admin/vehicles/edit/${vehicle.id}`)}
                          className="shadow-xs"
                        >
                          <Edit2 size={16} />
                        </Button>
                        <Button
                          variant="destructive"
                          size="sm"
                          onClick={() => handleDelete(vehicle.id)}
                          disabled={deleteVehicle.isPending}
                          className="shadow-xs"
                        >
                          <Trash2 size={16} />
                        </Button>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))
            )}
          </div>
        )}

        <Dialog
          open={!!previewVehicle}
          onOpenChange={(open) => {
            if (!open) closePreview();
          }}
        >
          <DialogContent className="max-w-3xl">
            <DialogHeader>
              <DialogTitle>Prévia do veículo</DialogTitle>
            </DialogHeader>
            {previewVehicle &&
              (() => {
                const previewImage =
                  previewVehicle.images?.[0] ||
                  previewVehicle.imageUrl ||
                  `https://placehold.co/800x600/0F172A/FFFFFF/png?text=${previewVehicle.make}+${previewVehicle.model}`;

                return (
                  <div className="space-y-4">
                    <div className="aspect-[4/3] w-full overflow-hidden rounded-xl border bg-muted">
                      <img
                        src={previewImage}
                        alt={`${previewVehicle.year} ${previewVehicle.make} ${previewVehicle.model}`}
                        className="h-full w-full object-cover"
                      />
                    </div>
                    <div className="grid gap-4 md:grid-cols-2">
                      <div className="space-y-1">
                        <p className="text-sm text-muted-foreground">Lote {previewVehicle.lotNumber}</p>
                        <h3 className="text-xl font-semibold">
                          {previewVehicle.year} {previewVehicle.make} {previewVehicle.model}
                        </h3>
                        <p className="text-sm text-muted-foreground line-clamp-3">
                          {previewVehicle.description || "Sem descrição"}
                        </p>
                      </div>
                      <div className="space-y-1 text-right">
                        <p className="text-sm text-muted-foreground">Lance atual</p>
                        <p className="text-2xl font-bold">
                          R$ {(previewVehicle.currentBid || 0).toLocaleString("pt-BR")}
                        </p>
                        {previewVehicle.buyNowPrice ? (
                          <p className="text-sm text-muted-foreground">
                            Compra direta por R$ {previewVehicle.buyNowPrice.toLocaleString("pt-BR")}
                          </p>
                        ) : null}
                      </div>
                    </div>
                  </div>
                );
              })()
            }
          </DialogContent>
        </Dialog>

        {/* Edit Dialog */}
        <Dialog
          open={isEditOpen}
          onOpenChange={(open) => {
            setIsEditOpen(open);
            if (!open && matchEdit) {
              setLocation("/admin/vehicles");
            }
          }}
        >
          <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle>Editar Veículo</DialogTitle>
            </DialogHeader>
            <VehicleForm onSubmit={handleUpdate} isEdit />
          </DialogContent>
        </Dialog>
      </main>
    </div>
  );
}