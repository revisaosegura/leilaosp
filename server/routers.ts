import { COOKIE_NAME } from "@shared/const";
import { getSessionCookieOptions } from "./_core/cookies";
import { systemRouter } from "./_core/systemRouter";
import { publicProcedure, protectedProcedure, router } from "./_core/trpc";
import { z } from "zod";
import { TRPCError } from "@trpc/server";
import * as db from "./db";

// Admin-only procedure
const adminProcedure = protectedProcedure.use(({ ctx, next }) => {
  if (ctx.user.role !== 'admin') {
    throw new TRPCError({ code: 'FORBIDDEN', message: 'Admin access required' });
  }
  return next({ ctx });
});

export const appRouter = router({
  system: systemRouter,
  
  auth: router({
    me: publicProcedure.query(opts => opts.ctx.user),
    logout: publicProcedure.mutation(({ ctx }) => {
      const cookieOptions = getSessionCookieOptions(ctx.req);
      ctx.res.clearCookie(COOKIE_NAME, { ...cookieOptions, maxAge: -1 });
      return { success: true } as const;
    }),
  }),

  vehicles: router({
    list: publicProcedure
      .input(z.object({
        search: z.string().optional(),
        saleType: z.enum(["auction", "direct"]).optional(),
        categoryId: z.number().optional(),
        limit: z.number().optional(),
      }).optional())
      .query(async ({ input }) => {
        return await db.getVehicles(input);
      }),

    getById: publicProcedure
      .input(z.object({ id: z.number() }))
      .query(async ({ input }) => {
        const vehicle = await db.getVehicleById(input.id);
        if (!vehicle) {
          throw new TRPCError({ code: 'NOT_FOUND', message: 'Vehicle not found' });
        }
        return vehicle;
      }),

    create: adminProcedure
      .input(z.object({
        lotNumber: z.coerce.string().trim().min(1, "Número do lote é obrigatório"),
        year: z.coerce.number().default(new Date().getFullYear()),
        make: z.string().trim(),
        model: z.string().trim(),
        description: z.string().optional(),
        documentStatus: z.string().optional(),
        categoryDetail: z.string().optional(),
        condition: z.string().optional(),
        runningCondition: z.string().optional(),
        montaType: z.string().optional(),
        chassisType: z.string().optional(),
        comitente: z.string().optional(),
        patio: z.string().optional(),
        imageUrl: z.string().optional(),
        images: z.array(z.string()).optional(),
        currentBid: z.coerce.number().default(0),
        buyNowPrice: z.coerce.number().nullable().optional(),
        fipeValue: z.coerce.number().nullable().optional(),
        bidIncrement: z.coerce.number().nullable().optional(),
        locationId: z.coerce.number().default(1),
        categoryId: z.coerce.number().default(1),
        saleType: z.enum(["auction", "direct"]).default("auction"),
        status: z.enum(["active", "sold", "pending"]).default("active"),
        hasWarranty: z.coerce.boolean().default(false),
        hasReport: z.coerce.boolean().default(false),
      }))
      .mutation(async ({ input }) => {
        const exists = await db.vehicleExistsByLotNumber(input.lotNumber);

        if (exists) {
          throw new TRPCError({
            code: "CONFLICT",
            message: "Já existe um veículo com este número de lote",
          });
        }

        const images = input.images?.length ? JSON.stringify(input.images) : undefined;
        const imageUrl = input.imageUrl || input.images?.[0];

        const vehicle = await db.createVehicle({
          ...input,
          images,
          imageUrl,
        });

        if (!vehicle) {
          throw new TRPCError({ code: "INTERNAL_SERVER_ERROR", message: "Não foi possível salvar o veículo" });
        }

        return vehicle;
      }),

    update: adminProcedure
      .input(z.object({
        id: z.number(),
        lotNumber: z.coerce.string().trim().optional(),
        year: z.coerce.number().optional(),
        make: z.string().trim().optional(),
        model: z.string().trim().optional(),
        description: z.string().optional(),
        documentStatus: z.string().optional(),
        categoryDetail: z.string().optional(),
        condition: z.string().optional(),
        runningCondition: z.string().optional(),
        montaType: z.string().optional(),
        chassisType: z.string().optional(),
        comitente: z.string().optional(),
        patio: z.string().optional(),
        imageUrl: z.string().optional(),
        images: z.array(z.string()).optional(),
        currentBid: z.coerce.number().optional(),
        buyNowPrice: z.coerce.number().nullable().optional(),
        fipeValue: z.coerce.number().nullable().optional(),
        bidIncrement: z.coerce.number().nullable().optional(),
        locationId: z.coerce.number().optional(),
        categoryId: z.coerce.number().optional(),
        saleType: z.enum(["auction", "direct"]).optional(),
        status: z.enum(["active", "sold", "pending"]).optional(),
        hasWarranty: z.coerce.boolean().optional(),
        hasReport: z.coerce.boolean().optional(),
      }))
      .mutation(async ({ input }) => {
        const { id, ...updates } = input;
        const images = updates.images?.length ? JSON.stringify(updates.images) : undefined;
        const imageUrl = updates.imageUrl || updates.images?.[0];

        await db.updateVehicle(id, {
          ...updates,
          images,
          imageUrl,
        });
        return { success: true };
      }),

    delete: adminProcedure
      .input(z.object({ id: z.number() }))
      .mutation(async ({ input }) => {
        await db.deleteVehicle(input.id);
        return { success: true };
      }),
  }),

  locations: router({
    list: publicProcedure.query(async () => {
      return await db.getLocations();
    }),

    create: adminProcedure
      .input(z.object({
        name: z.string(),
        city: z.string(),
        state: z.string(),
        address: z.string().optional(),
      }))
      .mutation(async ({ input }) => {
        return await db.createLocation(input);
      }),
  }),

  categories: router({
    list: publicProcedure.query(async () => {
      return await db.getCategories();
    }),

    create: adminProcedure
      .input(z.object({
        name: z.string(),
        slug: z.string(),
      }))
      .mutation(async ({ input }) => {
        return await db.createCategory(input);
      }),
  }),

  auctions: router({
    list: publicProcedure
      .input(z.object({
        status: z.enum(["scheduled", "live", "ended"]).optional(),
      }).optional())
      .query(async ({ input }) => {
        return await db.getAuctions(input?.status);
      }),

    create: adminProcedure
      .input(z.object({
        title: z.string(),
        description: z.string().optional(),
        startDate: z.date(),
        endDate: z.date(),
        status: z.enum(["scheduled", "live", "ended"]).default("scheduled"),
      }))
      .mutation(async ({ input }) => {
        return await db.createAuction(input);
      }),
  }),

  bids: router({
    getByVehicle: publicProcedure
      .input(z.object({ vehicleId: z.number() }))
      .query(async ({ input }) => {
        return await db.getBidsByVehicle(input.vehicleId);
      }),

    create: protectedProcedure
      .input(z.object({
        vehicleId: z.number(),
        amount: z.number(),
        bidType: z.enum(["preliminary", "live"]).default("preliminary"),
      }))
      .mutation(async ({ input, ctx }) => {
        return await db.createBid({
          ...input,
          userId: ctx.user.id,
        });
      }),
  }),

  partners: router({
    list: publicProcedure.query(async () => {
      return await db.getPartners();
    }),

    create: adminProcedure
      .input(z.object({
        name: z.string(),
        logoUrl: z.string().optional(),
        displayOrder: z.number().default(0),
      }))
      .mutation(async ({ input }) => {
        return await db.createPartner(input);
      }),
  }),

  favorites: router({
    list: protectedProcedure.query(async ({ ctx }) => {
      return await db.getUserFavorites(ctx.user.id);
    }),

    add: protectedProcedure
      .input(z.object({ vehicleId: z.number() }))
      .mutation(async ({ input, ctx }) => {
        return await db.addFavorite(ctx.user.id, input.vehicleId);
      }),

    remove: protectedProcedure
      .input(z.object({ vehicleId: z.number() }))
      .mutation(async ({ input, ctx }) => {
        await db.removeFavorite(ctx.user.id, input.vehicleId);
        return { success: true };
      }),

    check: protectedProcedure
      .input(z.object({ vehicleId: z.number() }))
      .query(async ({ input, ctx }) => {
        return await db.isFavorite(ctx.user.id, input.vehicleId);
      }),
  }),

  user: router({
    profile: protectedProcedure.query(async ({ ctx }) => {
      return ctx.user;
    }),

    updateProfile: protectedProcedure
      .input(z.object({
        name: z.string().optional(),
        email: z.string().email().optional(),
      }))
      .mutation(async ({ input, ctx }) => {
        await db.updateUserProfile(ctx.user.id, input);
        return { success: true };
      }),

    myBids: protectedProcedure.query(async ({ ctx }) => {
      return await db.getUserBids(ctx.user.id);
    }),
  }),

  admin: router({
    users: router({
      list: adminProcedure.query(async () => {
        return await db.getAllUsers();
      }),
    }),
    bids: router({
      listAll: adminProcedure.query(async () => {
        return await db.getAllBids();
      }),
    }),
  }),
});

export type AppRouter = typeof appRouter;
