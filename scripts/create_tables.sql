-- Script para criar a estrutura das tabelas no PostgreSQL
-- Execute este script no DBeaver ANTES de rodar os scripts de importação de dados (seed ou import_copart)

-- Tabela de Usuários
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE,
    name TEXT,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    password TEXT,
    role TEXT DEFAULT 'user',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de Categorias
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT,
    description TEXT,
    image_url TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de Localizações (Pátios)
CREATE TABLE IF NOT EXISTS locations (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT,
    city TEXT,
    state TEXT,
    zip_code TEXT,
    phone TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de Parceiros (Sellers/Vendedores)
CREATE TABLE IF NOT EXISTS partners (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    logo_url TEXT,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de Veículos
CREATE TABLE IF NOT EXISTS vehicles (
    id SERIAL PRIMARY KEY,
    lot_number TEXT,
    year INTEGER,
    make TEXT,
    model TEXT,
    vin TEXT,
    status TEXT DEFAULT 'active',
    mileage INTEGER DEFAULT 0,
    color TEXT,
    engine TEXT,
    transmission TEXT,
    fuel_type TEXT,
    body_type TEXT,
    drive_type TEXT,
    estimated_value DECIMAL(10, 2),
    current_bid DECIMAL(10, 2) DEFAULT 0,
    buy_now_price DECIMAL(10, 2),
    reserve_met BOOLEAN DEFAULT FALSE,
    auction_date TIMESTAMP,
    category_id INTEGER REFERENCES categories(id),
    location_id INTEGER REFERENCES locations(id),
    seller_id INTEGER REFERENCES partners(id),
    description TEXT,
    highlights TEXT,
    damage_description TEXT,
    title_status TEXT,
    document_status TEXT,
    category_detail TEXT,
    condition TEXT,
    running_condition TEXT,
    monta_type TEXT,
    chassis_type TEXT,
    comitente TEXT,
    patio TEXT,
    images TEXT[], -- Array de strings para PostgreSQL
    image_url TEXT, -- Campo legado para compatibilidade
    sale_type TEXT DEFAULT 'auction',
    has_warranty BOOLEAN DEFAULT FALSE,
    has_report BOOLEAN DEFAULT FALSE,
    fipe_value INTEGER,
    bid_increment INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de Lances (Bids)
CREATE TABLE IF NOT EXISTS bids (
    id SERIAL PRIMARY KEY,
    amount DECIMAL(10, 2) NOT NULL,
    user_id INTEGER REFERENCES users(id),
    vehicle_id INTEGER REFERENCES vehicles(id),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de Leilões (Auctions)
CREATE TABLE IF NOT EXISTS auctions (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    status TEXT DEFAULT 'scheduled' NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de Favoritos
CREATE TABLE IF NOT EXISTS favorites (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    vehicle_id INTEGER REFERENCES vehicles(id),
    created_at TIMESTAMP DEFAULT NOW()
);