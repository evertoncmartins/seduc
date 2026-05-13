-- ======================================================
-- 1. CRIAÇÃO DO BANCO E TABELAS (TECH DYNAMICS)
-- ======================================================
CREATE DATABASE IF NOT EXISTS tech_dynamics;
USE tech_dynamics;

-- Tabela Clientes [cite: 121, 122]
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_ultima_compra DATE,
    status VARCHAR(50)
);

-- Tabela Produtos [cite: 124, 125]
CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(100),
    preco DECIMAL(10, 2),
    estoque INT,
    data_entrada DATE,
    status VARCHAR(50)
);

-- Tabela Fornecedores [cite: 127, 128]
CREATE TABLE Fornecedores (
    id_fornecedor INT PRIMARY KEY,
    nome_fornecedor VARCHAR(100)
);

-- Tabela Associativa Fornecedores_Produtos [cite: 130, 131]
CREATE TABLE Fornecedores_Produtos (
    id_fornecedor INT,
    id_produto INT,
    PRIMARY KEY (id_fornecedor, id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- Tabela Vendas [cite: 133, 134]
CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    data_venda DATE,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- ======================================================
-- 2. POPULANDO O BANCO (DADOS INICIAIS)
-- ======================================================
INSERT INTO Clientes VALUES 
(1, 'Ana Souza', 'ana@email.com', '2021-02-15', 'ativo'),
(2, 'Carlos Lima', 'carlos@email.com', '2019-08-10', 'inativo'),
(3, 'João Pedro', 'joao@email.com', '2020-12-05', 'ativo'),
(4, 'Mariana Silva', 'mariana@email.com', '2018-11-22', 'inadimplente'),
(5, 'Paula Costa', 'paula@email.com', '2017-07-09', 'inadimplente'); [cite: 123]

INSERT INTO Produtos VALUES 
(1, 'Notebook X1', 3500.00, 10, '2021-01-15', 'disponível'),
(2, 'Smartphone Z5', 1200.00, 0, '2019-05-20', 'fora de estoque'),
(3, 'Tablet A7', 900.00, 15, '2020-09-10', 'disponível'),
(4, 'Câmera D500', 2200.00, 0, '2018-03-25', 'fora de estoque'); [cite: 126]

INSERT INTO Fornecedores VALUES 
(1, 'TechCorp'), (2, 'Fornecedor Desconhecido'), (3, 'Eletronix Solutions'); [cite: 129]

INSERT INTO Fornecedores_Produtos VALUES (1, 1), (2, 2), (2, 4), (3, 3); [cite: 132]

INSERT INTO Vendas VALUES 
(1, 1, 1, '2021-03-10'), (2, 3, 2, '2020-06-25'), (3, 4, 3, '2019-04-17'), (4, 5, 4, '2018-12-19'); [cite: 135]


-- ======================================================
-- 3. TAREFA 4: VERIFICAÇÃO SEGURA (SELECT ANTES DO DELETE)
-- ======================================================

-- Verificação da Tarefa 1 (Clientes inativos > 3 anos) [cite: 175, 176]
SELECT * FROM Clientes WHERE status = 'inativo' AND data_ultima_compra < '2023-05-12';

-- Verificação da Tarefa 2 (Produtos do Fornecedor Desconhecido) [cite: 178]
SELECT p.* FROM Produtos p 
JOIN Fornecedores_Produtos fp ON p.id_produto = fp.id_produto 
JOIN Fornecedores f ON fp.id_fornecedor = f.id_fornecedor 
WHERE f.nome_fornecedor = 'Fornecedor Desconhecido';

-- Verificação da Tarefa 3 (Vendas de clientes inadimplentes) [cite: 176]
SELECT * FROM Vendas WHERE id_cliente IN (SELECT id_cliente FROM Clientes WHERE status = 'inadimplente');


-- ======================================================
-- 4. EXCLUSÃO DOS DADOS (TAREFAS 1, 2 E 3)
-- ======================================================

-- Tarefa 1: Exclusão básica por status e data [cite: 164, 165]
-- Considerando que hoje é maio de 2026, "mais de 3 anos" retrocede a 2023.
DELETE FROM Clientes 
WHERE status = 'inativo' AND data_ultima_compra < '2023-05-12';

-- Tarefa 2: Exclusão com JOIN [cite: 167, 168]
-- Remove produtos associados a um fornecedor específico.
DELETE p FROM Produtos p 
JOIN Fornecedores_Produtos fp ON p.id_produto = fp.id_produto 
JOIN Fornecedores f ON fp.id_fornecedor = f.id_fornecedor 
WHERE f.nome_fornecedor = 'Fornecedor Desconhecido';

-- Tarefa 3: Exclusão condicional com Subconsulta [cite: 170, 171, 173]
-- Remove apenas os registros de vendas vinculados a clientes inadimplentes.
DELETE FROM Vendas 
WHERE id_cliente IN (SELECT id_cliente FROM Clientes WHERE status = 'inadimplente');

-- ======================================================
-- VERIFICAÇÃO FINAL DOS RESULTADOS
-- ======================================================
SELECT 'Clientes Restantes' as Info, COUNT(*) FROM Clientes;
SELECT 'Produtos Restantes' as Info, COUNT(*) FROM Produtos;
SELECT 'Vendas Restantes' as Info, COUNT(*) FROM Vendas;