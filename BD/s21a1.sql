-- Criar bancos
CREATE DATABASE IF NOT EXISTS sistema_antigo;
CREATE DATABASE IF NOT EXISTS novo_sistema;

-- --- Tabelas do sistema_antigo
USE sistema_antigo;

CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  telefone VARCHAR(30)
) ENGINE=InnoDB;

CREATE TABLE produtos (
  id_produto INT PRIMARY KEY AUTO_INCREMENT,
  nome_produto VARCHAR(100) NOT NULL,
  preco DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE pedidos (
  id_pedido INT PRIMARY KEY AUTO_INCREMENT,
  id_cliente INT,
  data_pedido DATE,
  total DECIMAL(10,2),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
) ENGINE=InnoDB;

CREATE TABLE pedido_produto (
  id_pedido_produto INT PRIMARY KEY AUTO_INCREMENT,
  id_pedido INT,
  id_produto INT,
  quantidade INT,
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
  FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
) ENGINE=InnoDB;

-- --- Tabelas do novo_sistema
USE novo_sistema;

CREATE TABLE usuarios (
  id_usuario INT PRIMARY KEY,               -- mantemos o id do sistema antigo para facilitar o exemplo
  nome_completo VARCHAR(150) NOT NULL,
  email VARCHAR(100),
  contato VARCHAR(30)
) ENGINE=InnoDB;

CREATE TABLE transacoes (
  id_transacao INT PRIMARY KEY,
  id_usuario INT,
  data_transacao DATE,
  valor_total DECIMAL(10,2),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
) ENGINE=InnoDB;

CREATE TABLE itens (
  id_item INT PRIMARY KEY,
  nome_item VARCHAR(150),
  preco DECIMAL(10,2)
) ENGINE=InnoDB;

CREATE TABLE transacao_item (
  id_transacao_item INT PRIMARY KEY AUTO_INCREMENT,
  id_transacao INT,
  id_item INT,
  quantidade INT,
  FOREIGN KEY (id_transacao) REFERENCES transacoes(id_transacao),
  FOREIGN KEY (id_item) REFERENCES itens(id_item)
) ENGINE=InnoDB;

USE sistema_antigo;

-- clientes
INSERT INTO clientes (nome, email, telefone) VALUES
('Ana Silva','ana.silva@example.com','(11) 91234-5678'),
('Bruno Souza','bruno.souza@example.com','11 99876-5432'),
('Carla Pereira','carla.pereira@example.com','11988776655');

-- produtos (observe preço ajustado para exemplos)
INSERT INTO produtos (nome_produto, preco) VALUES
('Teclado Gamer', 199.90),
('Mouse Óptico', 79.50),
('Monitor 24\"', 699.00),
('Suporte para Notebook', 89.83);

-- pedidos (total calculado manualmente para bater com os itens abaixo)
INSERT INTO pedidos (id_cliente, data_pedido, total) VALUES
(1, '2025-09-01', 279.40),  -- Ana: 199.90 + 79.50
(2, '2025-09-02', 699.00),  -- Bruno: Monitor
(1, '2025-09-03', 269.49);  -- Ana: 3 x 89.83

-- pedido_produto
INSERT INTO pedido_produto (id_pedido, id_produto, quantidade) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(3, 4, 3);

-- versão segura (remove tudo que não for dígito)
REGEXP_REPLACE(telefone, '[^0-9]', '') AS contato

-- versão com REPLACE para MySQL antigo:
REPLACE(REPLACE(REPLACE(REPLACE(telefone,' ',''),'-',''),'(',''),')','') AS contato



-- Scripts ETL (ordem e explicações)
-- 0) Opcional: desabilitar checagem de FK para inserções em massa (cuidado!)
SET FOREIGN_KEY_CHECKS = 0;

-- 1) usuarios (clientes -> usuarios)
INSERT INTO novo_sistema.usuarios (id_usuario, nome_completo, email, contato)
SELECT
  id_cliente,
  TRIM(nome) AS nome_completo,
  LOWER(email) AS email,
  -- remover símbolos do telefone (opção 1 com REPLACE)
  REPLACE(REPLACE(REPLACE(REPLACE(telefone,' ',''),'-',''),'(',''),')','') AS contato
FROM sistema_antigo.clientes
ON DUPLICATE KEY UPDATE
  nome_completo = VALUES(nome_completo),
  email = VALUES(email),
  contato = VALUES(contato);

-- Se estiver em MySQL 8 e quiser usar regex:
-- REGEXP_REPLACE(telefone,'[^0-9]','') AS contato

-- 2) itens (produtos -> itens)
INSERT INTO novo_sistema.itens (id_item, nome_item, preco)
SELECT id_produto, nome_produto, preco
FROM sistema_antigo.produtos
ON DUPLICATE KEY UPDATE
  nome_item = VALUES(nome_item),
  preco = VALUES(preco);

-- 3) transacoes (pedidos -> transacoes)
INSERT INTO novo_sistema.transacoes (id_transacao, id_usuario, data_transacao, valor_total)
SELECT id_pedido, id_cliente, data_pedido, total
FROM sistema_antigo.pedidos
ON DUPLICATE KEY UPDATE
  id_usuario = VALUES(id_usuario),
  data_transacao = VALUES(data_transacao),
  valor_total = VALUES(valor_total);

-- 4) transacao_item (pedido_produto -> transacao_item)
-- Note: id_transacao_item é auto_increment; inserimos sem ele
INSERT INTO novo_sistema.transacao_item (id_transacao, id_item, quantidade)
SELECT pp.id_pedido, pp.id_produto, pp.quantidade
FROM sistema_antigo.pedido_produto pp
-- opcional: JOIN para garantir que os itens existem:
LEFT JOIN sistema_antigo.produtos p ON p.id_produto = pp.id_produto
WHERE pp.quantidade > 0;

-- 0b) Reabilitar checagem de FK
SET FOREIGN_KEY_CHECKS = 1;



-- Consultas de verificação / validação (valores que você deve mostrar em aula)
-- Números de linhas (origem x destino)
SELECT
  (SELECT COUNT(*) FROM sistema_antigo.clientes) AS origem_clientes,
  (SELECT COUNT(*) FROM novo_sistema.usuarios) AS destino_usuarios;

SELECT
  (SELECT COUNT(*) FROM sistema_antigo.produtos) AS origem_produtos,
  (SELECT COUNT(*) FROM novo_sistema.itens) AS destino_itens;

SELECT
  (SELECT COUNT(*) FROM sistema_antigo.pedidos) AS origem_pedidos,
  (SELECT COUNT(*) FROM novo_sistema.transacoes) AS destino_transacoes;

SELECT
  (SELECT COUNT(*) FROM sistema_antigo.pedido_produto) AS origem_pedido_produto,
  (SELECT COUNT(*) FROM novo_sistema.transacao_item) AS destino_transacao_item;

-- Soma de totais (ver se soma bate)
SELECT SUM(total) AS soma_origem_pedidos FROM sistema_antigo.pedidos;
SELECT SUM(valor_total) AS soma_destino_transacoes FROM novo_sistema.transacoes;