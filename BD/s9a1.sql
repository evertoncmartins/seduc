-- =============================================================================
-- ATIVIDADE PRÁTICA: Utilizando UNION, INTERSECT e EXCEPT no MySQL
-- Cenário: Gestão de Banco de Dados de uma Livraria
-- =============================================================================

-- 1. Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS livraria;

-- 2. Seleção do Banco de Dados para uso
USE livraria;

-- 3. Criação da tabela de Clientes Online
CREATE TABLE clientes_online (
    id_cliente INT,
    nome VARCHAR(100),
    email VARCHAR(100),
    cidade VARCHAR(100)
);

-- 4. Inserção de dados na tabela de Clientes Online
INSERT INTO clientes_online (id_cliente, nome, email, cidade) VALUES
(1, 'Ana Silva', 'ana@email.com', 'São Paulo'),
(2, 'Carlos Santos', 'carlos@email.com', 'Rio de Janeiro'),
(3, 'Bia Oliveira', 'bia@email.com', 'Brasília');

-- 5. Criação da tabela de Clientes Físicos
CREATE TABLE clientes_fisicos (
    id_cliente INT,
    nome VARCHAR(100),
    email VARCHAR(100),
    cidade VARCHAR(100)
);

-- 6. Inserção de dados na tabela de Clientes Físicos
INSERT INTO clientes_fisicos (id_cliente, nome, email, cidade) VALUES
(2, 'Carlos Santos', 'carlos@email.com', 'Rio de Janeiro'),
(3, 'Bia Oliveira', 'bia@email.com', 'Brasília'),
(4, 'Denis Pereira', 'denis@email.com', 'Salvador');

-- =============================================================================
-- CONSULTAS SOLICITADAS
-- =============================================================================

-- TAREFA 1: UNION
-- Retorna todos os clientes de ambas as lojas sem duplicar informações.
-- Se o cliente estiver nas duas tabelas, será exibido apenas uma vez.
SELECT nome, email, cidade FROM clientes_online
UNION
SELECT nome, email, cidade FROM clientes_fisicos;


-- TAREFA 2: INTERSECT
-- Encontra os clientes que compraram tanto na loja on-line quanto na loja física.

-- Opção A: Usando o comando INTERSECT
SELECT nome, email, cidade FROM clientes_online
INTERSECT
SELECT nome, email, cidade FROM clientes_fisicos;

-- Opção B: Alternativa usando INNER JOIN
SELECT o.nome, o.email, o.cidade
FROM clientes_online o
INNER JOIN clientes_fisicos f ON o.email = f.email;


-- TAREFA 3: EXCEPT
-- Liste os clientes que compraram na loja on-line, mas NÃO compraram na loja física.

-- Opção A: Usando o comando EXCEPT
SELECT nome, email, cidade FROM clientes_online
EXCEPT
SELECT nome, email, cidade FROM clientes_fisicos;

-- Opção B: Alternativa usando LEFT JOIN
SELECT o.nome, o.email, o.cidade
FROM clientes_online o
LEFT JOIN clientes_fisicos f ON o.email = f.email
WHERE f.email IS NULL;