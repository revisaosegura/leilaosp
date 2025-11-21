-- Script para popular o banco de dados com dados de exemplo
-- Execute: mysql leilaosp < scripts/seed-database.sql

-- Limpar dados existentes (cuidado em produção!)
DELETE FROM favorites;
DELETE FROM bids;
DELETE FROM vehicles;
DELETE FROM categories;
DELETE FROM locations;
DELETE FROM partners;

-- Inserir Localizações (Pátios)
INSERT INTO locations (name, city, state, address) VALUES
('Pátio São Paulo - Guarulhos', 'Guarulhos', 'SP', 'Av. Santos Dumont, 1234 - Guarulhos/SP'),
('Pátio Campinas', 'Campinas', 'SP', 'Rodovia Anhanguera, km 95 - Campinas/SP'),
('Pátio Rio de Janeiro', 'Rio de Janeiro', 'RJ', 'Av. Brasil, 5000 - Rio de Janeiro/RJ'),
('Pátio Belo Horizonte', 'Belo Horizonte', 'MG', 'Av. Cristiano Machado, 2000 - Belo Horizonte/MG'),
('Pátio Curitiba', 'Curitiba', 'PR', 'BR-116, km 120 - Curitiba/PR');

-- Inserir Categorias
INSERT INTO categories (name, slug) VALUES
('Carros de Passeio', 'carros-passeio'),
('SUVs e Utilitários', 'suvs-utilitarios'),
('Caminhonetes', 'caminhonetes'),
('Motos', 'motos'),
('Veículos Comerciais', 'veiculos-comerciais'),
('Veículos Salvados', 'veiculos-salvados'),
('Veículos Premium', 'veiculos-premium');

-- Inserir Veículos de Exemplo
INSERT INTO vehicles (lotNumber, year, make, model, description, imageUrl, currentBid, buyNowPrice, locationId, categoryId, saleType, status, hasWarranty, hasReport) VALUES
-- Carros de Passeio
('LOT001', 2020, 'Volkswagen', 'Gol 1.0', 'Volkswagen Gol 1.0 2020, cor branca, 45.000 km, único dono, revisões em dia. Veículo em excelente estado de conservação.', 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=800', 15000, 22000, 1, 1, 'auction', 'active', true, true),
('LOT002', 2019, 'Chevrolet', 'Onix Plus 1.0', 'Chevrolet Onix Plus 1.0 Turbo 2019, prata, 38.000 km, completo com ar-condicionado, direção elétrica e central multimídia.', 'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=800', 18000, 25000, 1, 1, 'auction', 'active', true, true),
('LOT003', 2021, 'Fiat', 'Argo 1.3', 'Fiat Argo 1.3 2021, vermelho, 22.000 km, versão Drive com sistema multimídia, sensor de estacionamento.', 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800', 20000, 28000, 2, 1, 'auction', 'active', true, true),
('LOT004', 2018, 'Honda', 'Civic 2.0', 'Honda Civic 2.0 EXL 2018, preto, 55.000 km, top de linha, couro, teto solar, banco elétrico.', 'https://images.unsplash.com/photo-1590362891991-f776e747a588?w=800', 45000, 62000, 1, 1, 'auction', 'active', true, true),
('LOT005', 2020, 'Toyota', 'Corolla 2.0', 'Toyota Corolla 2.0 XEI 2020, prata, 35.000 km, automático, central multimídia, câmera de ré.', 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800', 52000, 72000, 2, 1, 'direct', 'active', true, true),

-- SUVs e Utilitários
('LOT006', 2019, 'Jeep', 'Compass Sport', 'Jeep Compass Sport 2019, branco, 48.000 km, 4x2, automático, completo.', 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=800', 55000, 75000, 3, 2, 'auction', 'active', true, true),
('LOT007', 2021, 'Hyundai', 'Creta 1.6', 'Hyundai Creta 1.6 Attitude 2021, cinza, 28.000 km, automático, central multimídia.', 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=800', 48000, 65000, 3, 2, 'auction', 'active', true, true),
('LOT008', 2020, 'Volkswagen', 'T-Cross 1.0', 'VW T-Cross 1.0 TSI 2020, azul, 32.000 km, turbo, automático, completo.', 'https://images.unsplash.com/photo-1617469767053-d3b523a0b982?w=800', 52000, 70000, 1, 2, 'direct', 'active', true, true),

-- Caminhonetes
('LOT009', 2019, 'Fiat', 'Toro Freedom', 'Fiat Toro Freedom 2019, branca, diesel, 4x4, 62.000 km, cabine dupla.', 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=800', 65000, 88000, 4, 3, 'auction', 'active', true, true),
('LOT010', 2020, 'Toyota', 'Hilux SRV', 'Toyota Hilux SRV 2020, prata, diesel, 4x4, 45.000 km, automática, top de linha.', 'https://images.unsplash.com/photo-1623873503168-5d7a0b0d1f8b?w=800', 95000, 125000, 4, 3, 'auction', 'active', true, true),
('LOT011', 2021, 'Chevrolet', 'S10 LTZ', 'Chevrolet S10 LTZ 2021, preta, diesel, 4x4, 38.000 km, automática, completa.', 'https://images.unsplash.com/photo-1623873503168-5d7a0b0d1f8b?w=800', 88000, 115000, 5, 3, 'direct', 'active', true, true),

-- Motos
('LOT012', 2020, 'Honda', 'CG 160', 'Honda CG 160 Start 2020, vermelha, 15.000 km, partida elétrica, único dono.', 'https://images.unsplash.com/photo-1558981852-426c6c22a060?w=800', 7000, 9500, 1, 4, 'auction', 'active', false, true),
('LOT013', 2021, 'Yamaha', 'Fazer 250', 'Yamaha Fazer 250 2021, azul, 8.000 km, freio ABS, painel digital.', 'https://images.unsplash.com/photo-1609630875171-b1321377ee65?w=800', 12000, 16000, 2, 4, 'auction', 'active', true, true),

-- Veículos Premium
('LOT014', 2019, 'BMW', '320i Sport', 'BMW 320i Sport 2019, preta, 42.000 km, turbo, automática, interior em couro, teto solar.', 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800', 85000, 115000, 1, 7, 'auction', 'active', true, true),
('LOT015', 2020, 'Mercedes-Benz', 'C180', 'Mercedes-Benz C180 2020, branca, 35.000 km, turbo, automática, completa.', 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800', 95000, 130000, 3, 7, 'direct', 'active', true, true),

-- Veículos Salvados (com preços mais baixos)
('LOT016', 2017, 'Ford', 'Ka 1.0', 'Ford Ka 1.0 2017, branco, 78.000 km, pequenos reparos necessários, motor em bom estado.', 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800', 8000, 12000, 2, 6, 'auction', 'active', false, true),
('LOT017', 2016, 'Renault', 'Sandero 1.0', 'Renault Sandero 1.0 2016, prata, 92.000 km, necessita funilaria, mecânica ok.', 'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=800', 6500, 10000, 5, 6, 'auction', 'active', false, false),

-- Veículos Comerciais
('LOT018', 2018, 'Fiat', 'Ducato Cargo', 'Fiat Ducato Cargo 2018, branca, diesel, 85.000 km, furgão, ótima para entregas.', 'https://images.unsplash.com/photo-1527786356703-4b100091cd2c?w=800', 45000, 62000, 4, 5, 'auction', 'active', false, true),
('LOT019', 2019, 'Volkswagen', 'Delivery Express', 'VW Delivery Express 2019, branco, diesel, 68.000 km, baú, ideal para logística.', 'https://images.unsplash.com/photo-1527786356703-4b100091cd2c?w=800', 52000, 70000, 5, 5, 'direct', 'active', false, true),

-- Mais veículos populares
('LOT020', 2020, 'Nissan', 'Kicks 1.6', 'Nissan Kicks 1.6 SV 2020, laranja, 35.000 km, automático, central multimídia.', 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=800', 48000, 65000, 1, 2, 'auction', 'active', true, true);

-- Inserir alguns Parceiros
INSERT INTO partners (name, logoUrl, displayOrder) VALUES
('Banco do Brasil', 'https://via.placeholder.com/200x80/003366/FFFFFF?text=Banco+do+Brasil', 1),
('Caixa Econômica', 'https://via.placeholder.com/200x80/0066CC/FFFFFF?text=Caixa', 2),
('Bradesco', 'https://via.placeholder.com/200x80/CC0000/FFFFFF?text=Bradesco', 3),
('Itaú', 'https://via.placeholder.com/200x80/FF6600/FFFFFF?text=Itau', 4),
('Santander', 'https://via.placeholder.com/200x80/CC0000/FFFFFF?text=Santander', 5);

-- Verificar dados inseridos
SELECT 'Localizações inseridas:' as info, COUNT(*) as total FROM locations
UNION ALL
SELECT 'Categorias inseridas:', COUNT(*) FROM categories
UNION ALL
SELECT 'Veículos inseridos:', COUNT(*) FROM vehicles
UNION ALL
SELECT 'Parceiros inseridos:', COUNT(*) FROM partners;
