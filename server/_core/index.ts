import "dotenv/config";
import express from "express";
import cookieParser from "cookie-parser";
import { createServer } from "http";
import net from "net";
import { createExpressMiddleware } from "@trpc/server/adapters/express";
import { registerLocalAuthRoutes } from "./localAuth";
import { appRouter } from "../routers";
import { createContext } from "./context";
import { serveStatic, setupVite } from "./vite";
import uploadRouter from "../upload";

// Define valores padrão para variáveis de Analytics para evitar erros no frontend
if (!process.env.VITE_ANALYTICS_ENDPOINT) {
  process.env.VITE_ANALYTICS_ENDPOINT = "";
}
if (!process.env.VITE_ANALYTICS_WEBSITE_ID) {
  process.env.VITE_ANALYTICS_WEBSITE_ID = "";
}

function isPortAvailable(port: number): Promise<boolean> {
  return new Promise(resolve => {
    const server = net.createServer();
    server.listen(port, () => {
      server.close(() => resolve(true));
    });
    server.on("error", () => resolve(false));
  });
}

async function findAvailablePort(startPort: number = 3000): Promise<number> {
  for (let port = startPort; port < startPort + 20; port++) {
    if (await isPortAvailable(port)) {
      return port;
    }
  }
  throw new Error(`No available port found starting from ${startPort}`);
}

async function startServer() {
  const app = express();
  const server = createServer(app);

  // [DEBUG] Log de TODAS as requisições para diagnóstico
  app.use((req, res, next) => {
    console.log(`[HTTP] ${req.method} ${req.url}`);
    next();
  });

  // [FIX] Rota específica para o script de analytics (usando middleware para maior flexibilidade)
  app.use((req, res, next) => {
    if (req.url.includes("umami")) {
      res.setHeader("Content-Type", "application/javascript");
      return res.status(200).send("/* analytics disabled */");
    }
    next();
  });

  // Configure body parser with larger size limit for file uploads
  app.use(express.json({ limit: "50mb" }));
  app.use(express.urlencoded({ limit: "50mb", extended: true }));
  app.use(cookieParser());
  // Serve static uploads
  app.use("/uploads", express.static("public/uploads"));
  
  // Local authentication routes
  registerLocalAuthRoutes(app);

  // Upload routes
  app.use("/api", uploadRouter);
  
  // tRPC API
  app.use(
    "/api/trpc",
    createExpressMiddleware({
      router: appRouter,
      createContext,
    })
  );

  // [FIX] 404 handler for API routes to avoid returning HTML
  app.use("/api", (req, res) => {
    console.log(`[API] 404 Not Found: ${req.method} ${req.originalUrl}`);
    if (!res.headersSent) {
      res.status(404).json({ error: "API endpoint not found" });
    }
  });

  // development mode uses Vite, production mode uses static files
  if (process.env.NODE_ENV === "development") {
    await setupVite(app, server);
  } else {
    serveStatic(app);
  }

  // Middleware global de tratamento de erros para evitar que o servidor caia com URIs malformadas
  app.use((err: any, req: express.Request, res: express.Response, next: express.NextFunction) => {
    if (err instanceof URIError) {
      console.error("Erro de URI detectado (provavelmente variável de ambiente faltando no Render):", err.message);
      return res.status(400).send("Bad Request");
    }
    console.error(err);
    res.status(500).send("Internal Server Error");
  });

  const preferredPort = parseInt(process.env.PORT || "3000");
  const port = await findAvailablePort(preferredPort);

  if (port !== preferredPort) {
    console.log(`Port ${preferredPort} is busy, using port ${port} instead`);
  }

  server.listen(port, () => {
    console.log(`Server running on http://localhost:${port}/`);
  });
}

startServer().catch(console.error);
