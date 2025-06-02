-- 🧱 ETAPA 1 – Criação do banco e uso
-- Cria o banco de dados
CREATE DATABASE techsmart;

-- Seleciona o banco para uso
USE techsmart;

-- Tabela de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    tipo_cliente ENUM('online', 'físico')
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela de clientes premiados
CREATE TABLE clientes_premiados (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    data_premiacao DATETIME
);

-- Inserindo clientes
INSERT INTO clientes (nome, email, tipo_cliente) VALUES
('Alice', 'alice@exemplo.com', 'online'),
('Bruno', 'bruno@exemplo.com', 'online'),
('Carla', 'carla@exemplo.com', 'físico'),
('Diego', 'diego@exemplo.com', 'online'),
('Eva', 'eva@exemplo.com', 'online');

-- Inserindo pedidos
INSERT INTO pedidos (id_cliente, data_pedido, valor_total) VALUES
(1, '2024-01-10', 250.00),
(1, '2024-02-15', 199.99),
(1, '2024-03-20', 320.00),
(2, '2024-01-01', 150.00),
(2, '2024-02-01', 180.00),
(3, '2024-01-05', 100.00),
(4, '2024-03-01', 200.00),
(4, '2024-04-01', 220.00),
(4, '2024-05-01', 240.00),
(5, '2024-03-05', 130.00);

-- 🏆 ETAPA 2 – Inserção condicional com JOIN, GROUP BY e NOT EXISTS
INSERT INTO clientes_premiados (id_cliente, nome, data_premiacao)
SELECT c.id_cliente, c.nome, NOW()
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE c.tipo_cliente = 'online'
GROUP BY c.id_cliente, c.nome
HAVING COUNT(p.id_pedido) >= 3
AND NOT EXISTS (
    SELECT 1
    FROM clientes_premiados cp
    WHERE cp.id_cliente = c.id_cliente
);

-- ✅ ETAPA 3 – Verificação dos premiados
-- Verifica quais clientes foram premiados
SELECT * FROM clientes_premiados;


/* 
📘 O que esse código faz (explicação didática)
- JOIN: conecta a tabela de clientes com seus pedidos.
- WHERE: filtra apenas clientes do tipo 'online'.
- GROUP BY: agrupa os pedidos por cliente.
- HAVING COUNT >= 3: só seleciona quem tem 3 ou mais pedidos.
- NOT EXISTS: impede que clientes já premiados sejam inseridos de novo.
- NOW(): registra a data/hora atual como momento da premiação.
*/