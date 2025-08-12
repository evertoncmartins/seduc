CREATE DATABASE ecommerce_analise_db;

USE ecommerce_analise_db;

CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE compras (
    compra_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    valor_total DECIMAL(10, 2) NOT NULL,
    data_compra DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

INSERT INTO
    clientes (nome, email)
VALUES
    ('João Silva', 'joao.silva@example.com'),
    ('Maria Oliveira', 'maria.oliveira@example.com'),
    ('Carlos Pereira', 'carlos.pereira@example.com'),
    ('Ana Costa', 'ana.costa@example.com');

INSERT INTO
    compras (cliente_id, valor_total, data_compra)
VALUES
    (1, 150.75, '2025-07-15'),
    (2, 89.90, '2025-07-16'),
    (1, 299.99, '2025-07-18'),
    (3, 1200.00, '2025-07-20'),
    (4, 75.50, '2025-08-01'),
    (2, 550.25, '2025-08-05'),
    (1, 45.30, '2025-08-10');

-- ➡️ CONSULTA 1: Calculem o valor total das vendas realizadas até hoje. 
-- A função SUM(valor_total) calcula a soma de todos os valores na coluna 'valor_total'[cite: 39].
-- O 'AS' renomeia a coluna do resultado para 'faturamento_total' para maior clareza.
SELECT
    SUM(valor_total) AS faturamento_total
FROM
    compras;

-- ➡️ CONSULTA 2: Quantos clientes únicos fizeram compras no sistema? 
-- A função COUNT(DISTINCT cliente_id) conta apenas os valores únicos (distintos) de 'cliente_id'.
-- Isso evita que um mesmo cliente que fez várias compras seja contado mais de uma vez.
SELECT
    COUNT(DISTINCT cliente_id) AS total_clientes_compradores
FROM
    compras;

-- ➡️ CONSULTA 3: Qual é o valor médio gasto por compra?
-- A função AVG(valor_total) calcula a média aritmética de todos os valores na coluna 'valor_total'[cite: 46].
SELECT
    AVG(valor_total) AS valor_medio_por_compra
FROM
    compras;

-- ➡️ CONSULTA 4: Quantas compras foram feitas em um determinado mês? 
-- A função COUNT(*) conta o número total de linhas que satisfazem a condição[cite: 55].
SELECT
    COUNT(*) AS total_compras_em_julho
FROM
    compras -- A cláusula WHERE filtra os registros, selecionando apenas as compras [cite: 66, 96]
    -- cuja 'data_compra' esteja entre o primeiro e o último dia de julho de 2025.
WHERE
    data_compra BETWEEN '2025-07-01'
    AND '2025-07-31';