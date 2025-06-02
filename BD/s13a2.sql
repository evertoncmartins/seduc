-- Criação do banco de dados
CREATE DATABASE datasoft_limpeza;

-- Usar o banco
USE datasoft_limpeza;

-- Tabela de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_cadastro DATE
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Clientes cadastrados
INSERT INTO clientes (nome, email, data_cadastro) VALUES
('Ana', 'ana@email.com', '2020-01-10'),
('Bruno', 'bruno@email.com', '2021-05-12'),
('Clara', 'clara@email.com', '2022-07-01'),
('Daniel', 'daniel@email.com', '2023-08-15'),
('Eduarda', 'eduarda@email.com', '2021-03-20');

-- Pedidos feitos por alguns clientes
INSERT INTO pedidos (id_cliente, data_pedido, status) VALUES
(1, '2020-02-01', 'Entregue'),
(2, '2021-05-15', 'Entregue'),
(3, '2024-04-20', 'Pendente'),
(4, '2024-03-10', 'Enviado');



-- 🔎 1. Verificar pedidos antigos (com mais de 2 anos)
-- Verifica pedidos feitos há mais de 2 anos
SELECT * FROM pedidos
WHERE data_pedido < CURDATE() - INTERVAL 2 YEAR;



-- 🧹 2. Parte Técnica – Excluir pedidos antigos e depois clientes sem pedidos

-- 2.1 Excluir pedidos antigos (com mais de 2 anos)
-- Desativa safe mode apenas para esta sessão
SET SQL_SAFE_UPDATES = 0;

-- Agora pode executar a exclusão normalmente
DELETE FROM pedidos
WHERE data_pedido < CURDATE() - INTERVAL 2 YEAR;

-- Verificar pedidos restantes
SELECT * FROM pedidos;

-- 2.2 Ver clientes sem nenhum pedido associado
SELECT * FROM clientes
WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM pedidos);

-- 2.3 Excluir esses clientes
DELETE FROM clientes
WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM pedidos);

-- Verificar clientes restantes
SELECT * FROM clientes;

-- (Opcional) Reativar depois, se quiser
SET SQL_SAFE_UPDATES = 1;