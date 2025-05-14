-- 1. Criação do banco de dados TechDynamics
CREATE DATABASE IF NOT EXISTS TechDynamics;
USE TechDynamics;

-- 2. Criação das tabelas
CREATE TABLE IF NOT EXISTS Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    preco DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_produto INT NOT NULL,
    data_venda DATE NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- 3. Inserção de dados iniciais
-- Produtos
INSERT INTO Produtos (nome, estoque, preco) VALUES
('Notebook Elite', 10, 4500.00),
('Smartphone Pro', 15, 3200.00),
('Tablet Advanced', 8, 1800.00),
('Monitor 4K', 12, 2200.00);

-- Clientes
INSERT INTO Clientes (nome, email) VALUES
('João Silva', 'joao@email.com'),
('Maria Oliveira', 'maria@email.com'),
('Carlos Souza', 'carlos@email.com'),
('Ana Pereira', 'ana@email.com'),
('Pedro Costa', 'pedro@email.com');

-- Verificação dos dados inseridos
SELECT * FROM Produtos;
SELECT * FROM Clientes;
SELECT * FROM Vendas;


--- Tarefa 1: Transação Simples (COMMIT)------------------------------------------------------
USE TechDynamics;

-- Verificar estoque antes da venda
SELECT id_produto, nome, estoque FROM Produtos WHERE id_produto = 3;

START TRANSACTION;

-- Inserir nova venda
INSERT INTO Vendas (id_cliente, id_produto, data_venda, quantidade)
VALUES (3, 3, '2024-09-05', 1);

-- Atualizar estoque
UPDATE Produtos
SET estoque = estoque - 1
WHERE id_produto = 3;

COMMIT;

-- Verificar estoque após a venda
SELECT id_produto, nome, estoque FROM Produtos WHERE id_produto = 3;
SELECT * FROM Vendas;
-- -------------------------------------------------------------------------------------------


--- Tarefa 2: Testando ROLLBACK---------------------------------------------------------------
USE TechDynamics;

-- Verificar estado atual
SELECT id_produto, nome, estoque FROM Produtos WHERE id_produto = 2;
SELECT * FROM Vendas WHERE id_produto = 2;

START TRANSACTION;

-- Inserir nova venda
INSERT INTO Vendas (id_cliente, id_produto, data_venda, quantidade)
VALUES (4, 2, '2024-09-05', 1);

-- Simular erro (estoque insuficiente)
-- Suponha que verificamos e o estoque é 0
SELECT estoque FROM Produtos WHERE id_produto = 2 FOR UPDATE;

-- Decidir fazer ROLLBACK
ROLLBACK;

-- Verificar que a venda não foi inserida
SELECT * FROM Vendas WHERE id_produto = 2;
-- -------------------------------------------------------------------------------------------


-- Tarefa 3: Nível de Isolamento SERIALIZABLE------------------------------------------------
USE TechDynamics;

-- Primeiro terminal/sessão
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;

-- Inserir nova venda
INSERT INTO Vendas (id_cliente, id_produto, data_venda, quantidade)
VALUES (5, 4, '2024-09-05', 1);

-- Deixar esta transação aberta (não fazer COMMIT ainda)

-- Segundo terminal/sessão (abra uma nova conexão ao MySQL)
-- Tentar fazer uma operação concorrente
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
-- Esta operação ficará bloqueada até a primeira transação ser concluída
UPDATE Produtos SET estoque = estoque - 1 WHERE id_produto = 4;

-- Voltar ao primeiro terminal e fazer COMMIT
COMMIT;

-- Para testar a venda realizada
SELECT * FROM produtos WHERE id_produto = 4;

-- Agora a segunda transação será desbloqueada e poderá continuar
-- -------------------------------------------------------------------------------------------