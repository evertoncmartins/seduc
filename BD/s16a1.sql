CREATE DATABASE empresa_tech;

USE empresa_tech;


CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);


CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome_do_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);


CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    data_do_pedido DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    id_cliente INT NOT NULL,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE TABLE itens_pedido (
    id_item INT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,

    FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (id_produto)
        REFERENCES produtos(id_produto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


INSERT INTO clientes
(id_cliente, nome, email, telefone)
VALUES
(1, 'Ana Silva', 'ana@email.com', '1699999-1111'),
(2, 'Carlos Souza', 'carlos@email.com', '1699999-2222'),
(3, 'Mariana Lima', 'mariana@email.com', '1699999-3333');


INSERT INTO produtos
(id_produto, nome_do_produto, preco)
VALUES
(1, 'Notebook', 3500.00),
(2, 'Mouse', 80.00),
(3, 'Teclado', 150.00),
(4, 'Monitor', 900.00),
(5, 'Headset', 250.00);


INSERT INTO pedidos
(id_pedido, data_do_pedido, valor_total, id_cliente)
VALUES
(101, '2026-08-10', 3810.00, 1),
(102, '2026-08-10', 1150.00, 2);


INSERT INTO itens_pedido
(id_item, id_pedido, id_produto, quantidade)
VALUES
(1, 101, 1, 1),
(2, 101, 2, 2),
(3, 101, 3, 1),
(4, 102, 4, 1),
(5, 102, 5, 1);


SELECT * FROM clientes;

SELECT * FROM produtos;

SELECT * FROM pedidos;

SELECT * FROM itens_pedido;


SELECT
    pedidos.id_pedido,
    clientes.nome,
    produtos.nome_do_produto,
    itens_pedido.quantidade
FROM pedidos

JOIN clientes
    ON pedidos.id_cliente = clientes.id_cliente

JOIN itens_pedido
    ON pedidos.id_pedido = itens_pedido.id_pedido

JOIN produtos
    ON itens_pedido.id_produto = produtos.id_produto;


    -- 1º: Apague os itens de dentro do pedido
DELETE FROM itens_pedido WHERE id_pedido = 101;

-- 2º: Agora que o pedido está vazio, você pode apagá-lo
DELETE FROM pedidos WHERE id_pedido = 101;

-- 3º: Agora que a cliente não tem mais pedidos, você pode apagá-la
DELETE FROM clientes WHERE id_cliente = 1;

SELECT * FROM clientes;
SELECT * from pedidos;