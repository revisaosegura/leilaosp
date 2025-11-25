import { describe, expect, it } from "vitest";
import { appRouter } from "./routers";
import type { TrpcContext } from "./_core/context";

type AuthenticatedUser = NonNullable<TrpcContext["user"]>;

function createAdminContext(): TrpcContext {
  const user: AuthenticatedUser = {
    id: 1,
    openId: "admin-user",
    email: "admin@copart.com",
    name: "Admin User",
    loginMethod: "manus",
    role: "admin",
    createdAt: new Date(),
    updatedAt: new Date(),
    lastSignedIn: new Date(),
  };

  return {
    user,
    req: {
      protocol: "https",
      headers: {},
    } as TrpcContext["req"],
    res: {} as TrpcContext["res"],
  };
}

function createUserContext(): TrpcContext {
  const user: AuthenticatedUser = {
    id: 2,
    openId: "regular-user",
    email: "user@example.com",
    name: "Regular User",
    loginMethod: "manus",
    role: "user",
    createdAt: new Date(),
    updatedAt: new Date(),
    lastSignedIn: new Date(),
  };

  return {
    user,
    req: {
      protocol: "https",
      headers: {},
    } as TrpcContext["req"],
    res: {} as TrpcContext["res"],
  };
}

describe("vehicles.list", () => {
  it("should return a list of vehicles", async () => {
    const ctx = createUserContext();
    const caller = appRouter.createCaller(ctx);

    const result = await caller.vehicles.list();

    expect(result).toBeDefined();
    expect(Array.isArray(result)).toBe(true);
  });

  it("should filter vehicles by search query", async () => {
    const ctx = createUserContext();
    const caller = appRouter.createCaller(ctx);

    const result = await caller.vehicles.list({ search: "BMW" });

    expect(result).toBeDefined();
    expect(Array.isArray(result)).toBe(true);
  });

  it("should filter vehicles by sale type", async () => {
    const ctx = createUserContext();
    const caller = appRouter.createCaller(ctx);

    const result = await caller.vehicles.list({ saleType: "auction" });

    expect(result).toBeDefined();
    expect(Array.isArray(result)).toBe(true);
    if (result.length > 0) {
      expect(result.every((v) => v.saleType === "auction")).toBe(true);
    }
  });
});

describe("vehicles.getById", () => {
  it("should return a vehicle by id", async () => {
    const ctx = createUserContext();
    const caller = appRouter.createCaller(ctx);

    // First get a vehicle from the list
    const vehicles = await caller.vehicles.list({ limit: 1 });
    
    if (vehicles.length > 0) {
      const vehicle = await caller.vehicles.getById({ id: vehicles[0]!.id });
      expect(vehicle).toBeDefined();
      expect(vehicle.id).toBe(vehicles[0]!.id);
    }
  });

  it("should throw error for non-existent vehicle", async () => {
    const ctx = createUserContext();
    const caller = appRouter.createCaller(ctx);

    await expect(caller.vehicles.getById({ id: 999999 })).rejects.toThrow();
  });
});

describe("vehicles.create", () => {
  it("should create a vehicle and prevent duplicate lot numbers", async () => {
    const ctx = createAdminContext();
    const caller = appRouter.createCaller(ctx);

    const lotNumber = `TEST-LOT-${Date.now()}`;

    const payload = {
      lotNumber,
      year: 2025,
      make: "Marca Teste",
      model: "Modelo Teste",
      description: "Veículo criado para teste automatizado",
      documentStatus: "Normal",
      categoryDetail: "Automóveis",
      condition: "Inteiro",
      runningCondition: "Motor dá partida",
      montaType: "Pequena Monta",
      chassisType: "Normal",
      comitente: "Copart",
      patio: "Itaquaquecetuba - SP",
      imageUrl: "",
      images: [],
      currentBid: 0,
      buyNowPrice: null,
      fipeValue: null,
      bidIncrement: null,
      locationId: 1,
      categoryId: 1,
      saleType: "auction" as const,
      hasWarranty: false,
      hasReport: false,
    };

    const created = await caller.vehicles.create(payload);
    expect(created.lotNumber).toBe(lotNumber);

    await expect(caller.vehicles.create(payload)).rejects.toThrow(
      /número de lote/
    );
  });

  it("should coerce string inputs and apply defaults when values are missing", async () => {
    const ctx = createAdminContext();
    const caller = appRouter.createCaller(ctx);

    const lotNumber = `STRING-LOT-${Date.now()}`;

    const vehicle = await caller.vehicles.create({
      lotNumber,
      year: "2026" as unknown as number,
      make: "Marca",
      model: "Modelo",
      currentBid: "15000" as unknown as number,
      buyNowPrice: undefined,
      fipeValue: undefined,
      bidIncrement: undefined,
      locationId: undefined as unknown as number,
      categoryId: undefined as unknown as number,
      hasWarranty: undefined as unknown as boolean,
      hasReport: undefined as unknown as boolean,
      saleType: undefined as unknown as "auction" | "direct",
    });

    expect(vehicle.lotNumber).toBe(lotNumber);
    expect(vehicle.year).toBe(2026);
    expect(vehicle.currentBid).toBe(15000);
    expect(vehicle.locationId).toBeGreaterThan(0);
    expect(vehicle.categoryId).toBeGreaterThan(0);
    expect(vehicle.saleType).toBe("auction");
    expect(vehicle.hasWarranty).toBe(false);
    expect(vehicle.hasReport).toBe(false);
  });

  it("should reject duplicate lot numbers even when whitespace differs", async () => {
    const ctx = createAdminContext();
    const caller = appRouter.createCaller(ctx);

    const baseLot = `SPACE-LOT-${Date.now()}`;

    const first = await caller.vehicles.create({
      lotNumber: `${baseLot}   `,
      year: 2027,
      make: "Marca", 
      model: "Modelo",
      currentBid: 0,
      buyNowPrice: null,
      fipeValue: null,
      bidIncrement: null,
      locationId: 1,
      categoryId: 1,
      saleType: "auction",
      hasWarranty: false,
      hasReport: false,
    });

    expect(first.lotNumber).toBe(baseLot);

    await expect(
      caller.vehicles.create({
        lotNumber: `  ${baseLot}`,
        year: 2027,
        make: "Marca",
        model: "Modelo",
        currentBid: 0,
        buyNowPrice: null,
        fipeValue: null,
        bidIncrement: null,
        locationId: 1,
        categoryId: 1,
        saleType: "auction",
        hasWarranty: false,
        hasReport: false,
      }),
    ).rejects.toThrow(/lote/);
  });
});

describe("categories.list", () => {
  it("should return a list of categories", async () => {
    const ctx = createUserContext();
    const caller = appRouter.createCaller(ctx);

    const result = await caller.categories.list();

    expect(result).toBeDefined();
    expect(Array.isArray(result)).toBe(true);
  });
});

describe("locations.list", () => {
  it("should return a list of locations", async () => {
    const ctx = createUserContext();
    const caller = appRouter.createCaller(ctx);

    const result = await caller.locations.list();

    expect(result).toBeDefined();
    expect(Array.isArray(result)).toBe(true);
  });
});

describe("admin access control", () => {
  it("should allow admin to access admin.users.list", async () => {
    const ctx = createAdminContext();
    const caller = appRouter.createCaller(ctx);

    const result = await caller.admin.users.list();

    expect(result).toBeDefined();
    expect(Array.isArray(result)).toBe(true);
  });

  it("should deny regular user access to admin.users.list", async () => {
    const ctx = createUserContext();
    const caller = appRouter.createCaller(ctx);

    await expect(caller.admin.users.list()).rejects.toThrow("Admin access required");
  });
});
