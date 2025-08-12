CREATE DATABASE ecommerce_joins_db;

USE ecommerce_joins_db;

CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE compras (
    compra_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    valor_total DECIMAL(10, 2) NOT NULL,
    data_compra DATE NOT NULL
);

INSERT INTO
    clientes (nome, email)
VALUES
    ('João Silva', 'joao.silva@example.com'),
    ('Maria Oliveira', 'maria.oliveira@example.com'),
    ('Carlos Pereira', 'carlos.pereira@example.com'),
    ('Beatriz Lima', 'beatriz.lima@example.com');

INSERT INTO
    compras (cliente_id, valor_total, data_compra)
VALUES
    (1, 150.75, '2025-07-15'),
    (2, 89.90, '2025-07-16'),
    (1, 299.99, '2025-07-18'),
    (3, 1200.00, '2025-07-20'),
    (NULL, 50.00, '2025-07-21'),
    -- Compra com cliente_id nulo
    (99, 15.00, '2025-07-22');

-- Compra com cliente_id inválido
-- ➡️ CONSULTA 1: Relacionamento completo entre clientes e compras (INNER JOIN)
-- O INNER JOIN combina as linhas de 'clientes' e 'compras' apenas quando a condição de junção (cliente_id) é encontrada em AMBAS as tabelas.
SELECT
    c.nome,
    c.email,
    co.valor_total
FROM
    clientes c
    INNER JOIN compras co USING (cliente_id);

-- ➡️ CONSULTA 2: Exibindo todos os clientes, mesmo os que não compraram (LEFT JOIN)
-- O LEFT JOIN pega todos os registros da tabela da esquerda (clientes) e os combina com os registros correspondentes da tabela da direita (compras).
-- Se não houver correspondência, as colunas da tabela da direita (valor_total) virão como NULL.
SELECT
    c.nome,
    c.email,
    co.valor_total
FROM
    clientes c
    LEFT JOIN compras co USING (cliente_id);

-- ➡️ CONSULTA 3: Exibindo todas as compras, mesmo que clientes não estejam registrados (RIGHT JOIN) (por exemplo, em casos de dados incompletos ou clientes removidos do sistema)
-- O RIGHT JOIN faz o oposto do LEFT JOIN. Ele retorna todos os registros da tabela da direita (compras) e os combina com a da esquerda (clientes).
-- Se uma compra não tiver um cliente_id correspondente, as colunas de cliente virão como NULL.
SELECT
    c.nome,
    c.email,
    co.compra_id,
    co.valor_total,
    co.data_compra
FROM
    clientes c
    RIGHT JOIN compras co USING (cliente_id);