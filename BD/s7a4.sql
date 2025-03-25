-- Criação do banco de dados
CREATE DATABASE ecommerceDB;
USE ecommerceDB;

-- Tabela de categorias
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT
);

-- Tabela de produtos
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    id_categoria INT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Tabela de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL, -- Armazenada como hash
    endereco TEXT NOT NULL,
    telefone VARCHAR(20),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'processando', 'enviado', 'entregue', 'cancelado') DEFAULT 'pendente',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela de itens do pedido
CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- Índices para tabela de produtos
CREATE INDEX idx_produtos_nome ON produtos(nome);
CREATE INDEX idx_produtos_categoria ON produtos(id_categoria);
CREATE INDEX idx_produtos_preco ON produtos(preco);

-- Índices para tabela de clientes
CREATE INDEX idx_clientes_nome ON clientes(nome, sobrenome);
CREATE INDEX idx_clientes_email ON clientes(email);

-- Índices para tabela de pedidos
CREATE INDEX idx_pedidos_cliente ON pedidos(id_cliente);
CREATE INDEX idx_pedidos_data ON pedidos(data_pedido);
CREATE INDEX idx_pedidos_status ON pedidos(status);

-- Índices para tabela de itens_pedido
CREATE INDEX idx_itens_pedido ON itens_pedido(id_pedido, id_produto);

-- Inserindo categorias
INSERT INTO categorias (nome, descricao) VALUES
('Eletrônicos', 'Dispositivos eletrônicos e acessórios'),
('Roupas', 'Vestuário masculino, feminino e infantil'),
('Livros', 'Livros de diversos gêneros literários'),
('Casa', 'Produtos para casa e decoração');

-- Inserindo produtos
INSERT INTO produtos (nome, descricao, preco, estoque, id_categoria) VALUES
('Smartphone X', 'Última geração com câmera tripla', 2999.90, 50, 1),
('Notebook Pro', '16GB RAM, SSD 512GB, tela 15.6"', 4599.00, 30, 1),
('Camiseta Básica', '100% algodão, várias cores', 49.90, 200, 2),
('Dom Casmurro', 'Clássico da literatura brasileira', 29.90, 100, 3),
('Jogo de Panelas', '5 peças antiaderentes', 199.90, 40, 4);

-- Inserindo clientes
INSERT INTO clientes (nome, sobrenome, email, senha, endereco, telefone) VALUES
('João', 'Silva', 'joao.silva@email.com', SHA2('senha123', 256), 'Rua A, 123 - Centro', '(11) 9999-8888'),
('Maria', 'Santos', 'maria.santos@email.com', SHA2('abc456', 256), 'Av. B, 456 - Jardim', '(11) 7777-6666');

-- Inserindo pedidos
INSERT INTO pedidos (id_cliente, status) VALUES
(1, 'entregue'),
(2, 'processando');

-- Inserindo itens dos pedidos
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 2999.90),
(1, 3, 2, 49.90),
(2, 2, 1, 4599.00),
(2, 4, 3, 29.90);


-- Inserir novo produto
INSERT INTO produtos (nome, descricao, preco, estoque, id_categoria) 
VALUES ('Fone Bluetooth', 'Fone sem fio com 20h de bateria', 199.90, 80, 1);

-- Inserir novo cliente
INSERT INTO clientes (nome, sobrenome, email, senha, endereco, telefone)
VALUES ('Carlos', 'Oliveira', 'carlos.oliveira@email.com', SHA2('senha456', 256), 'Rua C, 789 - Vila', '(11) 5555-4444');


-- Listar todos os produtos
SELECT * FROM produtos;

-- Buscar cliente por email
SELECT * FROM clientes WHERE email = 'joao.silva@email.com';

-- Ver pedidos de um cliente
SELECT p.* FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE c.email = 'maria.santos@email.com';


-- Atualizar preço de um produto
UPDATE produtos SET preco = 3199.90 WHERE id_produto = 1;

-- Atualizar endereço de cliente
UPDATE clientes SET endereco = 'Av. D, 1010 - Centro' WHERE id_cliente = 2;


-- Marcar produto como descontinuado (exclusão lógica)
UPDATE produtos SET estoque = 0 WHERE id_produto = 5;

-- Excluir produto (exclusão física - cuidado!)
DELETE FROM produtos WHERE id_produto = 5 AND estoque = 0;

-- Produtos mais vendidos
SELECT 
    p.nome AS produto,
    SUM(i.quantidade) AS total_vendido,
    SUM(i.quantidade * i.preco_unitario) AS valor_total_vendido
FROM itens_pedido i
JOIN produtos p ON i.id_produto = p.id_produto
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 10;

-- Clientes que mais gastaram
SELECT 
    CONCAT(c.nome, ' ', c.sobrenome) AS cliente,
    COUNT(p.id_pedido) AS total_pedidos,
    SUM(i.quantidade * i.preco_unitario) AS total_gasto
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN itens_pedido i ON p.id_pedido = i.id_pedido
GROUP BY c.id_cliente
ORDER BY total_gasto DESC
LIMIT 10;

-- Faturamento total por mês
SELECT 
    YEAR(p.data_pedido) AS ano,
    MONTH(p.data_pedido) AS mes,
    SUM(i.quantidade * i.preco_unitario) AS faturamento
FROM pedidos p
JOIN itens_pedido i ON p.id_pedido = i.id_pedido
WHERE p.status != 'cancelado'
GROUP BY YEAR(p.data_pedido), MONTH(p.data_pedido)
ORDER BY ano, mes;