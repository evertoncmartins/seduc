-- Cria um banco de dados chamado techsolutions
CREATE DATABASE techsolutions;

-- Usa o banco de dados criado
USE techsolutions;

-- Cria a tabela de clientes com campos básicos
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- Identificador único
    nome VARCHAR(100) NOT NULL,               -- Nome do cliente
    email VARCHAR(100) UNIQUE NOT NULL,       -- E-mail único
    telefone VARCHAR(20),                     -- Telefone opcional
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP 
);

-- Cria a tabela de produtos
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- ID do produto
    nome VARCHAR(100) NOT NULL,               -- Nome do produto
    preco DECIMAL(10,2) NOT NULL,             -- Preço com 2 casas decimais
    estoque INT DEFAULT 0                     -- Quantidade em estoque
);

-- Cria a tabela de vendas, com chaves estrangeiras para clientes e produtos
CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- ID da venda
    cliente_id INT,                           -- FK para cliente
    produto_id INT,                           -- FK para produto
    quantidade INT NOT NULL,                  -- Quantidade vendida
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,-- Data da venda
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

INSERT INTO clientes (nome, email, telefone) VALUES
('João Silva', 'joao@gmail.com', '11999998888'),
('Maria Oliveira', 'maria@gmail.com', '11888887777'),
('Carlos Souza', 'carlos@gmail.com', '11777776666');

INSERT INTO produtos (nome, preco, estoque) VALUES
('Notebook Dell', 3500.00, 10),
('Mouse Logitech', 150.50, 30),
('Teclado Mecânico', 250.00, 20);

INSERT INTO vendas (cliente_id, produto_id, quantidade) VALUES
(1, 1, 1),  -- João comprou 1 Notebook
(2, 2, 2),  -- Maria comprou 2 Mouses
(3, 3, 1);  -- Carlos comprou 1 Teclado

-- Seleciona todos os clientes
SELECT * FROM clientes;

--- Selecion nome, preco e estoque de produtos onde estoque > 0
SELECT nome, preco, estoque FROM produtos WHERE estoque > 0;

SELECT 
    v.id AS id_venda,
    c.nome AS cliente,
    p.nome AS produto,
    v.quantidade,
    v.data_venda
FROM vendas v
JOIN clientes c ON v.cliente_id = c.id
JOIN produtos p ON v.produto_id = p.id;

-- Atualiza o telefone de um cliente
UPDATE clientes
SET telefone = '11912345678'
WHERE id = 1;

-- Remove uma venda específica
DELETE FROM vendas
WHERE id = 2;