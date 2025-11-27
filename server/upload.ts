import express from "express";
import multer from "multer";
import path from "path";

import { StorageConfigError, storagePut } from "./storage";

const router = express.Router();

const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 10 * 1024 * 1024, // 10MB
    files: 10,
  },
  fileFilter: (_req, file, cb) => {
    if (file.mimetype.startsWith("image/")) {
      cb(null, true);
    } else {
      cb(new Error("Apenas imagens são permitidas"));
    }
  },
});

router.post(
  "/upload-b2",
  upload.array("images", 10),
  async (req, res): Promise<void> => {
    try {
      const files = req.files as Express.Multer.File[] | undefined;

      if (!files?.length) {
        res.status(400).json({ error: "Nenhuma imagem enviada ou formato inválido" });
        return;
      }

      const uploadResults = await Promise.all(
        files.map(async (file, index) => {
          const extension = path.extname(file.originalname) || ".jpg";
          const key = `vehicles/${Date.now()}-${index}${extension}`;

          const { url } = await storagePut(
            key,
            file.buffer,
            file.mimetype,
            { expectedLength: file.size }
          );

          return url;
        })
      );

      res.json({
        success: true,
        imageUrls: uploadResults,
        message: `${uploadResults.length} imagem(ns) uploadada(s) com sucesso`,
      });
    } catch (error) {
      if (error instanceof StorageConfigError) {
        res.status(error.status).json({ error: error.message });
        return;
      }

      const message = error instanceof Error ? error.message : "Erro no upload";
      res.status(500).json({ error: message });
    }
  }
);

export default router;
