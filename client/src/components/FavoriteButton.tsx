import { Heart } from "lucide-react";
import { Button } from "@/components/ui/button";
import { trpc } from "@/lib/trpc";
import { useAuth } from "@/_core/hooks/useAuth";
import { toast } from "sonner";
import { useState, useEffect } from "react";

interface FavoriteButtonProps {
  vehicleId: number;
  variant?: "default" | "icon";
}

export default function FavoriteButton({ vehicleId, variant = "default" }: FavoriteButtonProps) {
  const { user } = useAuth();
  const [isFavorited, setIsFavorited] = useState(false);

  const { data: checkFavorite, isLoading: checkLoading } = trpc.favorites.check.useQuery(
    { vehicleId },
    { enabled: !!user }
  );

  const addFavoriteMutation = trpc.favorites.add.useMutation({
    onSuccess: () => {
      toast.success("Veículo adicionado aos favoritos!");
      setIsFavorited(true);
      trpc.useUtils().favorites.list.invalidate();
    },
    onError: (error) => {
      toast.error("Erro ao adicionar favorito: " + error.message);
    },
  });

  const removeFavoriteMutation = trpc.favorites.remove.useMutation({
    onSuccess: () => {
      toast.success("Veículo removido dos favoritos!");
      setIsFavorited(false);
      trpc.useUtils().favorites.list.invalidate();
    },
    onError: (error) => {
      toast.error("Erro ao remover favorito: " + error.message);
    },
  });

  useEffect(() => {
    if (checkFavorite !== undefined) {
      setIsFavorited(checkFavorite);
    }
  }, [checkFavorite]);

  const handleToggleFavorite = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();

    if (!user) {
      toast.error("Você precisa estar logado para favoritar veículos");
      return;
    }

    if (isFavorited) {
      removeFavoriteMutation.mutate({ vehicleId });
    } else {
      addFavoriteMutation.mutate({ vehicleId });
    }
  };

  const isLoading = addFavoriteMutation.isPending || removeFavoriteMutation.isPending || checkLoading;

  if (!user) {
    return null;
  }

  if (variant === "icon") {
    return (
      <Button
        onClick={handleToggleFavorite}
        variant="ghost"
        size="icon"
        disabled={isLoading}
        className={`${isFavorited ? "text-red-500" : "text-gray-400"} hover:text-red-500`}
      >
        <Heart size={20} fill={isFavorited ? "currentColor" : "none"} />
      </Button>
    );
  }

  return (
    <Button
      onClick={handleToggleFavorite}
      variant={isFavorited ? "default" : "outline"}
      disabled={isLoading}
      className={isFavorited ? "bg-red-500 hover:bg-red-600" : ""}
    >
      <Heart size={16} className="mr-2" fill={isFavorited ? "currentColor" : "none"} />
      {isFavorited ? "Remover dos Favoritos" : "Adicionar aos Favoritos"}
    </Button>
  );
}
