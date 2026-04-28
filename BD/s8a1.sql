-- 1. PREPARAÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- 2. CRIAÇÃO DA TABELA (DDL)
CREATE TABLE IF NOT EXISTS vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    produto VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    data_venda DATE NOT NULL
);

-- 3. INSERÇÃO DE DADOS (DML)
-- Limpando a tabela para evitar duplicidade durante a explicação
TRUNCATE TABLE vendas;

-- Inserindo dados variados focados no final de Março (Mês Passado)
-- e alguns em Abril (Mês Atual) para testar os filtros.
INSERT INTO vendas (produto, quantidade, valor_unitario, data_venda) VALUES
('Mouse Gamer', 5, 80.00, '2026-03-28'),
('Teclado Mecânico', 2, 150.00, '2026-03-28'),
('Monitor 24pol', 1, 900.00, '2026-03-29'),
('Mouse Gamer', 3, 80.00, '2026-03-29'),
('Headset USB', 4, 210.00, '2026-03-29'),
('Webcam HD', 6, 125.50, '2026-03-30'),
('Teclado Mecânico', 3, 150.00, '2026-03-30'),
('Monitor 24pol', 2, 900.00, '2026-03-31'),
('Headset USB', 2, 210.00, '2026-03-31'),
('Webcam HD', 1, 125.50, '2026-03-31'),
('Mouse Gamer', 1, 80.00, '2026-04-10'),
('Webcam HD', 2, 125.50, '2026-04-15');

-- ==============================================================
-- CONSULTAS DE ANÁLISE (DQL)
-- ==============================================================

-- Q1: Quantas vendas foram realizadas no mês passado (Março)?
SELECT COUNT(*) AS total_vendas
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- Q2: Valor total de vendas de CADA produto (Geral)?
-- Usamos ROUND para deixar o valor com 2 casas decimais.
SELECT produto, ROUND(SUM(quantidade * valor_unitario), 2) AS faturamento_total
FROM vendas
GROUP BY produto;

-- Q3: Qual foi o produto mais vendido em quantidade?
SELECT produto, SUM(quantidade) AS total_unidades
FROM vendas
GROUP BY produto
ORDER BY total_unidades DESC
LIMIT 1;

-- Q4: Valor médio das vendas por dia no mês passado?
SELECT data_venda, ROUND(AVG(quantidade * valor_unitario), 2) AS media_diaria
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY data_venda;

-- Q5: Maior e menor venda (financeira) do mês passado?
SELECT 
    MAX(quantidade * valor_unitario) AS maior_venda,
    MIN(quantidade * valor_unitario) AS menor_venda
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- DESAFIO ADICIONAL: Valor médio da venda por dia para CADA produto no mês passado.
SELECT 
    data_venda, 
    produto, 
    ROUND(AVG(quantidade * valor_unitario), 2) AS media_valor
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY data_venda, produto
ORDER BY data_venda ASC;