-- =============================================================
-- PARTE 0 - PREPARAÇÃO (reiniciar do zero para fins didáticos)
-- =============================================================
DROP DATABASE IF EXISTS ComercioEletronico;
CREATE DATABASE ComercioEletronico CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ComercioEletronico;

-- =============================================================
-- PARTE 1 - CRIAÇÃO DAS TABELAS (DDL)
-- =============================================================
-- Tabela Produtos: guarda produtos físicos e digitais
CREATE TABLE Produtos (
  id_produto INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  tipo ENUM('Físico','Digital') NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  estoque INT DEFAULT NULL, -- NULL para produtos digitais (opcional)
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabela Clientes
CREATE TABLE Clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  endereco VARCHAR(255) NOT NULL,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabela Pedidos
CREATE TABLE Pedidos (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  data_pedido DATE NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'Pendente',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_pedidos_cliente FOREIGN KEY (id_cliente)
    REFERENCES Clientes(id_cliente)
) ENGINE=InnoDB;

-- Tabela Itens_Pedido (cada registro é um item de um pedido)
CREATE TABLE Itens_Pedido (
  id_item INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  id_produto INT NOT NULL,
  quantidade INT NOT NULL DEFAULT 1,
  preco_unitario DECIMAL(10,2) NOT NULL, -- guarda o preço na hora do pedido
  CONSTRAINT fk_itens_pedido_pedido FOREIGN KEY (id_pedido)
    REFERENCES Pedidos(id_pedido) ON DELETE CASCADE,
  CONSTRAINT fk_itens_pedido_produto FOREIGN KEY (id_produto)
    REFERENCES Produtos(id_produto)
) ENGINE=InnoDB;

-- Conferir estruturas (opcional)
SHOW TABLES;
DESCRIBE Produtos;
DESCRIBE Clientes;
DESCRIBE Pedidos;
DESCRIBE Itens_Pedido;


-- =============================================================
-- PARTE 2 - INSERÇÃO DE DADOS (Parte 1 da atividade)
-- =============================================================
-- Inserir 3 produtos (1 digital e 2 físicos) conforme enunciado.
INSERT INTO Produtos (nome, tipo, preco, estoque) VALUES
  ('Camiseta Algodão', 'Físico', 59.90, 100),
  ('Curso Python On-line', 'Digital', 199.90, NULL),
  ('Fones de Ouvido Bluetooth', 'Físico', 149.90, 50);

-- Inserir 2 clientes
INSERT INTO Clientes (nome, email, endereco) VALUES
  ('João Silva', 'joao@email.com', 'Rua A, 123'),
  ('Maria Oliveira', 'maria@email.com', 'Avenida B, 456');

-- Inserir 2 pedidos (relacionados aos clientes)
INSERT INTO Pedidos (id_cliente, data_pedido, status) VALUES
  (1, '2024-11-01', 'Pendente'), -- Pedido 1: João Silva
  (2, '2024-11-02', 'Pendente'); -- Pedido 2: Maria Oliveira

-- Inserir itens: *2 itens* por pedido (conforme o enunciado pede dois itens por pedido)
-- Pedido 1 (João): Camiseta x2 + Fones x1
INSERT INTO Itens_Pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
  (1, 1, 2, 59.90),
  (1, 3, 1, 149.90);

-- Pedido 2 (Maria): Curso Python On-line x1 + Fones x1
INSERT INTO Itens_Pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
  (2, 2, 1, 199.90),
  (2, 3, 1, 149.90);

-- Conferência dos dados inseridos
SELECT * FROM Produtos;
SELECT * FROM Clientes;
SELECT * FROM Pedidos;
SELECT ip.id_item, ip.id_pedido, p.nome AS produto, ip.quantidade, ip.preco_unitario
FROM Itens_Pedido ip JOIN Produtos p ON ip.id_produto = p.id_produto;


-- =============================================================
-- PARTE 3 - ATUALIZAÇÃO DE DADOS (Parte 2 da atividade)
-- =============================================================
-- 3.1) Atualizar preço do produto "Fones de Ouvido Bluetooth" para 169.90
UPDATE Produtos
  SET preco = 169.90
 WHERE nome = 'Fones de Ouvido Bluetooth';

-- Conferir alteração
SELECT id_produto, nome, preco FROM Produtos WHERE nome LIKE '%Fones%';


-- 3.2) Atualizar endereço do cliente "João Silva" para "Rua C, 789"
UPDATE Clientes
  SET endereco = 'Rua C, 789'
 WHERE nome = 'João Silva';

-- Conferir alteração
SELECT id_cliente, nome, endereco FROM Clientes WHERE nome = 'João Silva';


-- 3.3) Alterar status do pedido 2 (Maria Oliveira) para "Cancelado"
-- Método direto (se você conhece o id_pedido):
UPDATE Pedidos
  SET status = 'Cancelado'
 WHERE id_pedido = 2;

-- Alternativa mais robusta (encontrar o pedido pela cliente):
-- UPDATE Pedidos
--   SET status = 'Cancelado'
--  WHERE id_cliente = (SELECT id_cliente FROM Clientes WHERE nome = 'Maria Oliveira' LIMIT 1);

-- Conferir alteração
SELECT * FROM Pedidos WHERE id_pedido = 2;


-- =============================================================
-- PARTE 4 - EXCLUSÃO DE DADOS (Parte 3 da atividade)
-- =============================================================
-- 4.1) Excluir o item "Curso Python On-line" do Pedido 2 (Maria Oliveira)
-- Primeiro conferimos qual é o id_produto do curso e o id_pedido de Maria (opcional)
SELECT id_produto FROM Produtos WHERE nome = 'Curso Python On-line';
SELECT id_pedido FROM Pedidos WHERE id_cliente = (SELECT id_cliente FROM Clientes WHERE nome = 'Maria Oliveira');

-- Excluir o item (abordagem direta sabendo os ids: id_pedido=2, id_produto=2)
DELETE FROM Itens_Pedido
 WHERE id_pedido = 2
   AND id_produto = 2;

-- Conferir os itens do pedido 2 após exclusão
SELECT ip.id_item, ip.id_pedido, p.nome AS produto, ip.quantidade, ip.preco_unitario
FROM Itens_Pedido ip JOIN Produtos p ON ip.id_produto = p.id_produto
WHERE ip.id_pedido = 2;


-- 4.2) Excluir o cliente "João Silva" (atenção às dependências)
-- Boa prática: remover primeiro dependências (itens e pedidos) ou usar FKs com ON DELETE CASCADE.
-- Aqui mostramos a sequência manual segura:

-- a) Excluir itens que pertencem aos pedidos do João
DELETE ip FROM Itens_Pedido ip
JOIN Pedidos pe ON ip.id_pedido = pe.id_pedido
WHERE pe.id_cliente = (SELECT id_cliente FROM Clientes WHERE nome = 'João Silva' LIMIT 1);

-- b) Excluir pedidos que pertencem ao João
DELETE FROM Pedidos
 WHERE id_cliente = (SELECT id_cliente FROM Clientes WHERE nome = 'João Silva' LIMIT 1);

-- c) Agora excluir o cliente
DELETE FROM Clientes
 WHERE nome = 'João Silva';

-- Conferir que o cliente e seus registros foram removidos
SELECT * FROM Clientes;
SELECT * FROM Pedidos;
SELECT * FROM Itens_Pedido;


-- =============================================================
-- PARTE 5 - CONSULTAS (SELECT) solicitadas na atividade (Parte 4)
-- =============================================================
-- 5.1) Consultar todos os produtos disponíveis
SELECT * FROM Produtos;

-- 5.2) Consultar pedidos de "Maria Oliveira"
SELECT pe.*
FROM Pedidos pe
JOIN Clientes c ON pe.id_cliente = c.id_cliente
WHERE c.nome = 'Maria Oliveira';

-- 5.3) Consultar todos os itens do Pedido 1 (João Silva)
-- OBS: se João já foi excluído, este pedido pode ter sido apagado. Execute antes de excluir o cliente.
SELECT ip.id_item, ip.id_pedido, p.nome AS produto, ip.quantidade, ip.preco_unitario
FROM Itens_Pedido ip
JOIN Pedidos pe ON ip.id_pedido = pe.id_pedido
JOIN Produtos p ON ip.id_produto = p.id_produto
WHERE ip.id_pedido = 1;


-- =============================================================
-- PARTE 6 - REFLEXÕES DIDÁTICAS (respostas para a Parte 5 do enunciado)
-- =============================================================
/*
1) Por que é importante utilizar UPDATE com cuidado em um banco de dados?

   - O comando UPDATE altera permanentemente os dados existentes. Um WHERE ausente ou incorreto
     pode modificar muitas linhas acidentalmente.
   - Em produção, alterações em massa devem ser testadas em homologação e geralmente realizadas em
     transações (BEGIN; ...; COMMIT;) para permitir rollback em caso de erro.
   - Documentar e versionar mudanças, e criar backups antes de mudanças críticas são práticas essenciais.

2) Quais cuidados ao excluir dados de clientes ou pedidos, considerando a integridade do banco de dados?

   - Verificar dependências: pedidos, itens, faturas, histórico, logs, etc. Remover um cliente que
     possui pedidos pode quebrar integridade referencial se as FKs não permitirem exclusão.
   - Decidir política de retenção: em muitos casos prefere-se "inativar" (marcar como inativo) ao invés
     de excluir fisicamente, para manter histórico financeiro e auditoria.
   - Se for necessário excluir, apagar primeiro os registros filhos (itens, pedidos) ou usar FKs com
     ON DELETE CASCADE cuidadosamente, sabendo que isso removerá tudo automaticamente.
*/
