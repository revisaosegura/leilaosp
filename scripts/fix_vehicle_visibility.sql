-- Script para corrigir a visibilidade dos veículos importados
-- Execute este script no DBeaver

-- 1. Atualizar status para 'active' (o script de importação usa 'clean'/'salvage' que o site não mostra)
UPDATE vehicles SET status = 'active' WHERE status IN ('clean', 'salvage');

-- 2. Preencher image_url com a primeira imagem do array (o site usa image_url para a listagem)
UPDATE vehicles SET image_url = images[1] WHERE image_url IS NULL AND array_length(images, 1) > 0;
