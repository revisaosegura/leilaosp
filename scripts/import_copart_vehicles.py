#!/usr/bin/env python3
"""
Script para importar veículos da planilha Copart para PostgreSQL
"""
import csv
import re
from datetime import datetime

def clean_price(price_str):
    """Remove 'BRL' e converte para número"""
    if not price_str or price_str == '0 BRL':
        return 0
    # Remove 'BRL' e espaços, substitui ponto por nada e vírgula por ponto
    clean = price_str.replace(' BRL', '').replace('.', '').replace(',', '.')
    try:
        return float(clean)
    except:
        return 0

def clean_string(s):
    """Limpa string para SQL"""
    if not s:
        return ''
    return s.replace("'", "''").strip()

def parse_csv_line(line):
    """Parse uma linha do CSV considerando campos com ponto e vírgula"""
    # O CSV usa ponto e vírgula como separador
    fields = line.split(';')
    return fields

# Ler CSV
vehicles = []
with open('/home/ubuntu/upload/LotSearchresults_2025November16.csv', 'r', encoding='utf-8') as f:
    reader = csv.reader(f, delimiter=';')
    next(reader)  # Pular cabeçalho
    
    count = 0
    for row in reader:
        if count >= 500:  # Limitar a 500 veículos
            break
        
        if len(row) < 20:
            continue
            
        try:
            vehicle = {
                'lot_number': clean_string(row[1]),
                'year': int(row[2]) if row[2].isdigit() else 2020,
                'make': clean_string(row[3]),
                'model': clean_string(row[4]),
                'status': clean_string(row[5]),  # RECUPERÁVEL/IRRECUPERÁVEL
                'vin': clean_string(row[6]),
                'category': clean_string(row[7]),  # Automóveis/Motos
                'damage_type': clean_string(row[8]),  # COLISÃO
                'engine_status': clean_string(row[9]),  # Motor dá partida
                'damage_level': clean_string(row[10]),  # Pequena/Média/Grande Monta
                'condition': clean_string(row[11]),  # Normal/Recortado
                'seller': clean_string(row[12]),  # Seguradora
                'estimated_value': clean_price(row[13]),
                'location': clean_string(row[14]),
                'auction_date': clean_string(row[15]),
                'yard': clean_string(row[16]),
                'current_bid': clean_price(row[18]) if len(row) > 18 else 0,
            }
            vehicles.append(vehicle)
            count += 1
        except Exception as e:
            print(f"Erro ao processar linha: {e}")
            continue

print(f"Total de veículos processados: {len(vehicles)}")

# Gerar SQL
sql_output = []

# Limpar tabelas
sql_output.append("-- Limpar dados existentes")
sql_output.append("TRUNCATE TABLE vehicles, categories, locations, partners RESTART IDENTITY CASCADE;")
sql_output.append("")

# Inserir categorias únicas
categories = set()
for v in vehicles:
    if v['category']:
        categories.add(v['category'])

sql_output.append("-- Inserir categorias")
for i, cat in enumerate(sorted(categories), 1):
    sql_output.append(f"INSERT INTO categories (id, name, description) VALUES ({i}, '{cat}', '{cat}');")

sql_output.append("")

# Inserir localizações únicas
locations = set()
for v in vehicles:
    if v['location']:
        locations.add(v['location'])

sql_output.append("-- Inserir localizações")
for i, loc in enumerate(sorted(locations), 1):
    sql_output.append(f"INSERT INTO locations (id, name, address, city, state) VALUES ({i}, '{loc}', '{loc}', '{loc.split(' - ')[0] if ' - ' in loc else loc}', '{loc.split(' - ')[1] if ' - ' in loc else 'SP'}');")

sql_output.append("")

# Inserir parceiros (seguradoras)
partners = set()
for v in vehicles:
    if v['seller']:
        partners.add(v['seller'])

sql_output.append("-- Inserir parceiros")
for i, partner in enumerate(sorted(partners), 1):
    sql_output.append(f"INSERT INTO partners (id, name) VALUES ({i}, '{partner}');")

sql_output.append("")

# Mapear categorias e localizações para IDs
category_map = {cat: i+1 for i, cat in enumerate(sorted(categories))}
location_map = {loc: i+1 for i, loc in enumerate(sorted(locations))}
partner_map = {p: i+1 for i, p in enumerate(sorted(partners))}

# Inserir veículos
sql_output.append("-- Inserir veículos")
for i, v in enumerate(vehicles, 1):
    cat_id = category_map.get(v['category'], 1)
    loc_id = location_map.get(v['location'], 1)
    partner_id = partner_map.get(v['seller'], 1)
    
    # Determinar status baseado em RECUPERÁVEL/IRRECUPERÁVEL
    if 'IRRECUPERÁVEL' in v['status'].upper():
        status = 'salvage'
    elif 'RECUPERÁVEL' in v['status'].upper():
        status = 'clean'
    else:
        status = 'clean'
    
    # Descrição detalhada
    description = f"{v['damage_type']}. {v['engine_status']}. {v['damage_level']}. Condição: {v['condition']}."
    
    # Imagem placeholder
    image_url = f"https://placehold.co/800x600/0066CC/FFFFFF/png?text={v['make']}+{v['model']}"
    
    sql_line = f"""INSERT INTO vehicles (
    lot_number, year, make, model, vin, status, mileage, color, 
    engine, transmission, fuel_type, body_type, drive_type,
    estimated_value, current_bid, buy_now_price, reserve_met,
    auction_date, category_id, location_id, seller_id,
    description, highlights, damage_description, title_status,
    images, created_at, updated_at
) VALUES (
    '{v['lot_number']}', {v['year']}, '{v['make']}', '{v['model']}', '{v['vin']}', 
    '{status}', 0, 'N/A', 'N/A', 'N/A', 'N/A', '{v['category']}', 'N/A',
    {v['estimated_value']}, {v['current_bid']}, {v['estimated_value'] * 1.2}, false,
    NOW() + INTERVAL '7 days', {cat_id}, {loc_id}, {partner_id},
    '{clean_string(description)}', '{v['engine_status']}', '{v['damage_type']} - {v['damage_level']}', '{v['status']}',
    ARRAY['{image_url}']::text[], NOW(), NOW()
);"""
    
    sql_output.append(sql_line)

# Resetar sequences
sql_output.append("")
sql_output.append("-- Resetar sequences")
sql_output.append(f"SELECT setval('categories_id_seq', {len(categories)});")
sql_output.append(f"SELECT setval('locations_id_seq', {len(locations)});")
sql_output.append(f"SELECT setval('partners_id_seq', {len(partners)});")
sql_output.append(f"SELECT setval('vehicles_id_seq', {len(vehicles)});")

# Salvar arquivo SQL
with open('/home/ubuntu/leilaosp/scripts/import_copart_data.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql_output))

print(f"Arquivo SQL gerado: /home/ubuntu/leilaosp/scripts/import_copart_data.sql")
print(f"Total de veículos: {len(vehicles)}")
print(f"Total de categorias: {len(categories)}")
print(f"Total de localizações: {len(locations)}")
print(f"Total de parceiros: {len(partners)}")
