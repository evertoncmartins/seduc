-- 1. Criação do banco de dados (caso não exista)
CREATE DATABASE IF NOT EXISTS TechDynamics;
USE TechDynamics;

-- 2. Criação da tabela Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_ultima_compra DATE,
    status VARCHAR(50)
);

-- 3. Criação da tabela Produtos
CREATE TABLE IF NOT EXISTS Produtos (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(100),
    preco DECIMAL(10, 2),
    estoque INT,
    data_entrada DATE,
    status VARCHAR(50)
);

-- 4. Criação da tabela Fornecedores
CREATE TABLE IF NOT EXISTS Fornecedores (
    id_fornecedor INT PRIMARY KEY,
    nome_fornecedor VARCHAR(100)
);

-- 5. Criação da tabela Fornecedores_Produtos
CREATE TABLE IF NOT EXISTS Fornecedores_Produtos (
    id_fornecedor INT,
    id_produto INT,
    PRIMARY KEY (id_fornecedor, id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- 6. Criação da tabela Vendas
CREATE TABLE IF NOT EXISTS Vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    data_venda DATE,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- Inserção de dados na tabela Clientes
INSERT INTO Clientes (id_cliente, nome, email, data_ultima_compra, status) VALUES
(1, 'Ana Souza', 'ana@email.com', '2021-02-15', 'ativo'),
(2, 'Carlos Lima', 'carlos@email.com', '2019-08-10', 'inativo'),
(3, 'João Pedro', 'joao@email.com', '2020-12-05', 'ativo'),
(4, 'Mariana Silva', 'mariana@email.com', '2018-11-22', 'inadimplente'),
(5, 'Paula Costa', 'paula@email.com', '2017-07-09', 'inadimplente');

-- Inserção de dados na tabela Produtos
INSERT INTO Produtos (id_produto, nome_produto, preco, estoque, data_entrada, status) VALUES
(1, 'Notebook X1', 3500.00, 10, '2021-01-15', 'disponível'),
(2, 'Smartphone Z5', 1200.00, 0, '2019-05-20', 'fora de estoque'),
(3, 'Tablet A7', 900.00, 15, '2020-09-10', 'disponível'),
(4, 'Câmera D500', 2200.00, 0, '2018-03-25', 'fora de estoque');

-- Inserção de dados na tabela Fornecedores
INSERT INTO Fornecedores (id_fornecedor, nome_fornecedor) VALUES
(1, 'TechCorp'),
(2, 'Fornecedor Desconhecido'),
(3, 'Eletronix Solutions');

-- Inserção de dados na tabela Fornecedores_Produtos
INSERT INTO Fornecedores_Produtos (id_fornecedor, id_produto) VALUES
(1, 1),
(2, 2),
(2, 4),
(3, 3);

-- Inserção de dados na tabela Vendas
INSERT INTO Vendas (id_venda, id_cliente, id_produto, data_venda) VALUES
(1, 1, 1, '2021-03-10'),
(2, 3, 2, '2020-06-25'),
(3, 4, 3, '2019-04-17'),
(4, 5, 4, '2018-12-19');

-- 7. Verificação dos dados inseridos
SELECT 'Clientes' AS tabela, COUNT(*) AS registros FROM Clientes
UNION ALL
SELECT 'Produtos', COUNT(*) FROM Produtos
UNION ALL
SELECT 'Fornecedores', COUNT(*) FROM Fornecedores
UNION ALL
SELECT 'Fornecedores_Produtos', COUNT(*) FROM Fornecedores_Produtos
UNION ALL
SELECT 'Vendas', COUNT(*) FROM Vendas;

-- Primeiro verificamos quais registros serão afetados
SELECT id_cliente, nome, data_ultima_compra, status
FROM Clientes
WHERE status = 'inativo' 
AND data_ultima_compra < DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

-- Primeiro verificamos quais registros serão afetados
-- Desativa o safe update apenas para esta sessão
SET SQL_SAFE_UPDATES = 0;

-- Executa seu DELETE
DELETE FROM Clientes 
WHERE status = 'inativo' 
AND data_ultima_compra < DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

-- Reativa o safe update
SET SQL_SAFE_UPDATES = 1;

-- 7. Verificação dos dados inseridos
SELECT 'Clientes' AS tabela, COUNT(*) AS registros FROM Clientes
UNION ALL
SELECT 'Produtos', COUNT(*) FROM Produtos
UNION ALL
SELECT 'Fornecedores', COUNT(*) FROM Fornecedores
UNION ALL
SELECT 'Fornecedores_Produtos', COUNT(*) FROM Fornecedores_Produtos
UNION ALL
SELECT 'Vendas', COUNT(*) FROM Vendas;
