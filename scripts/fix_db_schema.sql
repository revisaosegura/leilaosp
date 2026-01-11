-- Script para corrigir a tabela de usuários no banco de dados existente
-- Execute este script no DBeaver

-- Adicionar colunas que faltam na tabela users
ALTER TABLE users ADD COLUMN IF NOT EXISTS username TEXT UNIQUE;
ALTER TABLE users ADD COLUMN IF NOT EXISTS phone TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS password TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT NOW();
ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT NOW();

-- Garantir que a coluna role seja text (caso tenha sido criada como enum anteriormente)
-- Se der erro dizendo que não pode converter, ignore se a coluna já existir e funcionar
-- ALTER TABLE users ALTER COLUMN role TYPE TEXT;