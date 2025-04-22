-- Criar o banco de dados
CREATE DATABASE ecommerce;

-- Usar o banco de dados criado
USE ecommerce;

-- Criar a tabela de vendas
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    produto VARCHAR(50),
    quantidade INT,
    valor_unitario DECIMAL(10, 2),
    data_venda DATE
);

-- Inserir dados simulados (do mês anterior e variados)
INSERT INTO vendas VALUES 
(1, 'Teclado', 2, 100.00, '2025-03-01'),
(2, 'Mouse', 1, 50.00, '2025-03-05'),
(3, 'Monitor', 1, 700.00, '2025-03-10'),
(4, 'Teclado', 3, 100.00, '2025-03-15'),
(5, 'Mouse', 2, 50.00, '2025-03-20'),
(6, 'Monitor', 1, 700.00, '2025-03-22'),
(7, 'Mouse', 4, 50.00, '2025-03-25'),
(8, 'Teclado', 1, 100.00, '2025-03-27'),
(9, 'Webcam', 2, 150.00, '2025-03-28'),
(10, 'Webcam', 3, 150.00, '2025-03-30');

-- =======================================================
-- CONSULTAS
-- =======================================================

-- 1️⃣ Quantas vendas foram realizadas no mês passado?
SELECT COUNT(*) AS total_vendas
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) 
                     AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- 2️⃣ Qual foi o valor total de vendas de cada produto?
SELECT produto, SUM(quantidade * valor_unitario) AS valor_total
FROM vendas
GROUP BY produto;

-- 3️⃣ Qual foi o produto mais vendido em quantidade?
SELECT produto, SUM(quantidade) AS total_quantidade
FROM vendas
GROUP BY produto
ORDER BY total_quantidade DESC
LIMIT 1;

-- 4️⃣ Qual foi o valor médio das vendas por dia no mês passado?
SELECT data_venda, AVG(quantidade * valor_unitario) AS media_diaria
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) 
                     AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY data_venda;

-- 5️⃣ Qual foi a venda de maior valor no mês passado?
SELECT MAX(quantidade * valor_unitario) AS maior_valor
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) 
                     AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- 6️⃣ Qual foi a venda de menor valor no mês passado?
SELECT MIN(quantidade * valor_unitario) AS menor_valor
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) 
                     AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- 💡 Desafio adicional: valor médio da venda por dia para cada produto
SELECT produto, data_venda, AVG(quantidade * valor_unitario) AS media_por_dia
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) 
                     AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY produto, data_venda;