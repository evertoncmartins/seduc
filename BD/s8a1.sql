-- 1. CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- 2. CRIAÇÃO DA TABELA DE VENDAS
-- Definimos os tipos de dados adequados para cada informação
CREATE TABLE IF NOT EXISTS vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único e automático
    produto VARCHAR(100) NOT NULL,           -- Nome do produto (texto)
    quantidade INT NOT NULL,                 -- Quantidade (número inteiro)
    valor_unitario DECIMAL(10, 2) NOT NULL,  -- Valor com duas casas decimais
    data_venda DATE NOT NULL                 -- Data no formato YYYY-MM-DD
);

-- 3. INSERÇÃO DE DADOS PARA TESTE (DML)
-- Inserindo dados variados, incluindo vendas do "mês passado" (março/abril de 2026)
-- para que as consultas de data funcionem conforme o enunciado.
INSERT INTO vendas (produto, quantidade, valor_unitario, data_venda) VALUES
('Teclado Mecânico', 2, 150.00, '2026-03-15'),
('Mouse Gamer', 5, 80.00, '2026-03-20'),
('Monitor 24pol', 1, 900.00, '2026-03-25'),
('Teclado Mecânico', 1, 150.00, '2026-04-05'),
('Mouse Gamer', 3, 80.00, '2026-04-10'),
('Headset USB', 4, 200.00, '2026-03-10'),
('Monitor 24pol', 2, 900.00, '2026-03-10'),
('Webcam HD', 10, 120.00, '2026-03-12');

-- ==============================================================
-- RESOLUÇÃO DAS QUESTÕES (DQL)
-- ==============================================================

-- 01. Quantas vendas foram realizadas no mês passado?
-- Utilizamos COUNT(*) para contar as linhas e BETWEEN para o intervalo de datas.
SELECT COUNT(*) AS total_vendas
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- 02. Qual foi o valor total de vendas de cada produto?
-- Multiplicamos quantidade por valor e agrupamos pelo nome do produto.
SELECT produto, SUM(quantidade * valor_unitario) AS valor_total
FROM vendas
GROUP BY produto;

-- 03. Qual foi o produto mais vendido em quantidade?
-- Somamos as quantidades, ordenamos do maior para o menor e limitamos a 1 resultado.
SELECT produto, SUM(quantidade) AS total_quantidade
FROM vendas
GROUP BY produto
ORDER BY total_quantidade DESC
LIMIT 1;

-- 04. Qual foi o valor médio das vendas por dia no mês passado?
-- Primeiro calculamos o total de cada venda (quantidade * valor) e tiramos a média, agrupando por dia.
SELECT data_venda, AVG(quantidade * valor_unitario) AS media_venda_diaria
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY data_venda;

-- 05. Qual foi a venda de maior valor e a de menor valor no mês passado?
-- Usamos MAX e MIN sobre o cálculo do valor total da venda (item por item).
SELECT 
    MAX(quantidade * valor_unitario) AS maior_venda,
    MIN(quantidade * valor_unitario) AS menor_venda
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- ==============================================================
-- DESAFIO ADICIONAL
-- ==============================================================

-- Crie uma consulta que mostre o valor médio da venda por dia para cada produto no mês passado.
-- Aqui o agrupamento é duplo: por data e por produto.
SELECT 
    data_venda, 
    produto, 
    AVG(quantidade * valor_unitario) AS media_valor
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY data_venda, produto
ORDER BY data_venda ASC;