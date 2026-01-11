-- Script para importar dados da Copart
-- Execute no Render: psql "postgresql://leilaosp_user:ZBI9see0qaBUUuSFJJwrkzrCXuAwUpsi@dpg-d5hg446mcj7s73b0oou0-a.oregon-postgres.render.com/leilaosp" -f scripts/import_copart_data.sql

-- Limpar dados existentes
TRUNCATE TABLE vehicles, categories, locations, partners RESTART IDENTITY CASCADE;

-- Inserir categorias
INSERT INTO categories (id, name, description) VALUES (1, 'Automóveis', 'Automóveis');
INSERT INTO categories (id, name, description) VALUES (2, 'Caminhões e Rebocadores', 'Caminhões e Rebocadores');
INSERT INTO categories (id, name, description) VALUES (3, 'Motos', 'Motos');
INSERT INTO categories (id, name, description) VALUES (4, 'Outros', 'Outros');
INSERT INTO categories (id, name, description) VALUES (5, 'Picapes Grandes', 'Picapes Grandes');
INSERT INTO categories (id, name, description) VALUES (6, 'Picapes Pequenas', 'Picapes Pequenas');
INSERT INTO categories (id, name, description) VALUES (7, 'SUV Grandes', 'SUV Grandes');
INSERT INTO categories (id, name, description) VALUES (8, 'SUV Pequenos', 'SUV Pequenos');
INSERT INTO categories (id, name, description) VALUES (9, 'Tratores', 'Tratores');
INSERT INTO categories (id, name, description) VALUES (10, 'Utilitários Grandes', 'Utilitários Grandes');
INSERT INTO categories (id, name, description) VALUES (11, 'Utilitários Pequenos', 'Utilitários Pequenos');

-- Inserir localizações
INSERT INTO locations (id, name, address, city, state) VALUES (1, 'BETIM - MG', 'BETIM - MG', 'BETIM', 'MG');
INSERT INTO locations (id, name, address, city, state) VALUES (2, 'CANDEIAS - BA', 'CANDEIAS - BA', 'CANDEIAS', 'BA');
INSERT INTO locations (id, name, address, city, state) VALUES (3, 'CANOAS - RS', 'CANOAS - RS', 'CANOAS', 'RS');
INSERT INTO locations (id, name, address, city, state) VALUES (4, 'CUIABÁ - MT', 'CUIABÁ - MT', 'CUIABÁ', 'MT');
INSERT INTO locations (id, name, address, city, state) VALUES (5, 'CURITIBA - PR', 'CURITIBA - PR', 'CURITIBA', 'PR');
INSERT INTO locations (id, name, address, city, state) VALUES (6, 'EMBÚ DAS ARTES - SP', 'EMBÚ DAS ARTES - SP', 'EMBÚ DAS ARTES', 'SP');
INSERT INTO locations (id, name, address, city, state) VALUES (7, 'EUSÉBIO - CE', 'EUSÉBIO - CE', 'EUSÉBIO', 'CE');
INSERT INTO locations (id, name, address, city, state) VALUES (8, 'GOIÂNIA - GO', 'GOIÂNIA - GO', 'GOIÂNIA', 'GO');
INSERT INTO locations (id, name, address, city, state) VALUES (9, 'ITAQUAQUECETUBA - SP', 'ITAQUAQUECETUBA - SP', 'ITAQUAQUECETUBA', 'SP');
INSERT INTO locations (id, name, address, city, state) VALUES (10, 'LOCAL DO VENDEDOR', 'LOCAL DO VENDEDOR', 'LOCAL DO VENDEDOR', 'SP');
INSERT INTO locations (id, name, address, city, state) VALUES (11, 'OSASCO - SP', 'OSASCO - SP', 'OSASCO', 'SP');
INSERT INTO locations (id, name, address, city, state) VALUES (12, 'PIRAPORA - SP', 'PIRAPORA - SP', 'PIRAPORA', 'SP');
INSERT INTO locations (id, name, address, city, state) VALUES (13, 'RECIFE - PE', 'RECIFE - PE', 'RECIFE', 'PE');
INSERT INTO locations (id, name, address, city, state) VALUES (14, 'RIBEIRÃO PRETO - SP', 'RIBEIRÃO PRETO - SP', 'RIBEIRÃO PRETO', 'SP');
INSERT INTO locations (id, name, address, city, state) VALUES (15, 'VITÓRIA DE SANTO ANTÃO - PE', 'VITÓRIA DE SANTO ANTÃO - PE', 'VITÓRIA DE SANTO ANTÃO', 'PE');

-- Inserir parceiros
INSERT INTO partners (id, name) VALUES (1, 'AZUL COMPANHIA DE SEGUROS GERAIS');
INSERT INTO partners (id, name) VALUES (2, 'COMPANHIA DE LOCACAO DAS AMERICAS');
INSERT INTO partners (id, name) VALUES (3, 'HDI SEGUROS SA  NOVO');
INSERT INTO partners (id, name) VALUES (4, 'LOCALIZA FLEET SA');
INSERT INTO partners (id, name) VALUES (5, 'LOCALIZA RENT A CAR');
INSERT INTO partners (id, name) VALUES (6, 'PARTICULAR/EMPRESA');
INSERT INTO partners (id, name) VALUES (7, 'PORTO SEGURO ADMINISTRAÇÃO DE CONSÓRCIOS S/C LTDA');
INSERT INTO partners (id, name) VALUES (8, 'PORTO SEGURO CIA DE SEGUROS GERAIS');
INSERT INTO partners (id, name) VALUES (9, 'PREVISUL');
INSERT INTO partners (id, name) VALUES (10, 'SUHAI SEGURADORA');
INSERT INTO partners (id, name) VALUES (11, 'TOKIO MARINE SEGURADORA S A  VEICULOS TMS NOVO');
INSERT INTO partners (id, name) VALUES (12, 'YELUM SEGUROS S.A');
INSERT INTO partners (id, name) VALUES (13, 'YOUSE CAIXA SEGUROS');

-- Inserir veículos
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '989432', 2005, 'VOLKSWAGEN', 'FOX', '9BWKB05Z954094623', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    26679.0, 536.0, 32014.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1016337', 2002, 'RENAULT', 'CLIO SEDAN', '93YLB06152J291643', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    9229.0, 530.0, 11074.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Motor dá partida e engrena. Grande Monta. Condição: Recortado.', 'Motor dá partida e engrena', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+CLIO SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039699', 2018, 'HONDA', 'PCX', '9C2KF2200JR017531', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    13713.0, 0, 16455.6, false,
    NOW() + INTERVAL '7 days', 3, 9, 1,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+PCX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046304', 2012, 'CHEVROLET', 'AGILE', '8AGCN48X0CR149495', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    31545.0, 413.0, 37854.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+AGILE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049049', 2016, 'HONDA', 'FIT', '93HGK5860GZ210292', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 434.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1029903', 2024, 'CITROEN', 'C3 AIRCROSS', '935CNFC51RB515986', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    102807.0, 560.0, 123368.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Motor dá partida e engrena. Grande Monta. Condição: Recortado.', 'Motor dá partida e engrena', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+C3 AIRCROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '880389', 2011, 'FORD', 'FIESTA SEDAN', '9BFZF54P2B8132634', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    30330.0, 515.0, 36396.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '895976', 2012, 'CHEVROLET', 'COBALT', '9BGJB69X0CB298149', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    32755.0, 479.0, 39306.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+COBALT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '999360', 2019, 'RENAULT', 'LOGAN', '93Y4SRF84KJ746241', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    36186.0, 431.0, 43423.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+LOGAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1040938', 2016, 'HONDA', 'HR-V', '93HRV2850GZ131745', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    83224.0, 459.0, 99868.8, false,
    NOW() + INTERVAL '7 days', 8, 9, 1,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+HR-V']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1038933', 2013, 'CHEVROLET', 'ONIX', '9BGKS48B0DG267352', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    40019.0, 569.0, 48022.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1032468', 2006, 'VOLKSWAGEN', 'FOX', '9BWKB05Z464156477', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    23650.0, 589.0, 28380.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'QUEIMADO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'QUEIMADO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '906546', 2013, 'FIAT', 'PALIO', '9BD196271D2069100', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    32555.0, 498.0, 39066.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PALIO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041729', 2018, 'CHERY', 'QQ', '98RDB12B1JA004029', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 424.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHERY+QQ']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041762', 2008, 'CHEVROLET', 'MERIVA', '9BGXL75G08C189448', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    25442.0, 426.0, 30530.399999999998, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+MERIVA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '981281', 2005, 'FORD', 'FIESTA', '9BFZF10B758298042', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    14958.0, 430.0, 17949.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046961', 2014, 'HONDA', 'CITY', '93HGM2620EZ211638', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    55075.0, 471.0, 66090.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 1,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CITY']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1035322', 2017, 'CITROEN', 'AIRCROSS', '935SUNFN2HB520365', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    50899.0, 700.0, 61078.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+AIRCROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051639', 2008, 'HONDA', 'FIT', '93HGD18408Z104880', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    33748.0, 441.0, 40497.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1026970', 2024, 'VOLKSWAGEN', 'T-CROSS', '9BWBH6BF4R4087922', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    104151.0, 559.0, 124981.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+T-CROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1000302', 2021, 'FIAT', 'DUCATO FURGAO', '3c6dfvdk0me519899', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Grandes', 'N/A',
    174183.0, 0, 209019.6, false,
    NOW() + INTERVAL '7 days', 10, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+DUCATO FURGAO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1011177', 2020, 'HONDA', 'FIT', '93HGK5720LZ111667', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    75014.0, 484.0, 90016.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Grande Monta. Condição: Recortado.', 'Motor dá partida e engrena', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1031264', 2014, 'BMW', 'SERIE 3', 'WBA3A9108EF491738', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    165817.0, 0, 198980.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'QUEIMADO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'QUEIMADO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BMW+SERIE 3']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1019383', 2013, 'LAND ROVER', 'RANGE ROVER EVOQUE', 'SALVA2BG0DH785595', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    100023.0, 474.0, 120027.59999999999, false,
    NOW() + INTERVAL '7 days', 7, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=LAND ROVER+RANGE ROVER EVOQUE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1033963', 2020, 'FORD', 'KA', '9BFZH55L3L8421190', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    48854.0, 436.0, 58624.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1040360', 2015, 'HONDA', 'FIT', '93HGK5860FZ235899', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 457.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1042539', 1991, 'FIAT', 'UNO', '9BD146000M3768991', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    7033.0, 423.0, 8439.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1040103', 2019, 'MERCEDES BENZ', 'CLASSE A SEDAN', 'WDD3G8HW2KW030400', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    151235.0, 421.0, 181482.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+CLASSE A SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1042877', 2023, 'CHEVROLET', 'ONIX', '9BGEA48A0PG306309', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    67642.0, 409.0, 81170.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051414', 2026, 'CAOA CHERY', 'TIGGO 8', '95PFEM61DTB037682', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    183468.0, 422.0, 220161.6, false,
    NOW() + INTERVAL '7 days', 7, 9, 8,
    'QUEIMADO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'QUEIMADO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CAOA CHERY+TIGGO 8']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046200', 2017, 'NISSAN', 'VERSA', '94DBCAN17HB107735', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    57869.0, 588.0, 69442.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+VERSA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053095', 2015, 'HONDA', 'LEAD 110', '9C2JF2500FR504398', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    9110.0, 0, 10932.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+LEAD 110']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '825340', 2014, 'BMW', 'F 800', '95V0B2204EZ490869', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    39349.0, 0, 47218.799999999996, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BMW+F 800']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1042524', 2024, 'FIAT', 'MOBI', '9BD341ATZRY933734', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    61955.0, 415.0, 74346.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+MOBI']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046312', 2012, 'HYUNDAI', 'I30', 'KMHDC51EBCU369765', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    45863.0, 428.0, 55035.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+I30']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '932909', 2022, 'YAMAHA', 'NMAX', '9C6SG5910N0027444', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    18169.0, 0, 21802.8, false,
    NOW() + INTERVAL '7 days', 3, 9, 7,
    'FINANCIAMENTO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'FINANCIAMENTO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+NMAX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041586', 2022, 'RENAULT', 'LOGAN', '93y4srz85nj950252', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    56737.0, 551.0, 68084.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+LOGAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049270', 2022, 'PEUGEOT', '208', '8ADUWNFX2NG549397', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    70969.0, 567.0, 85162.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=PEUGEOT+208']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '257776', 1999, 'FIAT', 'MAREA WEEKEND', '9BD185715X7015326', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    14070.0, 0, 16884.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Grande Monta. Condição: Recortado.', 'Motor dá partida e engrena', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+MAREA WEEKEND']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '995209', 2024, 'VOLKSWAGEN', 'CONSTELLATION', '9536B8TD7RR071038', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    441025.0, 0, 529230.0, false,
    NOW() + INTERVAL '7 days', 2, 9, 8,
    'QUEIMADO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'QUEIMADO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+CONSTELLATION']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1035072', 2014, 'MINI', 'COOPER', 'WMWXM5109ET725310', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    73824.0, 529.0, 88588.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MINI+COOPER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046878', 2007, 'VOLKSWAGEN', 'FOX', '9BWKB05Z774046539', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 477.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045918', 2011, 'SUBARU', 'FORESTER', 'JF1SHJLS5BG231676', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    42383.0, 483.0, 50859.6, false,
    NOW() + INTERVAL '7 days', 8, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=SUBARU+FORESTER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '959710', 2012, 'VOLKSWAGEN', 'CONSTELLATION', '953658246CR240854', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    222507.0, 0, 267008.39999999997, false,
    NOW() + INTERVAL '7 days', 2, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+CONSTELLATION']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '760348', 1995, 'FIAT', 'UNO', '9BD146000R5337518', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    8758.0, 432.0, 10509.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'ROUBO/FURTO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'ROUBO/FURTO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044226', 2009, 'CHEVROLET', 'TRACKER', '8AG116DJ09R701584', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    43472.0, 439.0, 52166.4, false,
    NOW() + INTERVAL '7 days', 8, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+TRACKER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045623', 2022, 'FIAT', 'MOBI', '9BD341ACXNY781005', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    49709.0, 533.0, 59650.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+MOBI']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046493', 2023, 'REB', 'Reboque', '9A9VPRCZ2PCDD9095', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Outros', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 4, 9, 8,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=REB+Reboque']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039704', 2019, 'FIAT', 'FIORINO FURGAO', '9BD2651JHK9127028', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Pequenos', 'N/A',
    63867.0, 584.0, 76640.4, false,
    NOW() + INTERVAL '7 days', 11, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+FIORINO FURGAO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047419', 2011, 'CHEVROLET', 'ASTRA', '9BGTR48C0BB154784', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    37269.0, 461.0, 44722.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ASTRA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1040127', 2002, 'FIAT', 'SIENA', '9BD17201223010616', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    14231.0, 557.0, 17077.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Grande Monta. Condição: Recortado.', 'Motor dá partida e engrena', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+SIENA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1036983', 2017, 'PEUGEOT', '208', '936CLNFN2HB021904', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    55558.0, 585.0, 66669.59999999999, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=PEUGEOT+208']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1027348', 2021, 'FIAT', 'FIORINO FURGAO', '9BD2651MHM9187476', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Pequenos', 'N/A',
    74200.0, 561.0, 89040.0, false,
    NOW() + INTERVAL '7 days', 11, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+FIORINO FURGAO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1024328', 2009, 'VOLKSWAGEN', 'JETTA', '3VWRE61K09M071265', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    41020.0, 463.0, 49224.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+JETTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '917804', 2014, 'HONDA', 'FIT', '93HGE8890EZ102064', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 612.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'ROUBO/FURTO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'ROUBO/FURTO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1040725', 2012, 'MERCEDES BENZ', 'CLASSE E', 'WDDHF5KW1CA549193', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    110801.0, 549.0, 132961.19999999998, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+CLASSE E']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1040115', 2003, 'VOLKSWAGEN', 'SAVEIRO', '9BWEB05X93P046143', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    25446.0, 446.0, 30535.199999999997, false,
    NOW() + INTERVAL '7 days', 6, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Grande Monta. Condição: Recortado.', 'Motor dá partida e engrena', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+SAVEIRO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1020298', 2013, 'CHEVROLET', 'AGILE', '8AGCN48X0DR169477', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    35825.0, 488.0, 42990.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+AGILE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056995', 2017, 'MERCEDES BENZ', 'CLASSE C COUPE', 'WDDWJ6EW0HF465061', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    265850.0, 0, 319020.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+CLASSE C COUPE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1030996', 2014, 'VOLKSWAGEN', 'FOX', '9BWAB45Z9E4159277', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    40581.0, 539.0, 48697.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045861', 2014, 'FIAT', 'UNO', '9BD195152E0494216', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    31869.0, 558.0, 38242.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045379', 2015, 'FORD', 'FOCUS', '8AFSZZFHCFJ284909', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    52868.0, 590.0, 63441.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FOCUS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046904', 2017, 'SUBARU', 'FORESTER', 'JF1SJ5LC5HG298994', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    94613.0, 604.0, 113535.59999999999, false,
    NOW() + INTERVAL '7 days', 8, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=SUBARU+FORESTER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050335', 2020, 'HONDA', 'CB 250 F', '9C2MC4410LR005056', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'ROUBO/FURTO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CB 250 F']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046323', 2024, 'YAMAHA', 'XMAX', '9C6SG6210R0021750', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    30560.0, 0, 36672.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+XMAX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046850', 2012, 'CITROEN', 'C3', '935FCKFVYCB591065', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 519.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+C3']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044690', 2015, 'FIAT', 'PALIO', '9BD17122ZF7541783', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    30847.0, 495.0, 37016.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PALIO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049041', 2008, 'CHEVROLET', 'CORSA', '9BGXH68808C158812', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    24034.0, 472.0, 28840.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CORSA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049179', 2017, 'MERCEDES BENZ', 'CLASSE C', '9BMWF4CW9HM004115', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    129105.0, 497.0, 154926.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+CLASSE C']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048302', 2006, 'CHEVROLET', 'VECTRA', '9BGAC69M06B175621', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    30581.0, 489.0, 36697.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+VECTRA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049954', 2019, 'MERCEDES BENZ', 'GLC', 'WDC0G4GW6KF659594', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    183118.0, 0, 219741.6, false,
    NOW() + INTERVAL '7 days', 7, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+GLC']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052082', 2014, 'CHEVROLET', 'TRACKER', '3GNCJ8CW1EL150354', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    65321.0, 547.0, 78385.2, false,
    NOW() + INTERVAL '7 days', 8, 9, 8,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+TRACKER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049572', 2023, 'PEUGEOT', '208', '8ADUEFC23PG528708', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    72512.0, 618.0, 87014.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=PEUGEOT+208']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050124', 2012, 'NISSAN', 'LIVINA', '94DTAFL10CJ865435', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    28436.0, 507.0, 34123.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+LIVINA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048288', 2013, 'HYUNDAI', 'VELOSTER', 'KMHTC61CBDU108331', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    61466.0, 537.0, 73759.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+VELOSTER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049988', 2025, 'MERCEDES BENZ', 'CLASSE CLA', 'W1K5J8HW5SN553474', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    285935.0, 571.0, 343122.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+CLASSE CLA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050323', 2010, 'HONDA', 'CR-V', '3CZRE2870AG508081', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    55383.0, 458.0, 66459.59999999999, false,
    NOW() + INTERVAL '7 days', 8, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CR-V']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049878', 2020, 'TRIUMPH', 'SPEED TWIN', '97ND54HFXLM974317', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    44439.0, 0, 53326.799999999996, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TRIUMPH+SPEED TWIN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046921', 2014, 'CHEVROLET', 'SPIN', '9BGJB75Z0EB124646', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    43515.0, 574.0, 52218.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+SPIN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049203', 2014, 'NISSAN', 'VERSA', '3N1CN7AD3EK478022', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    39798.0, 0, 47757.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+VERSA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053600', 2020, 'RENAULT', 'KWID', '93YRBB00XLJ288069', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    38464.0, 513.0, 46156.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+KWID']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049654', 2015, 'MERCEDES BENZ', 'CLASSE A', 'WDDBF4EW7FJ365005', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    115819.0, 0, 138982.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Pequena Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+CLASSE A']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049016', 2010, 'CHEVROLET', 'CORSA', '9BGXH68P0AC199289', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    28054.0, 527.0, 33664.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CORSA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049957', 2008, 'FORD', 'FIESTA', '9BFZF10A088153212', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    20605.0, 548.0, 24726.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050327', 2011, 'CITROEN', 'C4 PICASSO', 'VF7UDRFJWBJ509942', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    28914.0, 480.0, 34696.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+C4 PICASSO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052128', 2012, 'KIA', 'PICANTO', 'KNABX514BCT242885', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 462.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=KIA+PICANTO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049028', 2017, 'HYUNDAI', 'TUCSON', '95PJN81EPHB103581', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    64146.0, 0, 76975.2, false,
    NOW() + INTERVAL '7 days', 8, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+TUCSON']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052048', 2001, 'TOYOTA', 'COROLLA', '9BR53AEB215524568', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    23474.0, 544.0, 28168.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+COROLLA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051648', 2024, 'HONDA', 'CITY', '93HGN2650RK104997', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    110997.0, 503.0, 133196.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CITY']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053467', 2011, 'VOLKSWAGEN', 'SPACEFOX', '8AWPB45Z4BA510073', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    36149.0, 0, 43378.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+SPACEFOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051496', 2019, 'NISSAN', 'MARCH', '94DFCUK13KB102438', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    55693.0, 464.0, 66831.59999999999, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+MARCH']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049031', 2019, 'HONDA', 'FIT', '93HGK5830KZ106739', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    78589.0, 614.0, 94306.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049268', 2014, 'RENAULT', 'SANDERO', '93YBSR6RHEJ764531', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    30852.0, 0, 37022.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+SANDERO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052189', 2018, 'BMW', 'X1', '98MHS7002J4A60462', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    0, 531.0, 0.0, false,
    NOW() + INTERVAL '7 days', 8, 9, 8,
    'COLISÃO. Motor dá partida. Pequena Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BMW+X1']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051145', 2015, 'VOLKSWAGEN', 'FOX', '9BWAB45Z7F4060863', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    42499.0, 556.0, 50998.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052077', 2022, 'NISSAN', 'KICKS', '94DFCAP15NB157735', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    101075.0, 452.0, 121290.0, false,
    NOW() + INTERVAL '7 days', 8, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+KICKS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '979007', 2011, 'PEUGEOT', '207', '8AD2MKFWXBG003068', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    20578.0, 532.0, 24693.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=PEUGEOT+207']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1034575', 2004, 'CHEVROLET', 'CELTA', '9BGRD48J04G148016', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    17515.0, 0, 21018.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CELTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1031888', 2025, 'RENAULT', 'KWID', '93YRBB008SJ151937', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    62994.0, 0, 75592.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+KWID']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1037301', 2013, 'VOLKSWAGEN', 'KOMBI', '9BWMF07X5DP016328', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Grandes', 'N/A',
    47966.0, 0, 57559.2, false,
    NOW() + INTERVAL '7 days', 10, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+KOMBI']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049231', 2021, 'HONDA', 'ELITE', '9C2JF8500MR007864', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    12103.0, 0, 14523.6, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+ELITE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051741', 2015, 'VOLKSWAGEN', 'SAVEIRO CD', '9BWJL45U4FP049254', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    68472.0, 580.0, 82166.4, false,
    NOW() + INTERVAL '7 days', 6, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+SAVEIRO CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044881', 2017, 'HONDA', 'BIZ', '9C2JC4830HR002192', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+BIZ']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052132', 2024, 'DAFRA', 'CRUISYM', '95V3X1L5PRM000646', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    29280.0, 0, 35136.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=DAFRA+CRUISYM']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050368', 2023, 'KAWASAKI', 'VULCAN S', '96PENCD12PFS00927', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    43202.0, 0, 51842.4, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=KAWASAKI+VULCAN S']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052520', 2008, 'RENAULT', 'CLIO SEDAN', '8A1LB8E258L889410', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    21077.0, 542.0, 25292.399999999998, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+CLIO SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051524', 2008, 'HONDA', 'FIT', '93HGE57408Z207049', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051205', 2014, 'LAND ROVER', 'RANGE ROVER EVOQUE', 'SALVA2BG4EH870084', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    109054.0, 526.0, 130864.79999999999, false,
    NOW() + INTERVAL '7 days', 7, 9, 8,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=LAND ROVER+RANGE ROVER EVOQUE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049215', 2019, 'VOLKSWAGEN', 'POLO', '9BWAL5BZ2KP606128', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    63730.0, 514.0, 76476.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+POLO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053364', 2008, 'HONDA', 'FIT', '93HGE57408Z211520', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 481.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044078', 2025, 'YAMAHA', 'FZ25 FAZER', '9C6RG5040S0010111', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    25197.0, 0, 30236.399999999998, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+FZ25 FAZER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049880', 2024, 'DAFRA', 'NH', '95VZB1G5PRM000933', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    17175.0, 0, 20610.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 8,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=DAFRA+NH']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051552', 2022, 'TOYOTA', 'COROLLA CROSS', '9BRKYAAG0N0614680', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    139886.0, 0, 167863.19999999998, false,
    NOW() + INTERVAL '7 days', 8, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+COROLLA CROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1011791', 2021, 'HYUNDAI', 'IX35', '95PJV81DBMB069609', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    96902.0, 465.0, 116282.4, false,
    NOW() + INTERVAL '7 days', 7, 9, 8,
    'COLISÃO. Motor dá partida. Pequena Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+IX35']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1031164', 2019, 'CHEVROLET', 'EQUINOX', '3GNAX9EXXKS549850', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    121652.0, 543.0, 145982.4, false,
    NOW() + INTERVAL '7 days', 7, 9, 8,
    'COLISÃO. Desconhecido. Média Monta. Condição: Remarcado.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+EQUINOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1020198', 2015, 'FORD', 'KA', '9BFZH55L0F8236986', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    34345.0, 608.0, 41214.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1027349', 2016, 'NISSAN', 'VERSA', '94DBCAN17GB105622', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    49358.0, 0, 59229.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 8,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+VERSA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057003', 2024, 'FIAT', 'FIORINO FURGAO', '9BD2651PAR9234931', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Pequenos', 'N/A',
    89612.0, 0, 107534.4, false,
    NOW() + INTERVAL '7 days', 11, 9, 4,
    'COLISÃO. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+FIORINO FURGAO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049540', 2025, 'VOLKSWAGEN', 'T-CROSS', '9BWBH6BF7S4042799', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    129317.0, 0, 155180.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 5,
    'COLISÃO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'COLISÃO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+T-CROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053033', 2025, 'FIAT', 'STRADA', '9BD281AJHSYG03633', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    91674.0, 0, 110008.8, false,
    NOW() + INTERVAL '7 days', 6, 9, 5,
    'COLISÃO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'COLISÃO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+STRADA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055492', 2025, 'VOLKSWAGEN', 'T-CROSS', '9BWBJ6BF5S4052168', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    156950.0, 0, 188340.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 4,
    'COLISÃO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'COLISÃO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+T-CROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056097', 2025, 'HYUNDAI', 'HB20S', '9BHCP41AASP655361', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    80118.0, 0, 96141.59999999999, false,
    NOW() + INTERVAL '7 days', 1, 12, 5,
    'COLISÃO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'COLISÃO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20S']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051479', 2025, 'VOLKSWAGEN', 'T-CROSS', '9BWBH6BF1S4045620', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    129317.0, 0, 155180.4, false,
    NOW() + INTERVAL '7 days', 1, 12, 5,
    'COLISÃO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'COLISÃO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+T-CROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053936', 2025, 'FIAT', 'STRADA', '9BD281AJHSYG31384', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    91674.0, 0, 110008.8, false,
    NOW() + INTERVAL '7 days', 6, 12, 5,
    'COLISÃO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'COLISÃO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+STRADA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057052', 2023, 'FORD', 'RANGER', '8AFAR21RXPJ286567', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    156529.0, 0, 187834.8, false,
    NOW() + INTERVAL '7 days', 5, 12, 2,
    'ROUBO/FURTO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+RANGER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057612', 2025, 'VOLKSWAGEN', 'T-CROSS', '9BWBH6BF6S4037285', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    129317.0, 0, 155180.4, false,
    NOW() + INTERVAL '7 days', 1, 12, 5,
    'COLISÃO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'COLISÃO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+T-CROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057568', 2025, 'FIAT', 'ARGO', '9BD358ATGSYN99770', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    74828.0, 0, 89793.59999999999, false,
    NOW() + INTERVAL '7 days', 1, 12, 5,
    'COLISÃO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'COLISÃO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+ARGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057524', 2025, 'FIAT', 'ARGO', '9BD358ATGSYN98900', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    74828.0, 0, 89793.59999999999, false,
    NOW() + INTERVAL '7 days', 1, 12, 5,
    'COLISÃO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'COLISÃO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+ARGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041970', 2015, 'CHEVROLET', 'ONIX', '9BGKT48L0FG215709', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    55071.0, 478.0, 66085.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 9,
    'FINANCIAMENTO. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'FINANCIAMENTO - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '946775', 2023, 'YAMAHA', 'FZ15', '9C6RG7710P0015271', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    18606.0, 0, 22327.2, false,
    NOW() + INTERVAL '7 days', 3, 9, 10,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+FZ15']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '960223', 2024, 'HONDA', 'XRE SAHARA 300', '9C2ND1720RR005340', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    30697.0, 0, 36836.4, false,
    NOW() + INTERVAL '7 days', 3, 9, 10,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+XRE SAHARA 300']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '990907', 2024, 'YAMAHA', 'YBR 150 FACTOR', '9C6RG3160R0152490', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 10,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+YBR 150 FACTOR']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '992612', 2008, 'HONDA', 'CBX 250', '9C2MC35008R114917', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    9339.0, 0, 11206.8, false,
    NOW() + INTERVAL '7 days', 3, 9, 10,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CBX 250']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048363', 2025, 'YAMAHA', 'MT-03', '9C6RH1150S0040929', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    31840.0, 0, 38208.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 10,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+MT-03']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048428', 2010, 'HONDA', 'CB 600 F', '9C2PC4210AR500028', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    35147.0, 0, 42176.4, false,
    NOW() + INTERVAL '7 days', 3, 9, 10,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CB 600 F']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051740', 2021, 'HONDA', 'ELITE', '9C2JF8500MR002924', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    12103.0, 0, 14523.6, false,
    NOW() + INTERVAL '7 days', 3, 9, 10,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+ELITE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056088', 2017, 'YAMAHA', 'XTZ 150 CROSSER', '9C6DG2510H0041651', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 10,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+XTZ 150 CROSSER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053521', 2019, 'HONDA', 'BIZ', '9C2JC4830KR006294', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 10,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+BIZ']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047227', 2000, 'CHEVROLET', 'CORSA', '9BGSC68Z0YC129528', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    11718.0, 0, 14061.6, false,
    NOW() + INTERVAL '7 days', 1, 12, 10,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CORSA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '967553', 2017, 'CHEVROLET', 'PRISMA', '9BGKS69V0HG182522', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    56549.0, 460.0, 67858.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 13,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+PRISMA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '868816', 2020, 'FORD', 'KA SEDAN', '9BFZH54SXL8433491', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    49547.0, 484.0, 59456.399999999994, false,
    NOW() + INTERVAL '7 days', 1, 9, 13,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1024368', 2015, 'VOLKSWAGEN', 'GOL', '9BWAA45UXFP197463', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    37347.0, 546.0, 44816.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 13,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045246', 2006, 'CHEVROLET', 'CORSA SEDAN', '9BGXH19606C113113', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 14, 13,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CORSA SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039819', 2022, 'YAMAHA', 'FZ25 FAZER', '9C6RG5020N0023282', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    20756.0, 0, 24907.2, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+FZ25 FAZER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1019386', 2014, 'FORD', 'FIESTA', '9BFZF55A4E8023607', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    30658.0, 0, 36789.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'ROUBO/FURTO. Desconhecido. Média Monta. Condição: Remarcado.', 'Desconhecido', 'ROUBO/FURTO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050165', 2024, 'TOYOTA', 'COROLLA CROSS', '9BRK3AAG2R0108417', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    152737.0, 573.0, 183284.4, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+COROLLA CROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1042046', 2023, 'MITSUBISHI', 'L200 TRITON', '93XHYKL1TPCN56596', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    199965.0, 605.0, 239958.0, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'ROUBO/FURTO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MITSUBISHI+L200 TRITON']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045708', 2023, 'PEUGEOT', '208', '8ADUEFC23PG576581', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    59835.0, 451.0, 71802.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=PEUGEOT+208']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '953687', 2020, 'HONDA', 'CB 500 X', '9C2PC4920LR000681', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    38573.0, 0, 46287.6, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Avariado.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CB 500 X']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049705', 2020, 'RENAULT', 'LOGAN', '93Y4SRZ85LJ237692', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    41202.0, 443.0, 49442.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+LOGAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1043187', 2019, 'FIAT', 'CRONOS', '8AP359A13KU060160', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    65117.0, 453.0, 78140.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+CRONOS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045790', 2019, 'CHEVROLET', 'MONTANA', '9BGCA8030KB127641', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Pequenos', 'N/A',
    51598.0, 445.0, 61917.6, false,
    NOW() + INTERVAL '7 days', 11, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+MONTANA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1040110', 2017, 'CHEVROLET', 'ONIX', '9BGKT48V0HG216780', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    62397.0, 444.0, 74876.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044267', 2016, 'FIAT', 'GRAND SIENA', '9BD19716TG3306347', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    39651.0, 437.0, 47581.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+GRAND SIENA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041546', 2016, 'CHEVROLET', 'MONTANA', '9BGCA8030GB106672', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Pequenos', 'N/A',
    46092.0, 447.0, 55310.4, false,
    NOW() + INTERVAL '7 days', 11, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+MONTANA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048053', 2017, 'NISSAN', 'MARCH', '94DFCUK13HB100749', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    43639.0, 467.0, 52366.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+MARCH']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045429', 2016, 'FIAT', 'WEEKEND', '9BD37417SG5091516', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    43093.0, 524.0, 51711.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+WEEKEND']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049993', 2016, 'NISSAN', 'VERSA', '94DBFAN17GB100989', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    36974.0, 0, 44368.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+VERSA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039258', 2015, 'MERCEDES BENZ', 'GLA', 'WDCTG4DW2FJ108633', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    97381.0, 615.0, 116857.2, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'COLISÃO. Motor dá partida. Pequena Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+GLA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1014883', 2016, 'PEUGEOT', '2008', '936CMNFN2GB019929', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    53503.0, 448.0, 64203.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Remarcado.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=PEUGEOT+2008']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1031506', 2016, 'VOLKSWAGEN', 'VOYAGE', '9BWDB45UXGT059635', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    43070.0, 442.0, 51684.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+VOYAGE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049316', 2015, 'FIAT', 'PUNTO', '9BD11818LF1310365', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    41287.0, 554.0, 49544.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PUNTO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045927', 2013, 'CHEVROLET', 'CLASSIC', '9BGSU19F0DC102408', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    27800.0, 575.0, 33360.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CLASSIC']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048663', 2013, 'TOYOTA', 'HILUX CD', '8AJFY22G1D8007053', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    118600.0, 0, 142320.0, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+HILUX CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050564', 2013, 'CHEVROLET', 'SONIC', '3G1J86CDXDS606296', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    39008.0, 449.0, 46809.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+SONIC']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051838', 2012, 'VOLKSWAGEN', 'AMAROK', 'WV1DB42H2CA047749', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    76128.0, 609.0, 91353.59999999999, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+AMAROK']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1042757', 2013, 'CHEVROLET', 'S10 CABINE DUPLA', '9BG148FH0DC499355', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    98018.0, 0, 117621.59999999999, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+S10 CABINE DUPLA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1043148', 2013, 'NISSAN', 'MARCH', '3N1DK3CD7DL234224', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    32415.0, 591.0, 38898.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+MARCH']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1033148', 2013, 'VOLKSWAGEN', 'FOX', '9BWAA05Z9D4098071', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    34447.0, 173.0, 41336.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047290', 2013, 'CHEVROLET', 'AGILE', '8AGCN48X0DR105949', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    35825.0, 0, 42990.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+AGILE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047353', 2008, 'VOLKSWAGEN', 'BORA', '3VWSH49M38M667908', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    32605.0, 0, 39126.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+BORA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1006433', 2010, 'FIAT', 'UNO', '9BD15822AA6260860', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    25099.0, 491.0, 30118.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049686', 2009, 'NISSAN', 'SENTRA', '3N1AB61E79L602828', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    30108.0, 563.0, 36129.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+SENTRA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1014882', 2009, 'CHEVROLET', 'CORSA SEDAN', '9BGXM19P09B235408', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    28174.0, 0, 33808.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CORSA SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1038853', 2009, 'VOLKSWAGEN', 'GOL', '9BWAB05UX9P041871', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    26708.0, 568.0, 32049.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048395', 2007, 'CITROEN', 'C3', '935FCKFV87B505855', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 564.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+C3']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051397', 2007, 'HONDA', 'FIT', '93HGD38807Z106870', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    33002.0, 576.0, 39602.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046772', 2008, 'FIAT', 'UNO', '9BD15822786081643', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 535.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1030749', 2009, 'FORD', 'KA', '9BFZK53A89B102642', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    18285.0, 599.0, 21942.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Remarcado.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045745', 2009, 'MITSUBISHI', 'PAJERO FULL', 'JMYLYV97W9JA00156', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    74782.0, 617.0, 89738.4, false,
    NOW() + INTERVAL '7 days', 7, 9, 11,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MITSUBISHI+PAJERO FULL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1035618', 2010, 'CITROEN', 'C3', '935FCKFVYAB531163', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 538.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+C3']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046765', 2011, 'VOLKSWAGEN', 'POLO', '9BWAB09N5BP020581', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 611.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+POLO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048256', 2011, 'CHEVROLET', 'PRISMA', '9BGRM69X0BG219034', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 578.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+PRISMA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1019049', 2012, 'KIA', 'SOUL', 'KNAJT814BC7321480', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 552.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=KIA+SOUL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050167', 2012, 'HARLEY-DAVIDSON', 'VRSC', '9321HHHJ3CD806771', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    62923.0, 0, 75507.59999999999, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'ROUBO/FURTO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HARLEY-DAVIDSON+VRSC']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1033055', 2012, 'FORD', 'RANGER CD', '8AFDR12AXCJ488125', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    65754.0, 616.0, 78904.8, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+RANGER CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050519', 2012, 'RENAULT', 'MEGANE GRAND TOUR', '93YKM263HCJ923310', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    33006.0, 0, 39607.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+MEGANE GRAND TOUR']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049805', 2013, 'FIAT', 'FREEMONT', '3C4PFABB7DT624291', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    50862.0, 621.0, 61034.399999999994, false,
    NOW() + INTERVAL '7 days', 7, 9, 11,
    'QUEIMADO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'QUEIMADO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+FREEMONT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045844', 2014, 'KIA', 'CERATO', 'KNAFZ414BE5098296', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    60271.0, 496.0, 72325.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida. Pequena Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=KIA+CERATO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050593', 2013, 'FIAT', 'STRADA', '9BD27808RD7568038', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    39861.0, 450.0, 47833.2, false,
    NOW() + INTERVAL '7 days', 6, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+STRADA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046700', 2014, 'RENAULT', 'DUSTER', '93YHSR2LAEJ777561', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    49853.0, 586.0, 59823.6, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+DUSTER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050554', 2014, 'BMW', 'SERIE 3', 'WBA3B1103EK092192', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    88847.0, 0, 106616.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BMW+SERIE 3']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053308', 2014, 'KIA', 'CERATO', 'KNAFZ414BE5101027', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    60271.0, 504.0, 72325.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=KIA+CERATO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '998003', 2015, 'FORD', 'FIESTA', '9BFZD55P4FB810068', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    41463.0, 455.0, 49755.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052367', 2015, 'RENAULT', 'SANDERO', '93Y5SRD6GFJ514003', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    40974.0, 510.0, 49168.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+SANDERO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046206', 2015, 'FORD', 'FIESTA', '9BFZD55P2FB757841', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    46314.0, 506.0, 55576.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050484', 2015, 'CITROEN', 'C4 LOUNGE', '8BCND5GVUFG515271', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    47252.0, 0, 56702.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+C4 LOUNGE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051956', 2015, 'CHEVROLET', 'COBALT', '9BGJC69Z0FB155837', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    44601.0, 473.0, 53521.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+COBALT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048345', 2016, 'HONDA', 'CG 160', '9C2KC2200GR044181', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    12807.0, 0, 15368.4, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CG 160']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049767', 2017, 'FORD', 'ECOSPORT', '9BFZB55P6H8630001', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    58622.0, 0, 70346.4, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+ECOSPORT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051348', 2017, 'NISSAN', 'KICKS', '3N8CP5HEXHL468861', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    78283.0, 600.0, 93939.59999999999, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+KICKS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052416', 2017, 'FORD', 'KA', '9BFZH55L7H8445855', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    37622.0, 598.0, 45146.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1005195', 2019, 'HONDA', 'PCX', '9C2KF3400KR102283', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    15264.0, 0, 18316.8, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+PCX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047292', 2018, 'FIAT', 'STRADA CD', '9BD57834FJY247237', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    67537.0, 0, 81044.4, false,
    NOW() + INTERVAL '7 days', 6, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+STRADA CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050159', 2019, 'HONDA', 'CG 160', '9C2KC2200KR071041', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    13792.0, 0, 16550.399999999998, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CG 160']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048801', 2022, 'YAMAHA', 'FZ25 FAZER', '9C6RG5020N0024293', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    20756.0, 0, 24907.2, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+FZ25 FAZER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045871', 2022, 'HONDA', 'PCX', '9C2KF3470NR005085', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    17407.0, 0, 20888.399999999998, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+PCX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039845', 2024, 'FIAT', 'TORO', '9882261SERKF76853', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    139285.0, 0, 167142.0, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+TORO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045711', 2024, 'HONDA', 'CB 300F', '9C2NC6100RR012044', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    24930.0, 0, 29916.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CB 300F']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046775', 2024, 'CAOA CHERY', 'TIGGO 5X', '95PBDK31DRB051831', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    119585.0, 583.0, 143502.0, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CAOA CHERY+TIGGO 5X']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '961189', 2006, 'MERCEDES BENZ', 'L-1620', '9BM6953016B470501', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    216111.0, 0, 259333.19999999998, false,
    NOW() + INTERVAL '7 days', 2, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+L-1620']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1043401', 2006, 'CHEVROLET', 'CLASSIC', '9BGSA19E06B117597', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    15705.0, 455.0, 18846.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CLASSIC']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048251', 2007, 'FIAT', 'STRADA', '9BD27804D77002105', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    31592.0, 594.0, 37910.4, false,
    NOW() + INTERVAL '7 days', 6, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Avariado.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+STRADA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1012365', 2008, 'CHEVROLET', 'CELTA', '9BGRZ08908G216989', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    18645.0, 0, 22374.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CELTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049911', 2008, 'VOLKSWAGEN', 'GOL', '9BWCA05W18P016210', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 511.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041229', 2010, 'MITSUBISHI', 'L200 TRITON', '93XJRKB8TAC914892', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    87170.0, 593.0, 104604.0, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MITSUBISHI+L200 TRITON']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1038860', 2011, 'FIAT', 'PALIO', '9BD17164LB5705833', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    26562.0, 570.0, 31874.399999999998, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PALIO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1000850', 2012, 'KIA', 'SORENTO', 'KNAKU811DC5210268', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    56292.0, 569.0, 67550.4, false,
    NOW() + INTERVAL '7 days', 7, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=KIA+SORENTO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045258', 2011, 'FIAT', 'UNO', '9BD195183B0119291', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    27895.0, 476.0, 33474.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050497', 2011, 'RENAULT', 'CLIO', '8A1CB8V05BL620056', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    18195.0, 522.0, 21834.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+CLIO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041678', 2011, 'FIAT', 'PUNTO', '9BD11812EB1125159', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    29679.0, 468.0, 35614.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PUNTO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049247', 2012, 'NISSAN', 'MARCH', '3N1DK3CD1CL233133', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    30421.0, 581.0, 36505.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+MARCH']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1006448', 2013, 'VOLKSWAGEN', 'VOYAGE', '9BWDB05U7DT057135', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    33989.0, 657.0, 40786.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+VOYAGE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051601', 2013, 'CITROEN', 'C4', '8BCLCN6BYDG500787', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    29629.0, 517.0, 35554.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+C4']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1037519', 2013, 'VOLKSWAGEN', 'GOL', '9BWAA05W6DP097156', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    27054.0, 534.0, 32464.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048836', 2013, 'FIAT', 'UNO', '9BD195152D0376806', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    31091.0, 487.0, 37309.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '982376', 2013, 'VOLKSWAGEN', 'VOYAGE', '9BWDB45U9DT222206', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    34370.0, 494.0, 41244.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+VOYAGE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '977195', 2014, 'FORD', 'FIESTA', '9BFZF55A5E8060584', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    30658.0, 562.0, 36789.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Remarcado.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1013740', 2014, 'VOLKSWAGEN', 'JETTA', '3VWDJ2166EM068639', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    65245.0, 595.0, 78294.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+JETTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044242', 2014, 'FORD', 'FIESTA', '9BFZD55PXEB719305', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    36967.0, 520.0, 44360.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048703', 2014, 'NISSAN', 'LIVINA', '94DTAFL10EJ703270', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    37417.0, 486.0, 44900.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+LIVINA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050574', 2014, 'HONDA', 'CIVIC', '93HFB9640EZ127115', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    70625.0, 516.0, 84750.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CIVIC']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050588', 2014, 'VOLKSWAGEN', 'FOX', '9BWAA45Z2E4037718', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    39552.0, 453.0, 47462.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1040525', 2016, 'FORD', 'KA', '9BFZH55J5G8327848', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    35916.0, 528.0, 43099.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1000344', 2015, 'VOLKSWAGEN', 'GOL', '9BWAB45U4FP527580', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    39520.0, 485.0, 47424.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Remarcado.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045427', 2016, 'CHEVROLET', 'PRISMA', '9BGKS69G0GG157438', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    43962.0, 521.0, 52754.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+PRISMA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1008809', 2017, 'FORD', 'FIESTA', '9BFZD55P0HB538783', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    56016.0, 475.0, 67219.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048214', 2017, 'VOLKSWAGEN', 'FOX', '9BWAB45Z2H4020886', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    53583.0, 619.0, 64299.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052478', 2017, 'FIAT', 'TORO', '988226175HKA85152', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    95847.0, 596.0, 115016.4, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+TORO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1030782', 2018, 'VOLKSWAGEN', 'SAVEIRO', '9BWKB45U3JP056244', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    49476.0, 0, 59371.2, false,
    NOW() + INTERVAL '7 days', 6, 9, 11,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+SAVEIRO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044449', 2018, 'CITROEN', 'AIRCROSS', '935SUNFNUJB522660', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    55753.0, 512.0, 66903.59999999999, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+AIRCROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1016082', 2019, 'YAMAHA', 'XTZ 250', '9C6DG3410K0000751', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Remarcado.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+XTZ 250']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1035210', 2019, 'VOLKSWAGEN', 'AMAROK', 'WV1DA22H3KA022266', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    143367.0, 505.0, 172040.4, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+AMAROK']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1038724', 2019, 'HONDA', 'BIZ', '9C2JC7000KR011201', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    12583.0, 0, 15099.599999999999, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+BIZ']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045880', 2019, 'HYUNDAI', 'HB20', '9BHBG51CAKP908415', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    55325.0, 553.0, 66390.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045527', 2019, 'YAMAHA', 'NMAX', '9C6SG3310K0026607', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    14889.0, 0, 17866.8, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+NMAX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049594', 2019, 'HYUNDAI', 'HB20', '9BHBG51CAKP028907', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    53067.0, 509.0, 63680.399999999994, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041100', 2020, 'FIAT', 'FIORINO FURGAO', '9BD2651JHL9146928', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Pequenos', 'N/A',
    70357.0, 559.0, 84428.4, false,
    NOW() + INTERVAL '7 days', 11, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+FIORINO FURGAO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045543', 2020, 'FORD', 'RANGER CD', '8AFAR23LXLJ175620', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    150594.0, 613.0, 180712.8, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+RANGER CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048823', 2020, 'NISSAN', 'KICKS', '94DFCAP15LB247150', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    82808.0, 555.0, 99369.59999999999, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+KICKS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1024836', 2021, 'MITSUBISHI', 'L200 TRITON', '93XLJKL1TMCL31627', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    0, 597.0, 0.0, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MITSUBISHI+L200 TRITON']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1027887', 2021, 'HYUNDAI', 'HB20', '9BHCP51DBMP145607', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    69647.0, 456.0, 83576.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1038843', 2021, 'FORD', 'RANGER CD', '8AFAR23L4MJ220889', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    155588.0, 601.0, 186705.6, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+RANGER CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041516', 2021, 'CHEVROLET', 'TRACKER', '9BGEA76B0MB131265', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    97515.0, 492.0, 117018.0, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+TRACKER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041766', 2021, 'VOLVO', 'XC40', 'YV1XZBBCFM2524260', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    192215.0, 579.0, 230658.0, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLVO+XC40']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046794', 2022, 'CAOA CHERY', 'TIGGO 5X', '95PBCK51DNB028689', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    95538.0, 518.0, 114645.59999999999, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'ENCHENTE. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'ENCHENTE - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CAOA CHERY+TIGGO 5X']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049233', 2022, 'CHEVROLET', 'CRUZE', '8AGBB69S0NR113546', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    99930.0, 566.0, 119916.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CRUZE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049821', 2022, 'RENAULT', 'KWID', '93YRBB008NJ982116', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    45326.0, 523.0, 54391.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+KWID']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1003470', 2023, 'FIAT', 'CRONOS', '8AP359ATNPU308311', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    66246.0, 606.0, 79495.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+CRONOS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1026869', 2023, 'HONDA', 'CG 160', '9C2KC2210PR044422', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    18424.0, 0, 22108.8, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CG 160']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1035316', 2023, 'YAMAHA', 'FZ15', '9C6RG7710P0003843', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    18606.0, 0, 22327.2, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+FZ15']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044075', 2023, 'HYUNDAI', 'HB20S', '9BHCP41AAPP380604', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    71867.0, 490.0, 86240.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20S']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1043167', 2023, 'VOLKSWAGEN', 'GOL', '9BWAG45U0PT037700', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    55542.0, 508.0, 66650.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049827', 2023, 'HONDA', 'CG 160', '9C2KC2500PR123690', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    15889.0, 0, 19066.8, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CG 160']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049790', 2023, 'HYUNDAI', 'HB20S', '9BHCP41AAPP433273', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    71867.0, 602.0, 86240.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20S']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1025974', 2024, 'CHEVROLET', 'ONIX', '9BGEB48A0RG156943', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    69949.0, 0, 83938.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051468', 2024, 'VOLKSWAGEN', 'NIVUS', '9BWCH6CH2RP026796', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    118823.0, 501.0, 142587.6, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'ROUBO/FURTO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+NIVUS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051389', 2024, 'NISSAN', 'SENTRA', '3N1AB8AE0RY278846', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    123773.0, 502.0, 148527.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+SENTRA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039367', 2025, 'VOLKSWAGEN', 'POLO', '9BWAG5R12ST032481', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    76362.0, 0, 91634.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+POLO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045533', 2025, 'BMW', 'F 900', '99Z0K6009SZ949877', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    75899.0, 0, 91078.8, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BMW+F 900']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044199', 2025, 'RENAULT', 'MASTER FURGAO', '93YF62009SJ960239', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Grandes', 'N/A',
    216005.0, 0, 259206.0, false,
    NOW() + INTERVAL '7 days', 10, 9, 11,
    'ROUBO/FURTO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+MASTER FURGAO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048200', 2025, 'YAMAHA', 'NMAX', '9C6SG9110S0013709', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    22674.0, 0, 27208.8, false,
    NOW() + INTERVAL '7 days', 3, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+NMAX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1043199', 2026, 'FIAT', 'FASTBACK', '9BD376AJDTYC51541', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    113104.0, 500.0, 135724.8, false,
    NOW() + INTERVAL '7 days', 8, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+FASTBACK']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049329', 2008, 'VOLKSWAGEN', 'GOL', '9BWCA05W28P048132', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    19829.0, 577.0, 23794.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '934627', 2004, 'FIAT', 'UNO', '9BD15822544589262', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    15198.0, 525.0, 18237.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039793', 2009, 'VOLKSWAGEN', 'GOL', '9BWAA05WX9T078771', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    20572.0, 482.0, 24686.399999999998, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041136', 2022, 'TOYOTA', 'HILUX CS', '8AJDA8CB1N6047969', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    183006.0, 0, 219607.19999999998, false,
    NOW() + INTERVAL '7 days', 5, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+HILUX CS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041836', 2016, 'CHEVROLET', 'ONIX', '9BGKR48G0GG214710', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    44252.0, 466.0, 53102.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1042099', 2017, 'FORD', 'FIESTA', '9BFZD55P4HB550791', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    51516.0, 572.0, 61819.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1020351', 2020, 'VOLKSWAGEN', 'SAVEIRO', '9BWKB45U7LP023248', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    55003.0, 0, 66003.59999999999, false,
    NOW() + INTERVAL '7 days', 6, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Avariado.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+SAVEIRO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1035140', 2020, 'IVECO', 'TECTOR', '93ZE12JMZL8938098', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    300093.0, 0, 360111.6, false,
    NOW() + INTERVAL '7 days', 2, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Avariado.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=IVECO+TECTOR']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046816', 2013, 'FIAT', 'IDEA', '9BD13532CD2230424', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    35898.0, 453.0, 43077.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+IDEA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1043161', 2017, 'NISSAN', 'SENTRA', '3N1BB7AD6HY200575', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    65932.0, 545.0, 79118.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+SENTRA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039771', 2018, 'FIAT', 'ARGO', '9BD358A1NJYH86578', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    48840.0, 592.0, 58608.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 11,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+ARGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052921', 2023, 'LIFAN', 'seajet', '', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 6,
    'USO NORMAL. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=LIFAN+seajet']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052331', 2013, 'CHEVROLET', 'SONIC', '3G1J86CD1DS624928', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    36499.0, 0, 43798.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+SONIC']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052046', 2018, 'FIAT', 'MOBI', '9BD341A5XJY496236', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    42674.0, 0, 51208.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+MOBI']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049116', 2015, 'BMW', 'M6 GRAN COUPE', 'WBS6C910XFD385761', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    314632.0, 0, 377558.39999999997, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BMW+M6 GRAN COUPE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053035', 2015, 'MITSUBISHI', 'ASX', '93XXTGA2WFCF19976', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    74351.0, 0, 89221.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MITSUBISHI+ASX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1058017', 2013, 'TOYOTA', 'HILUX CD', '8AJFY29G3D8521914', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    127365.0, 0, 152838.0, false,
    NOW() + INTERVAL '7 days', 5, 1, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+HILUX CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057549', 2013, 'HONDA', 'FIT', '93HGE8890DZ205213', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057941', 2013, 'NISSAN', 'FRONTIER CD', '94DVCGD40DJ195955', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    74644.0, 0, 89572.8, false,
    NOW() + INTERVAL '7 days', 5, 8, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+FRONTIER CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057349', 2024, 'CHEVROLET', 'ONIX PLUS', '9BGEN69H0RG172069', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    86652.0, 0, 103982.4, false,
    NOW() + INTERVAL '7 days', 1, 1, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX PLUS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057602', 2014, 'CHEVROLET', 'PRISMA', '9BGKT69L0EG232414', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    52604.0, 0, 63124.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+PRISMA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057215', 2023, 'HONDA', 'CB 500 X', '9C2PC4920PR000012', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    44023.0, 0, 52827.6, false,
    NOW() + INTERVAL '7 days', 3, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CB 500 X']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057062', 2018, 'HYUNDAI', 'HB20', '9BHBG51CAJP840522', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    51453.0, 0, 61743.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041633', 2015, 'REBOQUE', 'FECHADO', '', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 2, 9, 6,
    'USO NORMAL. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=REBOQUE+FECHADO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041695', 2008, 'VOLKSWAGEN', 'NEW BEETLE', '3VWWH21C18M512282', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    46891.0, 0, 56269.2, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+NEW BEETLE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045305', 1964, 'VOLKSWAGEN', 'FUSCA 1200', '', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 1, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FUSCA 1200']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045924', 1989, 'CHEVROLET', 'MONZA', '9BGJK69TKJB011583', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    13156.0, 0, 15787.199999999999, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+MONZA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045961', 2010, 'HAFEI', 'TOWNER PICK-UP', 'LKHNF1BG3AAF01175', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Pequenos', 'N/A',
    14160.0, 0, 16992.0, false,
    NOW() + INTERVAL '7 days', 11, 8, 6,
    'USO NORMAL. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HAFEI+TOWNER PICK-UP']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048601', 1979, 'VOLKSWAGEN', 'BRASILIA', 'BA773877', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+BRASILIA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051557', 2010, 'AUDI', 'A3 SPORTBACK', 'WAUHF68P9AA080932', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    59315.0, 0, 71178.0, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=AUDI+A3 SPORTBACK']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052003', 2015, 'JEEP', 'GRAND CHEROKEE', '1C4RJFBG8FC826040', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    97891.0, 0, 117469.2, false,
    NOW() + INTERVAL '7 days', 7, 12, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=JEEP+GRAND CHEROKEE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052904', 1989, 'MASSEY FERGUSON', '295 PCA TATU', '', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Tratores', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 9, 10, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MASSEY FERGUSON+295 PCA TATU']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052955', 2022, 'CHEVROLET', 'SPIN', '9BGJK7520NB198401', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    87204.0, 0, 104644.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+SPIN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053040', 1993, 'VOLKSWAGEN', 'GOL', '9BWZZZ30ZPT050571', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053049', 2018, 'KIA', 'BONGO', '9UWSHX76AJN022177', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Grandes', 'N/A',
    111730.0, 0, 134076.0, false,
    NOW() + INTERVAL '7 days', 10, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=KIA+BONGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1053943', 2010, 'CHEVROLET', 'S10 CABINE DUPLA', '9BG138HF0AC416531', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 5, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+S10 CABINE DUPLA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1054190', 2023, 'RENAULT', 'KWID', '93YRBB001PJ363926', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    50536.0, 0, 60643.2, false,
    NOW() + INTERVAL '7 days', 1, 8, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+KWID']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1054296', 2021, 'MERCEDES BENZ', 'ATEGO', '9BM958154MB208127', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    318648.0, 0, 382377.6, false,
    NOW() + INTERVAL '7 days', 2, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+ATEGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1054456', 2016, 'FORD', 'KA SEDAN', '9BFZH54J5G8304250', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    40225.0, 0, 48270.0, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1054457', 2025, 'CHEVROLET', 'ONIX', '9BGEB48A0SG132496', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    75427.0, 0, 90512.4, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1054612', 1994, 'SCANIA', 'K113', '9BSKC4X2BP3462710', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 2, 5, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=SCANIA+K113']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1054816', 2014, 'VOLKSWAGEN', 'GOL', '9BWAA05WXEP022106', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055705', 2022, 'VOLKSWAGEN', 'POLO', '9BWAH5BZ7NP031465', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    87184.0, 0, 104620.8, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+POLO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055713', 2016, 'CHEVROLET', 'ONIX', '9BGKS48G0GG286248', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    44883.0, 0, 53859.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055715', 2006, 'BUELL', 'ULYSSES', '5MZDX03RX63701827', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    19475.0, 0, 23370.0, false,
    NOW() + INTERVAL '7 days', 3, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Remarcado.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BUELL+ULYSSES']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055853', 2014, 'FIAT', 'SIENA', '8AP372110E6068007', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    33103.0, 0, 39723.6, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+SIENA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055856', 2020, 'VOLKSWAGEN', 'GOL', '9BWAB45U0LT008030', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    49742.0, 0, 59690.399999999994, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Remarcado.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055898', 2022, 'JEEP', 'RENEGADE', '9886111KRNK470038', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    100656.0, 0, 120787.2, false,
    NOW() + INTERVAL '7 days', 8, 6, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=JEEP+RENEGADE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055920', 2006, 'CHEVROLET', 'CELTA', '9BGRX48906G167620', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    16075.0, 0, 19290.0, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CELTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055935', 2002, 'FIAT', 'PALIO', '9BD17101322146535', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    11550.0, 0, 13860.0, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PALIO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055941', 2008, 'VOLKSWAGEN', 'TOUAREG', 'WVGVE67L38D013366', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    42834.0, 0, 51400.799999999996, false,
    NOW() + INTERVAL '7 days', 7, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+TOUAREG']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055963', 1999, 'VOLKSWAGEN', 'PASSAT', 'WVWMA83BXWE455895', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    18209.0, 0, 21850.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+PASSAT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055985', 2019, 'HYUNDAI', 'HB20', '9BHBG51DBKP960939', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    70452.0, 0, 84542.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056038', 2020, 'MITSUBISHI', 'PAJERO SPORT', 'MMBGUKS10LH001929', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    215468.0, 0, 258561.59999999998, false,
    NOW() + INTERVAL '7 days', 7, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MITSUBISHI+PAJERO SPORT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056417', 2018, 'AUDI', 'A5 SPORTBACK', 'WAUGFEF5XJA007091', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    146518.0, 0, 175821.6, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=AUDI+A5 SPORTBACK']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056450', 2019, 'RENAULT', 'SANDERO', '93Y5SRF84KJ605531', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    40579.0, 0, 48694.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+SANDERO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056644', 2020, 'HONDA', 'FIT', '93HGK5840LK100195', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    81639.0, 0, 97966.8, false,
    NOW() + INTERVAL '7 days', 1, 4, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056860', 2017, 'RENAULT', 'LOGAN', '93Y4SRD04HJ571213', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+LOGAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056861', 2016, 'HYUNDAI', 'HB20', '9BHBG51CAGP537036', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    45768.0, 0, 54921.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056876', 2008, 'CHEVROLET', 'VECTRA HATCH', '9BGAJ48W08B225744', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    32502.0, 0, 39002.4, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+VECTRA HATCH']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057059', 2020, 'PEUGEOT', 'PARTNER FURGAO', '8AEGCNFN8LG505985', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Pequenos', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 11, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=PEUGEOT+PARTNER FURGAO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057126', 2011, 'VOLKSWAGEN', 'KOMBI', '9BWMF07X2BP015604', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Grandes', 'N/A',
    41840.0, 0, 50208.0, false,
    NOW() + INTERVAL '7 days', 10, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+KOMBI']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057284', 2015, 'AUDI', 'A3 SEDAN', 'WAUAYJ8V8F1095927', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    72592.0, 0, 87110.4, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=AUDI+A3 SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057360', 2021, 'CHEVROLET', 'ONIX', '9BGEB48H0MG164568', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    70408.0, 0, 84489.59999999999, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057484', 2018, 'FIAT', 'UNO', '9BD195B4NJ0830974', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    37416.0, 0, 44899.2, false,
    NOW() + INTERVAL '7 days', 1, 1, 6,
    'USO NORMAL. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057548', 2018, 'FIAT', 'UNO', '9BD195B4NJ0829774', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    37416.0, 0, 44899.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057576', 2011, 'HONDA', 'FIT', '93HGE8890BZ105785', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057582', 2008, 'HONDA', 'FIT', '93HGD18608Z208851', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    34954.0, 0, 41944.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Desconhecido. Não Aplicável. Condição: Normal.', 'Desconhecido', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057604', 2013, 'FIAT', 'PUNTO', '9BD118179D1219765', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    53396.0, 0, 64075.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PUNTO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057923', 2023, 'JEEP', 'COMPASS', '98867512NPKL84795', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    133092.0, 0, 159710.4, false,
    NOW() + INTERVAL '7 days', 7, 14, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=JEEP+COMPASS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1057925', 2025, 'BYD', 'SONG PLUS', 'LGXC74C40S0002304', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    194747.0, 0, 233696.4, false,
    NOW() + INTERVAL '7 days', 7, 14, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BYD+SONG PLUS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1058005', 2012, 'CHEVROLET', 'CELTA', '9BGRP48F0CG301721', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    29583.0, 0, 35499.6, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CELTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1058015', 2012, 'FIAT', 'BRAVO', '9BD198257C9011395', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    47017.0, 0, 56420.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+BRAVO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1058104', 2021, 'HONDA', 'BIZ', '9C2JC4830MR057957', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 3, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+BIZ']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1058218', 2015, 'HONDA', 'CITY', '93HGM6650FZ112947', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    64990.0, 0, 77988.0, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CITY']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1058578', 2012, 'CHEVROLET', 'ZAFIRA', '9BGTU75J0CC237222', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    36803.0, 0, 44163.6, false,
    NOW() + INTERVAL '7 days', 1, 11, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ZAFIRA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1058916', 2024, 'FORD', 'RANGER CD', '8AFBR01L7RJ385659', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    294464.0, 0, 353356.8, false,
    NOW() + INTERVAL '7 days', 5, 7, 6,
    'USO NORMAL. Motor dá partida e engrena. Não Aplicável. Condição: Normal.', 'Motor dá partida e engrena', 'USO NORMAL - Não Aplicável', 'NORMAL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+RANGER CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '991865', 2023, 'CHEVROLET', 'TRACKER', '8AGEP76B0PR136955', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    112583.0, 0, 135099.6, false,
    NOW() + INTERVAL '7 days', 8, 9, 3,
    'ROUBO/FURTO. Motor dá partida e engrena. Pequena Monta. Condição: Remarcado.', 'Motor dá partida e engrena', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+TRACKER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049620', 2007, 'CITROEN', 'C3', '935FLN6A87B507176', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    18730.0, 0, 22476.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+C3']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050177', 2010, 'FIAT', 'SIENA', '8AP17206LA2128431', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+SIENA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046851', 2013, 'NISSAN', 'GRAND LIVINA', '94DJBAL10DJ195308', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    42892.0, 0, 51470.4, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+GRAND LIVINA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047344', 2016, 'NISSAN', 'MARCH', '94DFFUK13GB201935', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    41304.0, 603.0, 49564.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+MARCH']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1030748', 2021, 'RENAULT', 'MASTER FURGAO', '93YMAFEXCMJ715638', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Grandes', 'N/A',
    165827.0, 0, 198992.4, false,
    NOW() + INTERVAL '7 days', 10, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+MASTER FURGAO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049658', 2003, 'CHEVROLET', 'CELTA', '9BGRD48X03G199923', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    14273.0, 0, 17127.6, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CELTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1034751', 2023, 'CHEVROLET', 'ONIX PLUS', '9BGEN69H0PG228579', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    78696.0, 0, 94435.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX PLUS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1017345', 1993, 'CHEVROLET', 'KADETT', '9BGKT08KPNC309139', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 82.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+KADETT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045295', 2025, 'HYUNDAI', 'CRETA', '9BHPC81EBSP185052', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    158181.0, 0, 189817.19999999998, false,
    NOW() + INTERVAL '7 days', 8, 9, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+CRETA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1055937', 2024, 'HYUNDAI', 'HB20', '9BHCP51BARP446745', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    72245.0, 0, 86694.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039143', 2019, 'FORD', 'KA', '9BFZH55S3K8294320', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    50128.0, 0, 60153.6, false,
    NOW() + INTERVAL '7 days', 1, 15, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050692', 2020, 'CHEVROLET', 'SPIN', '9BGJP7520LB111619', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    71735.0, 0, 86082.0, false,
    NOW() + INTERVAL '7 days', 1, 15, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+SPIN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1028022', 2018, 'HYUNDAI', 'HB20S', '9BHBG41CAJP890759', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    53745.0, 113.0, 64494.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20S']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1026900', 2018, 'CHEVROLET', 'PRISMA', '9BGKS69V0JG335326', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    61445.0, 0, 73734.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'ROUBO/FURTO. Motor dá partida e engrena. Pequena Monta. Condição: Remarcado.', 'Motor dá partida e engrena', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+PRISMA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050943', 2011, 'VOLKSWAGEN', 'GOL', '9BWAA05U0BT176020', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    25499.0, 0, 30598.8, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044623', 2014, 'FORD', 'ECOSPORT', '9BFZB55P3E8857626', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    52053.0, 0, 62463.6, false,
    NOW() + INTERVAL '7 days', 8, 12, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+ECOSPORT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050082', 2014, 'FORD', 'FIESTA', '9BFZD55J5EB744494', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    36875.0, 0, 44250.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+FIESTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047628', 2016, 'FIAT', 'IDEA', '9BD13501YG2281805', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    42583.0, 0, 51099.6, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+IDEA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046531', 2015, 'HYUNDAI', 'GRAND SANTA FE', 'KMHSN81EDFU052646', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    92418.0, 0, 110901.59999999999, false,
    NOW() + INTERVAL '7 days', 7, 2, 3,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+GRAND SANTA FE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1036584', 2025, 'HONDA', 'NC 750X', '9C2RC9100SR001919', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    55782.0, 0, 66938.4, false,
    NOW() + INTERVAL '7 days', 3, 15, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+NC 750X']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039122', 2008, 'VOLKSWAGEN', 'GOL', '9BWCA05W98T161809', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    20070.0, 0, 24084.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '996516', 2021, 'RENAULT', 'KWID', '93YRBB003MJ395398', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    39559.0, 30.0, 47470.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 3, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+KWID']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045365', 2016, 'VOLKSWAGEN', 'SAVEIRO', '9BWKB45U2GP038682', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    47181.0, 0, 56617.2, false,
    NOW() + INTERVAL '7 days', 6, 12, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+SAVEIRO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047317', 2017, 'CITROEN', 'C3', '935SLHMZ1HB512224', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    43491.0, 0, 52189.2, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida. Pequena Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+C3']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047196', 2021, 'HONDA', 'CG 160', '9C2KC2200MR201486', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    14897.0, 0, 17876.399999999998, false,
    NOW() + INTERVAL '7 days', 3, 12, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CG 160']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1054318', 2019, 'HYUNDAI', 'HB20', '9BHBG51CAKP945642', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    53067.0, 0, 63680.399999999994, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049532', 2023, 'HONDA', 'PCX', '9C2KF5200PR001859', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    19079.0, 0, 22894.8, false,
    NOW() + INTERVAL '7 days', 3, 12, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+PCX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1007298', 2012, 'PEUGEOT', '207', '8AD2MKFWXCG008115', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    21770.0, 0, 26124.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=PEUGEOT+207']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1054951', 2018, 'HONDA', 'CB 500 X', '9C2PC4920JR000988', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    35093.0, 0, 42111.6, false,
    NOW() + INTERVAL '7 days', 3, 9, 3,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CB 500 X']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049157', 2013, 'HONDA', 'FIT', '93HGE6730DZ224169', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    45020.0, 0, 54024.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+FIT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049747', 2014, 'FIAT', 'UNO', '9BD195152E0486287', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    31628.0, 0, 37953.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050297', 2016, 'CHEVROLET', 'TRACKER', '3GNCJ8EW9GL124276', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    69053.0, 0, 82863.59999999999, false,
    NOW() + INTERVAL '7 days', 8, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+TRACKER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '997784', 2024, 'CHEVROLET', 'TRACKER', '9BGEP76B0RB175489', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    125145.0, 0, 150174.0, false,
    NOW() + INTERVAL '7 days', 8, 2, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+TRACKER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '974347', 2023, 'HONDA', 'CB 500 F', '9C2PC4820PR004744', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    38142.0, 0, 45770.4, false,
    NOW() + INTERVAL '7 days', 3, 3, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CB 500 F']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047457', 2012, 'NISSAN', 'VERSA', '3N1CN7AD2CL853924', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    32539.0, 0, 39046.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+VERSA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1050852', 2014, 'VOLKSWAGEN', 'FOX', '9BWAA45Z2E4041073', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    39067.0, 0, 46880.4, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1019592', 2014, 'NISSAN', 'VERSA', '3N1CN7AD2EK437848', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    38890.0, 0, 46668.0, false,
    NOW() + INTERVAL '7 days', 1, 15, 3,
    'ENCHENTE. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'ENCHENTE - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+VERSA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1036113', 2012, 'FIAT', 'UNO', '9BD195163C0248059', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    31857.0, 0, 38228.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046058', 2015, 'FIAT', 'UNO', '9BD195152F0621937', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    31966.0, 0, 38359.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051004', 2016, 'VOLKSWAGEN', 'FOX', '9BWAL45Z8G4046405', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    50059.0, 0, 60070.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049455', 2021, 'JEEP', 'RENEGADE', '98861115XMK408645', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    80168.0, 0, 96201.59999999999, false,
    NOW() + INTERVAL '7 days', 8, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=JEEP+RENEGADE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1024807', 2014, 'FIAT', 'UNO', '9BD195152E0612192', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    31869.0, 0, 38242.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1027284', 2023, 'FIAT', 'MOBI', '9BD341ACZPY800757', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    53462.0, 0, 64154.399999999994, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+MOBI']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044283', 2023, 'MERCEDES BENZ', 'ACCELO', '9BM951104PB301512', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    322131.0, 0, 386557.2, false,
    NOW() + INTERVAL '7 days', 2, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+ACCELO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049332', 2012, 'FIAT', 'PALIO', '9BD17106LC5806077', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    24260.0, 0, 29112.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PALIO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047162', 2010, 'FIAT', 'PALIO', '9BD17164LA5437447', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    25696.0, 0, 30835.199999999997, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PALIO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1016195', 2013, 'VOLKSWAGEN', 'FOX', '9BWAB05Z8D4091030', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    37945.0, 0, 45534.0, false,
    NOW() + INTERVAL '7 days', 1, 2, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+FOX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1038440', 2018, 'FIAT', 'ARGO', '9BD358A1NJYH90070', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    48840.0, 0, 58608.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+ARGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1026450', 2015, 'CHEVROLET', 'COBALT', '9BGJB69X0FB136326', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    38755.0, 0, 46506.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'ROUBO/FURTO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+COBALT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046547', 2013, 'CHEVROLET', 'AGILE', '8AGCN48X0DR159333', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    34585.0, 7.0, 41502.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+AGILE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1037756', 2018, 'FORD', 'KA SEDAN', '9BFZH54J0J8498368', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    42594.0, 0, 51112.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044453', 2010, 'FIAT', 'PALIO', '9BD17164LA5612273', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    25696.0, 0, 30835.199999999997, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PALIO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045767', 2015, 'CHEVROLET', 'ONIX', '9BGKR48G0FG354816', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    42824.0, 46.0, 51388.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '939530', 2022, 'YAMAHA', 'MT-07', '9C6RM0940N0005121', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    41877.0, 100.0, 50252.4, false,
    NOW() + INTERVAL '7 days', 3, 6, 3,
    'ROUBO/FURTO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+MT-07']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '959696', 2015, 'YAMAHA', 'MT-09', '9C6RN3520F0000914', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    40921.0, 0, 49105.2, false,
    NOW() + INTERVAL '7 days', 3, 9, 3,
    'ROUBO/FURTO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+MT-09']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '924281', 2007, 'FORD', 'ECOSPORT', '9BFZE12P878798905', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 8, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+ECOSPORT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044471', 2013, 'FIAT', 'UNO', '9BD195152D0351099', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    30170.0, 0, 36204.0, false,
    NOW() + INTERVAL '7 days', 1, 7, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1036822', 2025, 'JEEP', 'RENEGADE', '9886111LHSK652076', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    133940.0, 0, 160728.0, false,
    NOW() + INTERVAL '7 days', 8, 2, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=JEEP+RENEGADE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041494', 2017, 'VOLKSWAGEN', 'UP', '9BWAH4121HT506845', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    53160.0, 0, 63792.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+UP']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046251', 2025, 'FIAT', 'STRADA CD', '9BD281BLPS9911216', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    119970.0, 0, 143964.0, false,
    NOW() + INTERVAL '7 days', 6, 6, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+STRADA CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046620', 2012, 'TOYOTA', 'COROLLA', '9BRBD48E6C2566847', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    63009.0, 0, 75610.8, false,
    NOW() + INTERVAL '7 days', 1, 14, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+COROLLA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1037155', 2016, 'JEEP', 'RENEGADE', '988611122GK054182', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    67759.0, 0, 81310.8, false,
    NOW() + INTERVAL '7 days', 8, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=JEEP+RENEGADE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041306', 2025, 'HONDA', 'CG 160', '9C2KC2200SR121641', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    19317.0, 0, 23180.399999999998, false,
    NOW() + INTERVAL '7 days', 3, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CG 160']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047444', 2020, 'PEUGEOT', '2008', '936CMNFNVLB507969', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    61690.0, 0, 74028.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=PEUGEOT+2008']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045953', 2020, 'VOLVO', 'FH', '9BVRG20C6LE868230', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    499983.0, 0, 599979.6, false,
    NOW() + INTERVAL '7 days', 2, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLVO+FH']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048920', 2009, 'CHEVROLET', 'CLASSIC', '8AGSA19909R136106', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 14, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CLASSIC']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1042381', 2015, 'FIAT', 'UNO', '9BD195102F0624870', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    27445.0, 0, 32934.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1043290', 2019, 'VOLKSWAGEN', 'VIRTUS', '9BWDH5BZXKP506485', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    73294.0, 0, 87952.8, false,
    NOW() + INTERVAL '7 days', 1, 7, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+VIRTUS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046527', 2025, 'YAMAHA', 'XTZ 250', '9C6DG3340S0030140', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    29460.0, 0, 35352.0, false,
    NOW() + INTERVAL '7 days', 3, 9, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+XTZ 250']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1052409', 2009, 'CITROEN', 'GRAND C4 PICASSO', 'VF7UARFJ29J005801', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    25699.0, 0, 30838.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CITROEN+GRAND C4 PICASSO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044609', 1996, 'VOLKSWAGEN', 'GOL', '9BWZZZ377TP546737', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    15148.0, 0, 18177.6, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051049', 2024, 'BYD', 'DOLPHIN', 'LC0CE4CC5R0022560', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    116535.0, 0, 139842.0, false,
    NOW() + INTERVAL '7 days', 1, 2, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BYD+DOLPHIN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1020506', 2015, 'CHEVROLET', 'ONIX', '9BGKS48B0FG223971', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    42234.0, 0, 50680.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1043332', 2021, 'FIAT', 'MOBI', '9BD341ACXMY721950', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    46727.0, 0, 56072.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+MOBI']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1042238', 2019, 'FIAT', 'ARGO', '9BD358A1NKYJ11533', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    50305.0, 0, 60366.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+ARGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046064', 2025, 'HONDA', 'HR-V', '93HRV3850SK104814', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    154431.0, 0, 185317.19999999998, false,
    NOW() + INTERVAL '7 days', 8, 9, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+HR-V']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1001393', 2010, 'CHEVROLET', 'CELTA', '9BGRZ48F0AG283893', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    21890.0, 0, 26268.0, false,
    NOW() + INTERVAL '7 days', 1, 13, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CELTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046025', 2021, 'HYUNDAI', 'HB20S', '9BHCP41AAMP091279', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    66105.0, 0, 79326.0, false,
    NOW() + INTERVAL '7 days', 1, 2, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HB20S']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1024532', 2016, 'FIAT', 'PALIO', '9BD19626TG2280841', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    45017.0, 0, 54020.4, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+PALIO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '955601', 2019, 'CHEVROLET', 'S10 CABINE DUPLA', '9BG148TA0KC444108', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    116736.0, 0, 140083.19999999998, false,
    NOW() + INTERVAL '7 days', 5, 14, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+S10 CABINE DUPLA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1018999', 2021, 'VOLKSWAGEN', 'VOYAGE', '9BWDG45U3MT072272', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    49948.0, 38.0, 59937.6, false,
    NOW() + INTERVAL '7 days', 1, 7, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+VOYAGE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045058', 2021, 'CHEVROLET', 'TRACKER', '9BGEB76H0MB219580', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    90447.0, 109.0, 108536.4, false,
    NOW() + INTERVAL '7 days', 8, 9, 3,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+TRACKER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1002842', 2023, 'RENAULT', 'SANDERO', '93Y5SRT55PJ327910', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    60531.0, 38.0, 72637.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+SANDERO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '501696', 2011, 'MERCEDES BENZ', 'ATEGO', '9BM958094BB746864', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    252731.0, 0, 303277.2, false,
    NOW() + INTERVAL '7 days', 2, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+ATEGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1022336', 2024, 'FIAT', 'ARGO', '9BD358ACFRYN06829', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    68000.0, 47.0, 81600.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+ARGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1033596', 2024, 'HYUNDAI', 'CRETA', '9BHPB81BBRP091723', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    137210.0, 40.0, 164652.0, false,
    NOW() + INTERVAL '7 days', 8, 15, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+CRETA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '873674', 2019, 'JEEP', 'COMPASS', '988675136KKJ48634', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    114665.0, 0, 137598.0, false,
    NOW() + INTERVAL '7 days', 7, 12, 3,
    'ENCHENTE. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'ENCHENTE - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=JEEP+COMPASS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1018693', 2021, 'VOLKSWAGEN', 'SAVEIRO', '9BWKB45U4MP014170', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Pequenas', 'N/A',
    67924.0, 28.0, 81508.8, false,
    NOW() + INTERVAL '7 days', 6, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+SAVEIRO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '841159', 2009, 'RENAULT', 'CLIO', '8A1BB8B059L114752', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    18307.0, 123.0, 21968.399999999998, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+CLIO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1036655', 2015, 'CHEVROLET', 'PRISMA', '9BGKS69R0FG376354', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    48997.0, 20.0, 58796.4, false,
    NOW() + INTERVAL '7 days', 1, 15, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+PRISMA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1030974', 2016, 'FIAT', 'UNO', '9BD19510ZG0713428', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    29579.0, 0, 35494.799999999996, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1027663', 2021, 'CHEVROLET', 'TRACKER', '9BGEX76H0MB137902', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    90005.0, 583.0, 108006.0, false,
    NOW() + INTERVAL '7 days', 8, 9, 3,
    'ROUBO/FURTO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+TRACKER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1029608', 2010, 'HYUNDAI', 'TUCSON', 'KMHJN81BBAU172302', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    38836.0, 0, 46603.2, false,
    NOW() + INTERVAL '7 days', 8, 15, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+TUCSON']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1047601', 2009, 'IVECO', 'STRALIS', '93ZM2ARH098805932', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    138425.0, 0, 166110.0, false,
    NOW() + INTERVAL '7 days', 2, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=IVECO+STRALIS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '954927', 1990, 'FORD', 'DEL REY BELINA', '9BFZZZ55ZKB037875', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Motor dá partida e engrena. Grande Monta. Condição: Recortado.', 'Motor dá partida e engrena', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+DEL REY BELINA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '968799', 2007, 'FORD', 'KA', '9BFBLZGDA7B603778', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    13131.0, 99.0, 15757.199999999999, false,
    NOW() + INTERVAL '7 days', 1, 13, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1035193', 2020, 'VOLKSWAGEN', 'T-CROSS', '9BWBH6BF0L4084829', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    85857.0, 77.0, 103028.4, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+T-CROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1016860', 2017, 'VOLKSWAGEN', 'GOL', '9BWAG45U1HT068682', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    40792.0, 0, 48950.4, false,
    NOW() + INTERVAL '7 days', 1, 2, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1018669', 2003, 'CHEVROLET', 'CELTA', '9BGRD08X03G142254', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    13119.0, 0, 15742.8, false,
    NOW() + INTERVAL '7 days', 1, 2, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CELTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1023479', 2009, 'VOLKSWAGEN', 'GOL', '9BWAA05U09T237764', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    23397.0, 0, 28076.399999999998, false,
    NOW() + INTERVAL '7 days', 1, 2, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '982504', 2024, 'TOYOTA', 'COROLLA CROSS', '9BRKYAAG6R0675554', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    168606.0, 0, 202327.19999999998, false,
    NOW() + INTERVAL '7 days', 8, 12, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+COROLLA CROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1029242', 2002, 'FIAT', 'UNO', '9BD15802524297165', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    11276.0, 24.0, 13531.199999999999, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '987356', 2000, 'VOLVO', 'FH12', '9BVA4B5A0YE672994', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    83747.0, 0, 100496.4, false,
    NOW() + INTERVAL '7 days', 2, 2, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLVO+FH12']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1040148', 2017, 'FORD', 'RANGER CD', '8AFAR23L9HJ423654', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    131184.0, 1.0, 157420.8, false,
    NOW() + INTERVAL '7 days', 5, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+RANGER CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1027738', 2014, 'NISSAN', 'LIVINA', '94DTAFL10EJ903906', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    37417.0, 34.0, 44900.4, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+LIVINA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '896768', 1996, 'CHEVROLET', 'KADETT', '9BGKZ08GTTB433005', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    10908.0, 0, 13089.6, false,
    NOW() + INTERVAL '7 days', 1, 9, 3,
    'ROUBO/FURTO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'ROUBO/FURTO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+KADETT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '993637', 1999, 'VOLKSWAGEN', 'GOL', '9BWZZZ377WP575319', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    11335.0, 0, 13602.0, false,
    NOW() + INTERVAL '7 days', 1, 2, 3,
    'COLISÃO. Motor dá partida e engrena. Grande Monta. Condição: Recortado.', 'Motor dá partida e engrena', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '954714', 2025, 'TOYOTA', 'COROLLA CROSS', '9BRKYAAG5S0703222', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    196878.0, 133.0, 236253.59999999998, false,
    NOW() + INTERVAL '7 days', 8, 9, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+COROLLA CROSS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1027672', 2019, 'FIAT', 'TORO', '988226175KKC27673', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    101817.0, 20.0, 122180.4, false,
    NOW() + INTERVAL '7 days', 5, 15, 3,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+TORO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1037454', 2019, 'SCANIA', 'R 450', '9BSR6X200K3951151', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    479356.0, 0, 575227.2, false,
    NOW() + INTERVAL '7 days', 2, 12, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=SCANIA+R 450']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1042408', 2013, 'VOLVO', 'VM', '9BVP0S1A3DE138920', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    220329.0, 0, 264394.8, false,
    NOW() + INTERVAL '7 days', 2, 2, 3,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLVO+VM']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1000186', 2019, 'TOYOTA', 'YARIS', '9BRKC3F30K8054883', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    79755.0, 99.0, 95706.0, false,
    NOW() + INTERVAL '7 days', 1, 13, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+YARIS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '947827', 2022, 'VOLKSWAGEN', 'DELIVERY', '9535H5TB1NR029269', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    310125.0, 0, 372150.0, false,
    NOW() + INTERVAL '7 days', 2, 2, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+DELIVERY']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '959043', 2024, 'RAM', 'RAMPAGE', '988591253RKR82138', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    204392.0, 0, 245270.4, false,
    NOW() + INTERVAL '7 days', 5, 2, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RAM+RAMPAGE']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1013585', 2012, 'JAC', 'J3 TURIN', 'LJ12FKR13C4294789', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    17562.0, 0, 21074.399999999998, false,
    NOW() + INTERVAL '7 days', 1, 2, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=JAC+J3 TURIN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1003283', 2024, 'SHINERAY', 'SHI', '99HSHF175RS002690', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    15277.0, 99.0, 18332.399999999998, false,
    NOW() + INTERVAL '7 days', 3, 13, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=SHINERAY+SHI']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1009522', 2025, 'SHINERAY', 'XY 150', '99HFRF150SS001235', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    10662.0, 0, 12794.4, false,
    NOW() + INTERVAL '7 days', 3, 2, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=SHINERAY+XY 150']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1027903', 2023, 'VOLKSWAGEN', 'GOL', '9BWAG45U3PT052448', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    55542.0, 28.0, 66650.4, false,
    NOW() + INTERVAL '7 days', 1, 12, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+GOL']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '959571', 1994, 'CHEVROLET', 'MONZA', '9BGJM11RRRB067738', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    14467.0, 0, 17360.399999999998, false,
    NOW() + INTERVAL '7 days', 1, 14, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+MONZA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1015685', 2014, 'VOLKSWAGEN', 'KOMBI FURGAO', '9BWNF07XXEP006223', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Grandes', 'N/A',
    47106.0, 0, 56527.2, false,
    NOW() + INTERVAL '7 days', 10, 15, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=VOLKSWAGEN+KOMBI FURGAO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1046026', 2015, 'CHEVROLET', 'COBALT', '9BGJB69Z0FB142070', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    40592.0, 0, 48710.4, false,
    NOW() + INTERVAL '7 days', 1, 2, 3,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+COBALT']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048467', 2022, 'FIAT', 'ARGO', '9BD358A1NNYL34130', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    57631.0, 0, 69157.2, false,
    NOW() + INTERVAL '7 days', 1, 12, 12,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+ARGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048666', 2014, 'BMW', 'X1', 'WBAVL9107EVT80929', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    79134.0, 0, 94960.8, false,
    NOW() + INTERVAL '7 days', 8, 12, 12,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BMW+X1']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044685', 2024, 'CAOA CHERY', 'TIGGO 8', '95PDEM61DRB025300', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    156378.0, 0, 187653.6, false,
    NOW() + INTERVAL '7 days', 7, 12, 12,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CAOA CHERY+TIGGO 8']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044348', 2012, 'CHEVROLET', 'CLASSIC', '9BGSU19F0CC142684', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    25948.0, 0, 31137.6, false,
    NOW() + INTERVAL '7 days', 1, 12, 12,
    'COLISÃO. Motor dá partida e engrena. Pequena Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CLASSIC']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1038037', 2025, 'NISSAN', 'Kicks Play', '94DFCAP15SB119530', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    110067.0, 0, 132080.4, false,
    NOW() + INTERVAL '7 days', 8, 12, 12,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=NISSAN+Kicks Play']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '987630', 2023, 'FIAT', 'ARGO', '9BD358ACVPYM43458', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    61404.0, 100.0, 73684.8, false,
    NOW() + INTERVAL '7 days', 1, 9, 12,
    'ROUBO/FURTO. Motor dá partida. Pequena Monta. Condição: Remarcado.', 'Motor dá partida', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+ARGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '987485', 2022, 'CHEVROLET', 'ONIX', '9BGEB48A0NG124225', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    63521.0, 59.0, 76225.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 12,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Remarcado.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+ONIX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1024934', 1997, 'CHEVROLET', 'CORSA', '9BGSD68ZVTC648685', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    9615.0, 21.0, 11538.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 12,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CORSA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1042312', 2014, 'MERCEDES BENZ', 'ATEGO', '9BM958074EB985441', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Caminhões e Rebocadores', 'N/A',
    235552.0, 0, 282662.39999999997, false,
    NOW() + INTERVAL '7 days', 2, 12, 12,
    'QUEIMADO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'QUEIMADO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MERCEDES BENZ+ATEGO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041336', 2024, 'FORD', 'RANGER CD', '8AFBR01L9RJ352176', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Picapes Grandes', 'N/A',
    292568.0, 187.0, 351081.6, false,
    NOW() + INTERVAL '7 days', 5, 9, 12,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+RANGER CD']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1039497', 2016, 'TOYOTA', 'COROLLA', '9BRBDWHE8G0297909', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    84458.0, 0, 101349.59999999999, false,
    NOW() + INTERVAL '7 days', 1, 12, 12,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+COROLLA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1031434', 1999, 'RENAULT', 'MEGANE SEDAN', '8A1L64GXZWS014034', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    8030.0, 425.0, 9636.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 12,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Avariado.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=RENAULT+MEGANE SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049019', 2022, 'TRIUMPH', 'TIGER', '97NE63DF1NMAU3194', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    60058.0, 0, 72069.59999999999, false,
    NOW() + INTERVAL '7 days', 3, 14, 12,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TRIUMPH+TIGER']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044043', 2010, 'MITSUBISHI', 'PAJERO TR4', '93XFRH77WACA45880', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Pequenos', 'N/A',
    0, 559.0, 0.0, false,
    NOW() + INTERVAL '7 days', 8, 9, 12,
    'ROUBO/FURTO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'ROUBO/FURTO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=MITSUBISHI+PAJERO TR4']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1056500', 2016, 'BMW', 'X5', '3AVKR6102GRA30135', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    260767.0, 0, 312920.39999999997, false,
    NOW() + INTERVAL '7 days', 7, 9, 12,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=BMW+X5']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045094', 2023, 'CAOA CHERY', 'TIGGO 7', '95PEDL61DPB001869', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    134850.0, 24.0, 161820.0, false,
    NOW() + INTERVAL '7 days', 7, 9, 12,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CAOA CHERY+TIGGO 7']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1038126', 2022, 'JEEP', 'COMPASS', '988675118NKL24872', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'SUV Grandes', 'N/A',
    148024.0, 84.0, 177628.8, false,
    NOW() + INTERVAL '7 days', 7, 12, 12,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=JEEP+COMPASS']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1045968', 2017, 'HYUNDAI', 'HR', '95PZBN7KPHB072146', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Grandes', 'N/A',
    109308.0, 0, 131169.6, false,
    NOW() + INTERVAL '7 days', 10, 12, 12,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HR']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1038785', 2022, 'YAMAHA', 'NMAX', '9C6SG5910N0026370', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    18169.0, 0, 21802.8, false,
    NOW() + INTERVAL '7 days', 3, 12, 12,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+NMAX']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1044857', 2020, 'FORD', 'KA SEDAN', '9BFZH54L0L8432150', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    49006.0, 35.0, 58807.2, false,
    NOW() + INTERVAL '7 days', 1, 9, 12,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA SEDAN']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1036971', 2010, 'TOYOTA', 'COROLLA', '9BRBB48EXA5086084', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    0, 57.0, 0.0, false,
    NOW() + INTERVAL '7 days', 1, 9, 12,
    'COLISÃO. Motor dá partida. Média Monta. Condição: Normal.', 'Motor dá partida', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=TOYOTA+COROLLA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1043035', 2008, 'YAMAHA', 'XTZ 250', '9C6KG021080031604', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Motos', 'N/A',
    11507.0, 11.0, 13808.4, false,
    NOW() + INTERVAL '7 days', 3, 12, 12,
    'COLISÃO. Desconhecido. Pequena Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Pequena Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=YAMAHA+XTZ 250']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1048196', 2013, 'FIAT', 'UNO', '9BD195162D0411434', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    31685.0, 0, 38022.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 12,
    'COLISÃO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1051507', 2009, 'CHEVROLET', 'CELTA', '9BGRZ08909G138255', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    19675.0, 0, 23610.0, false,
    NOW() + INTERVAL '7 days', 1, 12, 12,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=CHEVROLET+CELTA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1029065', 2005, 'FORD', 'KA', '9BFBSZGDA5B562788', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    13589.0, 0, 16306.8, false,
    NOW() + INTERVAL '7 days', 1, 12, 12,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FORD+KA']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041791', 2018, 'HYUNDAI', 'HR', '95PZBN7KPJB076354', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Utilitários Grandes', 'N/A',
    113331.0, 0, 135997.19999999998, false,
    NOW() + INTERVAL '7 days', 10, 9, 12,
    'QUEIMADO. Desconhecido. Média Monta. Condição: Normal.', 'Desconhecido', 'QUEIMADO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HYUNDAI+HR']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1041357', 2020, 'FIAT', 'UNO', '9BD195A4ZL0873398', 
    'salvage', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    39607.0, 0, 47528.4, false,
    NOW() + INTERVAL '7 days', 1, 12, 12,
    'COLISÃO. Desconhecido. Grande Monta. Condição: Recortado.', 'Desconhecido', 'COLISÃO - Grande Monta', 'IRRECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=FIAT+UNO']::text[], NOW(), NOW()
);
INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '1049040', 2014, 'HONDA', 'CITY', '93HGM2500EZ205340', 
    'clean', 0, 'N/A', 'N/A', 'N/A', 'N/A', 'Automóveis', 'N/A',
    52163.0, 0, 62595.6, false,
    NOW() + INTERVAL '7 days', 1, 14, 12,
    'COLISÃO. Motor dá partida e engrena. Média Monta. Condição: Normal.', 'Motor dá partida e engrena', 'COLISÃO - Média Monta', 'RECUPERÁVEL',
    ARRAY['https://placehold.co/800x600/0066CC/FFFFFF/png?text=HONDA+CITY']::text[], NOW(), NOW()
);

-- Resetar sequences
SELECT setval('categories_id_seq', 11);
SELECT setval('locations_id_seq', 15);
SELECT setval('partners_id_seq', 13);
SELECT setval('vehicles_id_seq', 500);