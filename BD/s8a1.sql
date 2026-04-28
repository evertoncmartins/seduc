-- 1. PREPARAÇÃO DO AMBIENTE
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- 2. CRIAÇÃO DA TABELA
-- Criamos a estrutura conforme o roteiro.
CREATE TABLE IF NOT EXISTS vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    produto VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    data_venda DATE NOT NULL
);

-- 3. INSERÇÃO DE DADOS (DML)
-- Adicionei 10 registros para garantir que as consultas retornem múltiplos dados.
-- Como hoje é 28/04/2026, o "mês passado" para o SQL é Março.
INSERT INTO vendas (produto, quantidade, valor_unitario, data_venda) VALUES
('Mouse Gamer', 5, 80.00, '2026-03-10'),
('Teclado Mecânico', 2, 150.00, '2026-03-12'),
('Monitor 24pol', 1, 900.00, '2026-03-15'),
('Webcam HD', 3, 120.00, '2026-03-18'),
('Mouse Gamer', 2, 80.00, '2026-03-20'),
('Teclado Mecânico', 3, 150.00, '2026-03-22'),
('Monitor 24pol', 2, 900.00, '2026-03-25'),
('Headset USB', 4, 200.00, '2026-03-28'),
('Mouse Gamer', 1, 80.00, '2026-04-05'),
('Webcam HD', 2, 120.00, '2026-04-10');

-- 4. CONSULTAS (DQL)

-- Q1: Quantas vendas no mês passado? 
-- Importante: O SELECT deve vir antes do FROM.
SELECT COUNT(*) AS total_vendas 
FROM vendas 
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- Q2: Valor total por produto
-- Usamos SUM para somar e GROUP BY para agrupar.
SELECT produto, SUM(quantidade * valor_unitario) AS valor_total
FROM vendas
GROUP BY produto;

-- Q3: Produto mais vendido em quantidade
SELECT produto, SUM(quantidade) AS total_qtd
FROM vendas
GROUP BY produto
ORDER BY total_qtd DESC
LIMIT 3; -- Mostra os 3 primeiros para fins didáticos

-- Q4: Valor médio das vendas por dia no mês passado
-- Agrupa por data para mostrar a média de cada dia.
SELECT data_venda, AVG(quantidade * valor_unitario) AS media_diaria
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY data_venda;

-- Q5: Maior e menor venda do mês passado
-- MAX e MIN encontram os valores extremos.
SELECT 
    MAX(quantidade * valor_unitario) AS maior_valor,
    MIN(quantidade * valor_unitario) AS menor_valor
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- DESAFIO: Média por dia para cada produto
SELECT data_venda, produto, AVG(quantidade * valor_unitario) AS media_produto_dia
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
GROUP BY data_venda, produto;