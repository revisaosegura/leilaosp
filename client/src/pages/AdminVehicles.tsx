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
import { trpc } from "@/lib/trpc";
import { useEffect, useState } from "react";
import { toast } from "sonner";
import { Loader2, Plus, Edit2, Trash2, X } from "lucide-react";
import { Link, useLocation, useRoute } from "wouter";
import { Badge } from "@/components/ui/badge";

export default function AdminVehicles() {
  const { user } = useAuth({ redirectOnUnauthenticated: true });
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [editingVehicle, setEditingVehicle] = useState<any>(null);
  const [imageFiles, setImageFiles] = useState<File[]>([]);
  const [imagePreviews, setImagePreviews] = useState<string[]>([]);
  const [uploading, setUploading] = useState(false);

  const { data: vehicles, isLoading, refetch } = trpc.vehicles.list.useQuery({ limit: 100 });
  const { data: locations } = trpc.locations.list.useQuery();
  const { data: categories } = trpc.categories.list.useQuery();
  const [searchTerm, setSearchTerm] = useState("");

  const [, setLocation] = useLocation();
  const [matchCreate] = useRoute("/admin/vehicles/new");
  const [matchEdit, editParams] = useRoute("/admin/vehicles/edit/:id");

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
    onError: (error) => {
      toast.error("Erro ao cadastrar veículo: " + error.message);
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
    onError: (error) => {
      toast.error("Erro ao atualizar veículo: " + error.message);
    },
  });

  const deleteVehicle = trpc.vehicles.delete.useMutation({
    onSuccess: () => {
      toast.success("Veículo deletado com sucesso!");
      refetch();
    },
    onError: (error) => {
      toast.error("Erro ao deletar veículo: " + error.message);
    },
  });

  const [formData, setFormData] = useState({
    lotNumber: "",
    year: new Date().getFullYear().toString(),
    make: "",
    model: "",
    description: "",
    imageUrl: "",
    images: [] as string[],
    currentBid: "",
    buyNowPrice: "",
    locationId: 1,
    categoryId: 1,
    saleType: "auction" as "auction" | "direct",
    hasWarranty: false,
    hasReport: false,
  });

  const resetForm = () => {
    setFormData({
      lotNumber: "",
      year: new Date().getFullYear().toString(),
      make: "",
      model: "",
      description: "",
      imageUrl: "",
      images: [],
      currentBid: "",
      buyNowPrice: "",
      locationId: 1,
      categoryId: 1,
      saleType: "auction",
      hasWarranty: false,
      hasReport: false,
    });
    setImageFiles([]);
    setImagePreviews([]);
  };

  const sanitizeCurrencyInput = (value: string) => value.replace(/[^0-9.,]/g, "");

  const parseCurrencyToNumber = (value: string) => {
    if (!value) return 0;

    const normalized = value.replace(/\./g, "").replace(",", ".");
    const parsed = parseFloat(normalized);

    return isNaN(parsed) ? 0 : parsed;
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files || []);

    if (files.length > 0) {
      setImageFiles(prev => [...prev, ...files]);
      setImagePreviews(prev => [...prev, ...files.map(file => URL.createObjectURL(file))]);
    }
  };

  const handleRemoveExistingImage = (index: number) => {
    setFormData(prev => ({
      ...prev,
      images: prev.images.filter((_, i) => i !== index),
    }));
  };

  const handleRemoveNewImage = (index: number) => {
    setImageFiles(prev => prev.filter((_, i) => i !== index));
    setImagePreviews(prev => prev.filter((_, i) => i !== index));
  };

  const uploadImages = async (): Promise<string[]> => {
    if (imageFiles.length === 0) return formData.images;

    setUploading(true);
    try {
      const formDataUpload = new FormData();
      imageFiles.forEach(file => formDataUpload.append("images", file));

      const response = await fetch("/api/upload/multiple", {
        method: "POST",
        body: formDataUpload,
      });

      if (!response.ok) {
        throw new Error("Erro ao fazer upload das imagens");
      }

      const data = await response.json();
      return [...formData.images, ...data.imageUrls];
    } catch (error) {
      toast.error("Erro ao fazer upload das imagens");
      throw error;
    } finally {
      setUploading(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const images = await uploadImages();

      createVehicle.mutate({
        ...formData,
        year: parseInt(formData.year) || new Date().getFullYear(),
        currentBid: parseCurrencyToNumber(formData.currentBid),
        buyNowPrice: formData.buyNowPrice ? parseCurrencyToNumber(formData.buyNowPrice) : null,
        images,
        imageUrl: images[0] || "",
      });
    } catch (error) {
      // Error already handled in uploadImages
    }
  };

  const handleUpdate = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const images = await uploadImages();

      updateVehicle.mutate({
        id: editingVehicle.id,
        ...formData,
        year: parseInt(formData.year) || new Date().getFullYear(),
        currentBid: parseCurrencyToNumber(formData.currentBid),
        buyNowPrice: formData.buyNowPrice ? parseCurrencyToNumber(formData.buyNowPrice) : null,
        images,
        imageUrl: images[0] || "",
      });
    } catch (error) {
      // Error already handled in uploadImages
    }
  };

  const handleEdit = (vehicle: any) => {
    setEditingVehicle(vehicle);
    setFormData({
      lotNumber: vehicle.lotNumber,
      year: vehicle.year?.toString() || new Date().getFullYear().toString(),
      make: vehicle.make,
      model: vehicle.model,
      description: vehicle.description || "",
      imageUrl: vehicle.imageUrl || "",
      images: vehicle.images || (vehicle.imageUrl ? [vehicle.imageUrl] : []),
      currentBid: vehicle.currentBid?.toString() || "",
      buyNowPrice: vehicle.buyNowPrice?.toString() || "",
      locationId: vehicle.locationId,
      categoryId: vehicle.categoryId,
      saleType: vehicle.saleType,
      hasWarranty: vehicle.hasWarranty,
      hasReport: vehicle.hasReport,
    });
    setImagePreviews(vehicle.images || (vehicle.imageUrl ? [vehicle.imageUrl] : []));
    setImageFiles([]);
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
      const vehicle = vehicles.find((v) => v.id === vehicleId);

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

  const filteredVehicles = (vehicles || []).filter((vehicle) => {
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
          rows={3}
        />
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

        {(formData.images.length > 0 || imagePreviews.length > 0) && (
          <div className="mt-3 grid grid-cols-2 md:grid-cols-3 gap-3">
            {formData.images.map((img, index) => (
              <div key={`existing-${index}`} className="relative">
                <img src={img} alt={`Imagem ${index + 1}`} className="w-full h-32 object-cover rounded" />
                <Button
                  type="button"
                  variant="destructive"
                  size="sm"
                  className="absolute top-2 right-2"
                  onClick={() => handleRemoveExistingImage(index)}
                >
                  <X size={16} />
                </Button>
              </div>
            ))}

            {imagePreviews.map((preview, index) => (
              <div key={`new-${index}`} className="relative">
                <img src={preview} alt={`Nova imagem ${index + 1}`} className="w-full h-32 object-cover rounded" />
                <Button
                  type="button"
                  variant="destructive"
                  size="sm"
                  className="absolute top-2 right-2"
                  onClick={() => handleRemoveNewImage(index)}
                >
                  <X size={16} />
                </Button>
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
          <Label htmlFor="locationId">Pátio *</Label>
          <Select
            value={formData.locationId.toString()}
            onValueChange={(value) => setFormData({ ...formData, locationId: parseInt(value) })}
          >
            <SelectTrigger>
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {locations?.map((location) => (
                <SelectItem key={location.id} value={location.id.toString()}>
                  {location.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div>
          <Label htmlFor="categoryId">Categoria *</Label>
          <Select
            value={formData.categoryId.toString()}
            onValueChange={(value) => setFormData({ ...formData, categoryId: parseInt(value) })}
          >
            <SelectTrigger>
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {categories?.map((category) => (
                <SelectItem key={category.id} value={category.id.toString()}>
                  {category.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
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
    </form>
  );

  return (
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
              filteredVehicles.map((vehicle) => (
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
