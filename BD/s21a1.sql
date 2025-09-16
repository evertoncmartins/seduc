-- 1. Criar bancos
CREATE DATABASE IF NOT EXISTS sistema_antigo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS novo_sistema CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Tabelas do sistema_antigo
USE sistema_antigo;

CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY,
  nome VARCHAR(120),
  email VARCHAR(150),
  telefone VARCHAR(40)
) ENGINE=InnoDB;

CREATE TABLE produtos (
  id_produto INT PRIMARY KEY,
  nome_produto VARCHAR(150),
  preco DECIMAL(10,2)
) ENGINE=InnoDB;

CREATE TABLE pedidos (
  id_pedido INT PRIMARY KEY,
  id_cliente INT,
  data_pedido DATE,
  total DECIMAL(12,2),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
) ENGINE=InnoDB;

CREATE TABLE pedido_produto (
  id_pedido_produto INT PRIMARY KEY,
  id_pedido INT,
  id_produto INT,
  quantidade INT,
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
  FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
) ENGINE=InnoDB;

-- 3. Tabelas do novo_sistema
USE novo_sistema;

CREATE TABLE usuarios (
  id_usuario INT PRIMARY KEY,
  nome_completo VARCHAR(150),
  email VARCHAR(150),
  contato VARCHAR(40)
) ENGINE=InnoDB;

CREATE TABLE itens (
  id_item INT PRIMARY KEY,
  nome_item VARCHAR(150),
  preco DECIMAL(10,2)
) ENGINE=InnoDB;

CREATE TABLE transacoes (
  id_transacao INT PRIMARY KEY,
  id_usuario INT,
  data_transacao DATE,
  valor_total DECIMAL(12,2),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
) ENGINE=InnoDB;

CREATE TABLE transacao_item (
  id_transacao_item INT PRIMARY KEY,
  id_transacao INT,
  id_item INT,
  quantidade INT,
  FOREIGN KEY (id_transacao) REFERENCES transacoes(id_transacao),
  FOREIGN KEY (id_item) REFERENCES itens(id_item)
) ENGINE=InnoDB;

USE sistema_antigo;

INSERT INTO clientes (id_cliente, nome, email, telefone) VALUES
(1,'Ana Silva','ana@example.com','(11) 99999-0001'),
(2,'Bruno Costa','bruno@example.com','(11) 98888-0002'),
(3,'Carla Dias','carla@example.com','11977770003'),
(4,'Daniel Souza','daniel@example.com','(21) 98765-4321');

INSERT INTO produtos (id_produto, nome_produto, preco) VALUES
(1,'Mouse','59.90'),
(2,'Teclado','129.50'),
(3,'Monitor','799.99'),
(4,'Cabo HDMI','39.90');

INSERT INTO pedidos (id_pedido, id_cliente, data_pedido, total) VALUES
(1, 1, '2025-09-01', 189.40),   -- Mouse + Teclado = 59.90 + 129.50 = 189.40
(2, 2, '2025-09-02', 839.89),   -- Monitor + Cabo HDMI = 799.99 + 39.90 = 839.89
(3, 1, '2025-09-05', 119.80);   -- 2 x Mouse = 2*59.90 = 119.80

INSERT INTO pedido_produto (id_pedido_produto, id_pedido, id_produto, quantidade) VALUES
(1,1,1,1),
(2,1,2,1),
(3,2,3,1),
(4,2,4,1),
(5,3,1,2);

