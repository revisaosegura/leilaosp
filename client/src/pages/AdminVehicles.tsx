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
import { Loader2, Plus, Edit2, Trash2, Upload, X } from "lucide-react";
import { Link, useLocation, useRoute } from "wouter";
import DashboardLayout from "@/components/DashboardLayout";

export default function AdminVehicles() {
  const { user } = useAuth({ redirectOnUnauthenticated: true });
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [editingVehicle, setEditingVehicle] = useState<any>(null);
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [imagePreview, setImagePreview] = useState<string>("");
  const [uploading, setUploading] = useState(false);

  const { data: vehicles, isLoading, refetch } = trpc.vehicles.list.useQuery({ limit: 100 });
  const { data: locations } = trpc.locations.list.useQuery();
  const { data: categories } = trpc.categories.list.useQuery();

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
    year: new Date().getFullYear(),
    make: "",
    model: "",
    description: "",
    imageUrl: "",
    currentBid: 0,
    buyNowPrice: 0,
    locationId: 1,
    categoryId: 1,
    saleType: "auction" as "auction" | "direct",
    hasWarranty: false,
    hasReport: false,
  });

  const resetForm = () => {
    setFormData({
      lotNumber: "",
      year: new Date().getFullYear(),
      make: "",
      model: "",
      description: "",
      imageUrl: "",
      currentBid: 0,
      buyNowPrice: 0,
      locationId: 1,
      categoryId: 1,
      saleType: "auction",
      hasWarranty: false,
      hasReport: false,
    });
    setImageFile(null);
    setImagePreview("");
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setImageFile(file);
      const reader = new FileReader();
      reader.onloadend = () => {
        setImagePreview(reader.result as string);
      };
      reader.readAsDataURL(file);
    }
  };

  const uploadImage = async (): Promise<string> => {
    if (!imageFile) return formData.imageUrl;

    setUploading(true);
    try {
      const formDataUpload = new FormData();
      formDataUpload.append("image", imageFile);

      const response = await fetch("/api/upload", {
        method: "POST",
        body: formDataUpload,
      });

      if (!response.ok) {
        throw new Error("Erro ao fazer upload da imagem");
      }

      const data = await response.json();
      return data.imageUrl;
    } catch (error) {
      toast.error("Erro ao fazer upload da imagem");
      throw error;
    } finally {
      setUploading(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const imageUrl = await uploadImage();

      createVehicle.mutate({
        ...formData,
        imageUrl,
      });
    } catch (error) {
      // Error already handled in uploadImage
    }
  };

  const handleUpdate = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const imageUrl = await uploadImage();

      updateVehicle.mutate({
        id: editingVehicle.id,
        ...formData,
        imageUrl,
      });
    } catch (error) {
      // Error already handled in uploadImage
    }
  };

  const handleEdit = (vehicle: any) => {
    setEditingVehicle(vehicle);
    setFormData({
      lotNumber: vehicle.lotNumber,
      year: vehicle.year,
      make: vehicle.make,
      model: vehicle.model,
      description: vehicle.description || "",
      imageUrl: vehicle.imageUrl || "",
      currentBid: vehicle.currentBid,
      buyNowPrice: vehicle.buyNowPrice || 0,
      locationId: vehicle.locationId,
      categoryId: vehicle.categoryId,
      saleType: vehicle.saleType,
      hasWarranty: vehicle.hasWarranty,
      hasReport: vehicle.hasReport,
    });
    setImagePreview(vehicle.imageUrl || "");
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
            onChange={(e) => setFormData({ ...formData, year: parseInt(e.target.value) })}
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
        <Label htmlFor="image">Imagem do Veículo</Label>
        <Input
          id="image"
          type="file"
          accept="image/*"
          onChange={handleImageChange}
        />
        {imagePreview && (
          <div className="mt-2 relative">
            <img src={imagePreview} alt="Preview" className="w-full h-48 object-cover rounded" />
            <Button
              type="button"
              variant="destructive"
              size="sm"
              className="absolute top-2 right-2"
              onClick={() => {
                setImageFile(null);
                setImagePreview("");
                setFormData({ ...formData, imageUrl: "" });
              }}
            >
              <X size={16} />
            </Button>
          </div>
        )}
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <Label htmlFor="currentBid">Lance Atual (R$)</Label>
          <Input
            id="currentBid"
            type="number"
            value={formData.currentBid}
            onChange={(e) => setFormData({ ...formData, currentBid: parseInt(e.target.value) })}
          />
        </div>
        <div>
          <Label htmlFor="buyNowPrice">Preço Compra Direta (R$)</Label>
          <Input
            id="buyNowPrice"
            type="number"
            value={formData.buyNowPrice}
            onChange={(e) => setFormData({ ...formData, buyNowPrice: parseInt(e.target.value) })}
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
    <DashboardLayout>
      <div className="p-8">
        <div className="flex justify-between items-center mb-8">
          <h1 className="text-3xl font-bold">Gerenciar Veículos</h1>
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
                className="bg-copart-orange hover:bg-yellow-600"
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

        {isLoading ? (
          <div className="flex justify-center py-12">
            <Loader2 className="animate-spin" size={48} />
          </div>
        ) : (
          <Card>
            <CardHeader>
              <CardTitle>Lista de Veículos ({vehicles?.length || 0})</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {vehicles?.map((vehicle) => (
                  <div
                    key={vehicle.id}
                    className="flex items-center gap-4 border rounded-lg p-4 hover:shadow-md transition-shadow"
                  >
                    <div className="w-24 h-24 bg-gray-200 rounded overflow-hidden flex-shrink-0">
                      {vehicle.imageUrl ? (
                        <img
                          src={vehicle.imageUrl}
                          alt={`${vehicle.year} ${vehicle.make} ${vehicle.model}`}
                          className="w-full h-full object-cover"
                        />
                      ) : (
                        <div className="w-full h-full flex items-center justify-center text-gray-400 text-xs">
                          Sem imagem
                        </div>
                      )}
                    </div>
                    <div className="flex-1">
                      <h3 className="font-bold text-lg">
                        {vehicle.year} {vehicle.make} {vehicle.model}
                      </h3>
                      <p className="text-sm text-gray-600">Lote: {vehicle.lotNumber}</p>
                      <div className="flex gap-4 mt-2 text-sm">
                        <span className="text-gray-600">
                          Lance: <span className="font-bold">R$ {vehicle.currentBid.toLocaleString("pt-BR")}</span>
                        </span>
                        <span className="text-gray-600">
                          Tipo: <span className="capitalize">{vehicle.saleType === "auction" ? "Leilão" : "Venda Direta"}</span>
                        </span>
                      </div>
                    </div>
                    <div className="flex gap-2">
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => setLocation(`/admin/vehicles/edit/${vehicle.id}`)}
                      >
                        <Edit2 size={16} />
                      </Button>
                      <Button
                        variant="destructive"
                        size="sm"
                        onClick={() => handleDelete(vehicle.id)}
                        disabled={deleteVehicle.isPending}
                      >
                        <Trash2 size={16} />
                      </Button>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
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
      </div>
    </DashboardLayout>
  );
}
