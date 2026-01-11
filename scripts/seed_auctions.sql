-- Script para inserir leilões de exemplo
-- Execute este script no DBeaver conectado ao banco do Render

INSERT INTO auctions (title, description, start_date, end_date, status) VALUES
('Leilão Pátio Osasco - Premium', 'Leilão especial com veículos de luxo e esportivos recuperados de seguradora.', NOW(), NOW() + INTERVAL '2 days', 'live'),

('Leilão de Utilitários e Pesados', 'Caminhonetes, furgões e caminhões em ótimo estado de conservação.', NOW() - INTERVAL '1 day', NOW() + INTERVAL '1 day', 'live'),

('Mega Leilão Online - Multimarcas', 'Grande oportunidade para revendedores. Veículos de diversas marcas e modelos.', NOW() + INTERVAL '2 days', NOW() + INTERVAL '5 days', 'scheduled'),

('Leilão de Motos - Pátio Curitiba', 'Motos de diversas cilindradas. Oportunidade única.', NOW() - INTERVAL '5 days', NOW() - INTERVAL '1 day', 'ended');