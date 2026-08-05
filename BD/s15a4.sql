-- =========================================================
-- 1. CRIAÇÃO DAS TABELAS
-- =========================================================

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE fornecedores (
    id_fornecedor INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    contato VARCHAR(100),
    endereco VARCHAR(150)
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2),
    estoque INT,
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)
);

CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT,
    data_venda DATE,
    valor_total DECIMAL(10,2),
    status_venda VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE itens_venda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- =========================================================
-- 2. DADOS INICIAIS
-- =========================================================

INSERT INTO clientes
(id_cliente, nome, email, telefone)
VALUES
(101, 'Ana Souza', 'ana@email.com', '11999991010'),
(102, 'Bruno Lima', 'bruno@email.com', '11999992020'),
(103, 'Carla Mendes', 'carla@email.com', '11999993030');

INSERT INTO fornecedores
(id_fornecedor, nome, contato, endereco)
VALUES
(201, 'GlobalTech', 'contato@globaltech.com', 'Av. das Indústrias, 500'),
(202, 'InfoParts', 'vendas@infoparts.com', 'Rua da Tecnologia, 120'),
(203, 'Digital Supply', 'contato@digitalsupply.com', 'Av. dos Computadores, 900');

INSERT INTO produtos
(id_produto, nome, preco, estoque, id_fornecedor)
VALUES
(401, 'Notebook Pro', 3500.00, 15, 201),
(402, 'Monitor 24 polegadas', 850.00, 30, 202),
(403, 'Teclado Mecânico', 320.00, 40, 203),
(404, 'Mouse Óptico', 90.00, 60, 203);

INSERT INTO vendas
(id_venda, id_cliente, data_venda, valor_total, status_venda)
VALUES
(301, 101, '2026-07-20', 4350.00, 'Concluída'),
(302, 101, '2026-07-22', 410.00, 'Concluída'),
(303, 102, '2026-07-24', 850.00, 'Cancelada'),
(304, 103, '2026-07-25', 180.00, 'Concluída');

INSERT INTO itens_venda
(id_venda, id_produto, quantidade, preco_unitario)
VALUES
(301, 401, 1, 3500.00),
(301, 402, 1, 850.00),
(302, 403, 1, 320.00),
(302, 404, 1, 90.00),
(303, 402, 1, 850.00),
(304, 404, 2, 90.00);

-- =========================================================
-- 3. SELECT PEDIDO NO EXERCÍCIO
-- Mostrar todas as vendas do cliente de ID 101.
-- Não precisa de JOIN, pois o id_cliente já está na tabela vendas.
-- =========================================================

SELECT *
FROM vendas
WHERE id_cliente = 101;

-- =========================================================
-- 4. CONSULTA EXTRA COM JOIN
-- Mostrar o nome do cliente em cada venda.
-- O JOIN é necessário porque o nome está na tabela clientes.
-- =========================================================

SELECT
    vendas.id_venda,
    vendas.data_venda,
    clientes.nome AS cliente,
    vendas.valor_total,
    vendas.status_venda
FROM vendas
INNER JOIN clientes
    ON vendas.id_cliente = clientes.id_cliente;

-- =========================================================
-- 5. CONSULTA EXTRA COM JOIN
-- Mostrar os produtos de cada venda.
-- O JOIN é necessário porque os dados estão em tabelas diferentes.
-- =========================================================

SELECT
    itens_venda.id_venda,
    produtos.nome AS produto,
    itens_venda.quantidade,
    itens_venda.preco_unitario
FROM itens_venda
INNER JOIN produtos
    ON itens_venda.id_produto = produtos.id_produto;

-- =========================================================
-- 6. INSERT PEDIDO NO EXERCÍCIO
-- O fornecedor GlobalTech já foi inserido nos dados iniciais.
-- Para fazer apenas a atividade separadamente, use:
-- =========================================================

-- INSERT INTO fornecedores
-- (id_fornecedor, nome, contato, endereco)
-- VALUES
-- (201, 'GlobalTech', 'contato@globaltech.com',
--  'Av. das Indústrias, 500');

SELECT *
FROM fornecedores
WHERE id_fornecedor = 201;

-- =========================================================
-- 7. UPDATE PEDIDO NO EXERCÍCIO
-- =========================================================

UPDATE fornecedores
SET endereco = 'Av. das Indústrias, 550'
WHERE id_fornecedor = 201;

SELECT *
FROM fornecedores
WHERE id_fornecedor = 201;

-- =========================================================
-- 8. DELETE PEDIDO NO EXERCÍCIO
-- Primeiro apagamos os itens ligados à venda.
-- Depois apagamos a venda.
-- =========================================================

DELETE FROM itens_venda
WHERE id_venda = 303;

DELETE FROM vendas
WHERE id_venda = 303;

SELECT *
FROM vendas
WHERE id_venda = 303;

-- =========================================================
-- 9. CONSULTAS SIMPLES PARA CONFERÊNCIA
-- =========================================================

SELECT * FROM clientes;
SELECT * FROM fornecedores;
SELECT * FROM produtos;
SELECT * FROM vendas;
SELECT * FROM itens_venda;