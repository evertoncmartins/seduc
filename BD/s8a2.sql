-- 1. Criar o banco de dados
CREATE DATABASE IF NOT EXISTS ecommerce_vendas;
USE ecommerce_vendas;

-- 2. Criar as tabelas
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(50),
    categoria VARCHAR(30),
    preco DECIMAL(10, 2)
);

CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    id_produto INT,
    quantidade INT,
    data_venda DATE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- 3. Inserir dados na tabela produtos
INSERT INTO produtos (id_produto, nome, categoria, preco) VALUES
(1, 'Notebook', 'Eletrônicos', 2500.00),
(2, 'Impressora', 'Periféricos', 900.00),
(3, 'Headset', 'Periféricos', 250.00),
(4, 'Mouse Gamer', 'Acessórios', 120.00),
(5, 'Monitor 24"', 'Eletrônicos', 1100.00);

-- 4. Inserir dados na tabela vendas (últimos 3 meses)
-- Supondo que a data atual é abril/2025

INSERT INTO vendas (id_venda, id_produto, quantidade, data_venda) VALUES
(1, 1, 1, '2025-02-15'),  -- Notebook (fev)
(2, 2, 2, '2025-02-20'),  -- Impressora (fev)
(3, 3, 3, '2025-03-05'),  -- Headset (mar)
(4, 3, 1, '2025-03-10'),  -- Headset (mar)
(5, 4, 2, '2025-03-12'),  -- Mouse Gamer (mar)
(6, 5, 1, '2025-03-20'),  -- Monitor (mar)
(7, 2, 1, '2025-04-01'),  -- Impressora (abr)
(8, 1, 2, '2025-04-10'),  -- Notebook (abr)
(9, 5, 1, '2025-04-15'),  -- Monitor (abr)
(10, 4, 3, '2025-04-18'); -- Mouse Gamer (abr)

-- =======================================================
-- CONSULTAS
-- =======================================================

-- 1️⃣ Qual foi o produto mais vendido nos últimos três meses?
SELECT p.nome, SUM(v.quantidade) AS total_vendidos
FROM produtos p
JOIN vendas v ON p.id_produto = v.id_produto
WHERE v.data_venda BETWEEN DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), '%Y-%m-01')
                      AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY p.nome
ORDER BY total_vendidos DESC
LIMIT 1;

SELECT p.nome, SUM(v.quantidade) AS total_vendidos
FROM produtos p
JOIN vendas v ON p.id_produto = v.id_produto
WHERE v.data_venda BETWEEN '2025-01-01' AND '2025-03-31'
GROUP BY p.nome
ORDER BY total_vendidos DESC
LIMIT 1;

-- 2️⃣ Qual foi o valor total de vendas por categoria no mês passado?
SELECT p.nome, SUM(v.quantidade) AS total_vendidos
FROM produtos p
JOIN vendas v ON p.id_produto = v.id_produto
WHERE v.data_venda BETWEEN DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), '%Y-%m-01')
                      AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY p.nome
ORDER BY total_vendidos DESC
LIMIT 1;

-- 3️⃣ Qual foi a média de produtos vendidos por pedido nos últimos três meses?
SELECT AVG(v.quantidade) AS media_por_pedido
FROM vendas v
WHERE v.data_venda BETWEEN DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), '%Y-%m-01')
                      AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- 4️⃣ Qual foi o valor da venda mais alta nos últimos três meses?
SELECT MAX(v.quantidade * p.preco) AS maior_venda
FROM vendas v
JOIN produtos p ON v.id_produto = p.id_produto
WHERE v.data_venda BETWEEN DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), '%Y-%m-01')
                      AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- 5️⃣ Qual foi o valor da venda mais baixa nos últimos três meses?
SELECT MIN(v.quantidade * p.preco) AS menor_venda
FROM vendas v
JOIN produtos p ON v.id_produto = p.id_produto
WHERE v.data_venda BETWEEN DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), '%Y-%m-01')
                      AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- 6️⃣ Qual categoria teve a maior quantidade de produtos vendidos nos últimos três meses?
SELECT p.categoria, SUM(v.quantidade) AS total_quantidade
FROM produtos p
JOIN vendas v ON p.id_produto = v.id_produto
WHERE v.data_venda BETWEEN DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), '%Y-%m-01')
                      AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY p.categoria
ORDER BY total_quantidade DESC
LIMIT 1;

-- 💡 Desafio adicional:
-- Mostre o faturamento total por mês dos últimos três meses, agrupado por categoria
SELECT 
    p.categoria,
    DATE_FORMAT(v.data_venda, '%Y-%m') AS mes,
    SUM(v.quantidade * p.preco) AS faturamento_mensal
FROM produtos p
JOIN vendas v ON p.id_produto = p.id_produto
WHERE v.data_venda BETWEEN DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), '%Y-%m-01')
                      AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY p.categoria, mes
ORDER BY mes, p.categoria;