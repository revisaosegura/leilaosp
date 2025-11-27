import { type NextFunction, type Request, type Response, Router } from "express";
import multer from "multer";
import path from "path";
import { storagePut } from "./storage";

const router = Router();

const MAX_UPLOAD_FILES = 30;

// Configure multer for file upload
const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB limit
  },
  fileFilter: (req, file, cb) => {
    const allowedTypes = /jpeg|jpg|png|webp/;
    const extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());
    const mimetype = allowedTypes.test(file.mimetype);

    if (mimetype && extname) {
      return cb(null, true);
    } else {
      cb(new Error("Apenas imagens são permitidas (jpeg, jpg, png, webp)"));
    }
  },
});

function handleUploadError(
  err: unknown,
  req: Request,
  res: Response,
  next: NextFunction
) {
  if (!err) return next();

  if (err instanceof multer.MulterError) {
    if (err.code === "LIMIT_FILE_SIZE") {
      return res
        .status(400)
        .json({ error: "Arquivo muito grande. O limite é de 5MB por imagem." });
    }

    if (err.code === "LIMIT_UNEXPECTED_FILE") {
      return res.status(400).json({
        error: `Máximo de ${MAX_UPLOAD_FILES} imagens por envio. Remova algumas ou envie em partes.`,
      });
    }

    return res.status(400).json({ error: err.message });
  }

  if (err instanceof Error) {
    return res.status(400).json({ error: err.message });
  }

  return res.status(500).json({ error: "Erro ao fazer upload da imagem" });
}

function buildStorageKey(originalName: string) {
  const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
  const ext = path.extname(originalName) || ".bin";
  return `vehicles/vehicle-${uniqueSuffix}${ext}`;
}

// Upload single image
router.post("/upload", upload.single("image"), async (req, res) => {
  try {
    const file = req.file;

    if (!file) {
      return res.status(400).json({ error: "Nenhum arquivo enviado" });
    }

    const key = buildStorageKey(file.originalname);
    const { url } = await storagePut(key, file.buffer, file.mimetype);

    res.json({
      success: true,
      imageUrl: url,
      filename: key,
    });
  } catch (error) {
    console.error("Upload error:", error);
    res.status(500).json({ error: "Erro ao fazer upload da imagem" });
  }
}, handleUploadError);

// Upload multiple images
router.post("/upload/multiple", upload.array("images", MAX_UPLOAD_FILES), async (req, res) => {
  try {
    const files = req.files as Express.Multer.File[];
    if (!files || files.length === 0) {
      return res.status(400).json({ error: "Nenhum arquivo enviado" });
    }

    const uploads = await Promise.all(
      files.map(async file => {
        const key = buildStorageKey(file.originalname);
        const { url } = await storagePut(key, file.buffer, file.mimetype);
        return { url, key };
      })
    );
    const imageUrls = uploads.map(result => result.url);

    res.json({
      success: true,
      imageUrls,
      filenames: uploads.map(result => result.key),
    });
  } catch (error) {
    const message =
      error instanceof Error && error.message
        ? error.message
        : "Erro ao fazer upload das imagens";
    console.error("Upload error:", error);
    res.status(500).json({ error: message });
  }
}, handleUploadError);

// Delete image - not yet supported on storage service
router.delete("/upload/:filename", (req, res) => {
  res.status(501).json({ error: "Remoção de imagens não está disponível" });
});

export default router;
