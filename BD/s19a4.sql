-- =========================================================
-- ATIVIDADE: TRANSACOES COM DML
-- SGBD: MySQL
-- =========================================================

-- 1. CRIAR O BANCO DE DADOS

DROP DATABASE IF EXISTS loja_virtual;
CREATE DATABASE loja_virtual;
USE loja_virtual;


-- 2. CRIAR AS TABELAS

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    endereco VARCHAR(255)
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    status VARCHAR(30) NOT NULL,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);

CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido),

    FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto)
);


-- 3. CADASTRAR O PRODUTO DA ATIVIDADE

INSERT INTO produtos (id_produto, nome, tipo, preco)
VALUES (101, 'Curso de Banco de Dados', 'Digital', 299.90);


-- 4. INICIAR A TRANSACAO

START TRANSACTION;


-- 5. CADASTRAR O CLIENTE CARLOS MENDES

INSERT INTO clientes (nome, email, endereco)
VALUES (
    'Carlos Mendes',
    'carlos@email.com',
    'Rua das Flores, 789'
);

-- Guardar o codigo do cliente que acabou de ser criado.
SET @id_cliente = LAST_INSERT_ID();


-- 6. CADASTRAR O PEDIDO

INSERT INTO pedidos (id_cliente, data_pedido, status)
VALUES (
    @id_cliente,
    CURRENT_DATE,
    'Em Processamento'
);

-- Guardar o codigo do pedido que acabou de ser criado.
SET @id_pedido = LAST_INSERT_ID();


-- 7. CADASTRAR O ITEM DO PEDIDO
-- Carlos comprou duas unidades do produto 101.

INSERT INTO itens_pedido (
    id_pedido,
    id_produto,
    quantidade,
    preco
)
VALUES (
    @id_pedido,
    101,
    2,
    299.90
);


-- 8. CONFIRMAR A TRANSACAO
-- Como nao ocorreu nenhum erro, os dados serao salvos.

COMMIT;


-- 9. CONSULTAR OS DADOS CADASTRADOS

SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM pedidos;
SELECT * FROM itens_pedido;


-- Consulta completa do pedido de Carlos Mendes.

SELECT
    pedidos.id_pedido,
    clientes.nome AS cliente,
    produtos.nome AS produto,
    produtos.tipo,
    itens_pedido.quantidade,
    itens_pedido.preco,
    itens_pedido.quantidade * itens_pedido.preco AS total,
    pedidos.status
FROM pedidos
INNER JOIN clientes
    ON clientes.id_cliente = pedidos.id_cliente
INNER JOIN itens_pedido
    ON itens_pedido.id_pedido = pedidos.id_pedido
INNER JOIN produtos
    ON produtos.id_produto = itens_pedido.id_produto;


-- =========================================================
-- EXEMPLO SIMPLES DE ROLLBACK
-- =========================================================
-- Neste exemplo, o cliente e inserido, mas a transacao e cancelada.

START TRANSACTION;

INSERT INTO clientes (nome, email, endereco)
VALUES (
    'Cliente de Teste',
    'teste@email.com',
    'Rua de Teste, 100'
);

-- Cancelar tudo o que foi feito depois de START TRANSACTION.
ROLLBACK;

-- A consulta deve retornar zero registros.
SELECT *
FROM clientes
WHERE email = 'teste@email.com';


-- =========================================================
-- EXEMPLO DE ERRO: PRODUTO INEXISTENTE
-- =========================================================
-- O produto 999 nao existe. A chave estrangeira impede a insercao.
-- Depois do erro, execute ROLLBACK para cancelar a transacao.
-- Este exemplo esta comentado para nao interromper o arquivo.

-- START TRANSACTION;

-- INSERT INTO itens_pedido (
--     id_pedido,
--     id_produto,
--     quantidade,
--     preco
-- )
-- VALUES (
--     @id_pedido,
--     999,
--     1,
--     100.00
-- );

-- ROLLBACK;


-- =========================================================
-- RESPOSTAS PARA O AVA
-- =========================================================
--
-- 1. Se ocorrer um erro ao inserir o item do pedido, deve-se usar
-- ROLLBACK. Esse comando cancela todas as operacoes realizadas
-- depois de START TRANSACTION.
--
-- 2. O ROLLBACK evita que apenas uma parte do pedido fique gravada.
-- Assim, cliente, pedido e itens sao salvos juntos com COMMIT ou
-- cancelados juntos com ROLLBACK.

