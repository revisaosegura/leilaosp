import express, { type Express } from "express";
import fs from "fs";
import { type Server } from "http";
import { nanoid } from "nanoid";
import path from "path";
import { createServer as createViteServer } from "vite";
import viteConfig from "../../vite.config";

export async function setupVite(app: Express, server: Server) {
  const serverOptions = {
    middlewareMode: true,
    hmr: { server },
    allowedHosts: true as const,
  };

  const vite = await createViteServer({
    ...viteConfig,
    configFile: false,
    server: serverOptions,
    appType: "custom",
  });

  app.use(vite.middlewares);
  app.use("*", async (req, res, next) => {
    const url = req.originalUrl;

    try {
      const clientTemplate = path.resolve(
        import.meta.dirname,
        "../..",
        "client",
        "index.html"
      );

      // always reload the index.html file from disk incase it changes
      let template = await fs.promises.readFile(clientTemplate, "utf-8");
      template = template.replace(
        `src="/src/main.tsx"`,
        `src="/src/main.tsx?v=${nanoid()}"`
      );
      const page = await vite.transformIndexHtml(url, template);
      res.status(200).set({ "Content-Type": "text/html" }).end(page);
    } catch (e) {
      vite.ssrFixStacktrace(e as Error);
      next(e);
    }
  });
}

export function serveStatic(app: Express) {
  // Robust public path detection
  const possiblePaths = [
    path.resolve(import.meta.dirname, "../../public"), // dist/server/_core -> dist/public
    path.resolve(import.meta.dirname, "../public"),    // dist/server -> dist/public
    path.resolve(process.cwd(), "dist/public"),        // root -> dist/public
    path.resolve(process.cwd(), "public")              // root -> public
  ];

  // Encontra o primeiro caminho que existe
  const distPath = possiblePaths.find(p => fs.existsSync(p)) || possiblePaths[0];

  if (!fs.existsSync(distPath)) {
    console.error(
      `[Static] Could not find public directory. Tried: ${possiblePaths.join(", ")}`
    );
  } else {
    console.log(`[Static] Serving static files from: ${distPath}`);
  }

  app.use(express.static(distPath));

  // fall through to index.html if the file doesn't exist
  app.use("*", (req, res, next) => {
    // [FIX] Nunca servir index.html para rotas de API
    if (req.originalUrl.startsWith("/api")) {
      return next();
    }
    
    const indexPath = path.resolve(distPath, "index.html");
    if (fs.existsSync(indexPath)) {
      res.sendFile(indexPath);
    } else {
      console.error(`[Static] index.html not found at ${indexPath}`);
      next();
    }
  });
}
