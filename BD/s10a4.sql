-- 1. Preparação: Criação e População Inicial
-- Nesta etapa, definimos as regras de integridade e inserimos os dados que servirão de base para os testes.

-- Criar o banco e tabelas
CREATE DATABASE IF NOT EXISTS tech_dynamics;
USE tech_dynamics;

-- Tabela de Produtos com restrição para não permitir estoque negativo
CREATE TABLE IF NOT EXISTS Produtos (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(100),
    estoque INT,
    CONSTRAINT chk_estoque_positivo CHECK (estoque >= 0)
);

CREATE TABLE IF NOT EXISTS Clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    data_venda DATE,
    quantidade INT
);

-- INSERÇÕES INICIAIS (DADOS REAIS PARA TESTE)
INSERT INTO Clientes (id_cliente, nome) VALUES 
(1, 'Ana Souza'), (2, 'Carlos Lima'), (3, 'João Pedro');

INSERT INTO Produtos (id_produto, nome_produto, estoque) VALUES 
(1, 'Notebook X1', 5), 
(2, 'Mouse Gamer', 1), 
(3, 'Teclado Mecânico', 10);

-- Verificar estado inicial
SELECT * FROM Produtos;





-- 2. Cenário A: Transação Bem-Sucedida
-- Aqui demonstramos como o COMMIT confirma as alterações quando tudo corre bem.
-- Inicia a transação [cite: 193]
START TRANSACTION; 

-- Registra a venda
INSERT INTO Vendas (id_venda, id_cliente, id_produto, data_venda, quantidade) 
VALUES (10, 1, 1, CURDATE(), 1);

-- Baixa o estoque (5 -> 4) [cite: 199]
UPDATE Produtos SET estoque = estoque - 1 WHERE id_produto = 1;

-- Confirma as alterações permanentemente [cite: 194, 200, 225]
COMMIT; 

-- Verificação: A venda existe e o estoque diminuiu.
SELECT * FROM Vendas WHERE id_venda = 10;
SELECT * FROM Produtos WHERE id_produto = 1;





-- 3. Cenário B: Simulação de Erro e ROLLBACK
-- Este cenário força uma violação da regra de estoque, gerando um erro real no MySQL e exigindo o cancelamento da operação.
-- Tentativa de venda de produto com estoque insuficiente
START TRANSACTION;

-- Passo 1: Inserir a venda de 2 unidades do Mouse (só temos 1)
INSERT INTO Vendas (id_venda, id_cliente, id_produto, data_venda, quantidade) 
VALUES (11, 2, 2, CURDATE(), 2);

-- Passo 2: Tentar baixar o estoque (O MySQL travará aqui devido à CONSTRAINT)
UPDATE Produtos SET estoque = estoque - 2 WHERE id_produto = 2;

-- ERRO ESPERADO: Check constraint 'chk_estoque_positivo' is violated.

-- Passo 3: Como o erro impediu o UPDATE, devemos desfazer o Passo 1 [cite: 195, 202]
ROLLBACK;

-- Verificação: A venda 11 NÃO deve existir e o estoque deve continuar 1.
SELECT * FROM Vendas WHERE id_venda = 11;
SELECT * FROM Produtos WHERE id_produto = 2;




-- 4. Cenário C: Isolamento de Transações (SERIALIZABLE)
-- Demonstração de como definir o nível mais alto de isolamento para evitar conflitos em acessos simultâneos.
-- Define o nível máximo de segurança [cite: 214, 231]
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

START TRANSACTION;

-- Se outra pessoa tentar vender o mesmo produto agora, ela ficará "na fila"
INSERT INTO Vendas (id_venda, id_cliente, id_produto, data_venda, quantidade) 
VALUES (12, 3, 3, CURDATE(), 1);

UPDATE Produtos SET estoque = estoque - 1 WHERE id_produto = 3;

COMMIT;