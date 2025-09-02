-- -------------------------------------------------------------
-- PARTE 0) PREPARAÇÃO (opcional, para reiniciar do zero)
-- -------------------------------------------------------------
DROP DATABASE IF EXISTS FastShop;          -- Apaga o banco se já existir (facilita refazer a atividade)
CREATE DATABASE FastShop;                  -- Cria um novo banco de dados vazio
USE FastShop;                              -- Seleciona o banco para os próximos comandos

-- -------------------------------------------------------------
-- PARTE 1) DDL - Data Definition Language (definição da estrutura)
-- -------------------------------------------------------------

-- 1.1) Tabela Cliente
-- Campos: id_cliente (PK, auto incremento), nome (obrigatório),
--         email (obrigatório e único), telefone (opcional)
CREATE TABLE Cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome       VARCHAR(100) NOT NULL,
  email      VARCHAR(100) NOT NULL UNIQUE,
  telefone   VARCHAR(15)
) ENGINE=InnoDB;

-- 1.2) Tabela Produto
-- Campos: id_produto (PK, auto incremento), nome, preco, estoque
CREATE TABLE Produto (
  id_produto INT AUTO_INCREMENT PRIMARY KEY,
  nome       VARCHAR(100) NOT NULL,
  preco      DECIMAL(10,2) NOT NULL,  -- 10 dígitos no total, 2 depois da vírgula
  estoque    INT NOT NULL
) ENGINE=InnoDB;

-- 1.3) Tabela Pedido
-- Campos: id_pedido (PK), id_cliente (FK), data_pedido, total
-- OBS: Para chaves estrangeiras funcionarem, use ENGINE=InnoDB
CREATE TABLE Pedido (
  id_pedido   INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente  INT,
  data_pedido DATE NOT NULL,
  total       DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_pedido_cliente
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
) ENGINE=InnoDB;

-- 1.4) Conferir a estrutura criada
SHOW TABLES;
DESCRIBE Cliente;
DESCRIBE Produto;
DESCRIBE Pedido;

-- 1.5) ALTERAÇÕES NA ESTRUTURA (ALTER TABLE / DROP)
-- a) Adicionar coluna descricao na tabela Produto
ALTER TABLE Produto
  ADD COLUMN descricao VARCHAR(255);

-- b) Remover a coluna telefone da tabela Cliente
ALTER TABLE Cliente
  DROP COLUMN telefone;

-- c) Excluir completamente a tabela Pedido
DROP TABLE Pedido;

-- 1.6) Conferir como ficaram as tabelas após as alterações
SHOW TABLES;
DESCRIBE Produto;
DESCRIBE Cliente;

-- -------------------------------------------------------------
-- PARTE 2) DML - Data Manipulation Language (inserir/atualizar/excluir)
-- -------------------------------------------------------------

-- 2.1) INSERINDO DADOS
-- Inserir três produtos
INSERT INTO Produto (nome, preco, estoque, descricao) VALUES
  ('Teclado Mecânico',      299.90, 50, 'Teclado ABNT2, switches azuis'),
  ('Mouse Gamer',           149.90, 80, '8000 DPI, RGB'),
  ('Monitor 24 Polegadas',  899.00, 20, 'FHD 75Hz');

-- Inserir dois clientes
INSERT INTO Cliente (nome, email) VALUES
  ('Ana Souza',   'ana.souza@example.com'),
  ('Bruno Silva', 'bruno.silva@example.com');

-- Conferir os dados inseridos
SELECT * FROM Produto;
SELECT * FROM Cliente;

-- 2.2) ATUALIZANDO DADOS
-- Ex.: Atualizar preço do "Mouse Gamer" para 129.90
UPDATE Produto
   SET preco = 129.90
 WHERE nome  = 'Mouse Gamer';

-- Ex.: Atualizar o nome de "Bruno Silva" para "Bruno A. Silva"
UPDATE Cliente
   SET nome = 'Bruno A. Silva'
 WHERE email = 'bruno.silva@example.com';

-- Conferir as atualizações
SELECT * FROM Produto;
SELECT * FROM Cliente;

-- 2.3) EXCLUINDO REGISTROS
-- Ex.: Excluir o produto "Teclado Mecânico"
DELETE FROM Produto
 WHERE nome = 'Teclado Mecânico';

-- Ex.: Excluir a cliente "Ana Souza"
DELETE FROM Cliente
 WHERE email = 'ana.souza@example.com';

-- Conferir o resultado final
SELECT * FROM Produto;
SELECT * FROM Cliente;

/* 
Gabarito conceitual — Perguntas reflexivas

1) Diferença entre DDL e DML:

- DDL (Data Definition Language): define/transforma a estrutura — CREATE, ALTER, DROP, TRUNCATE.
- DML (Data Manipulation Language): manipula dados — INSERT, UPDATE, DELETE, SELECT (consulta).

2) Riscos ao executar DDL em produção:

- Irreversibilidade/impacto alto: DROP/ALTER podem remover/alterar dados e estrutura.
- Indisponibilidade: bloqueios e migrações podem afetar o sistema online.
- Quebra de dependências: alterar/remover colunas/tabelas pode quebrar apps, relatórios e integrações.
- Boas práticas: ambiente de teste, backup, janelas de manutenção e scripts versionados.

3) Vantagens de usar DML em um banco dinâmico:

- Mantém os dados atualizados conforme o negócio muda (preços, estoque, cadastro).
- Permite operações transacionais (atomicidade/rollback).
- Facilita auditoria e controle de mudanças no conteúdo, sem alterar a estrutura.
*/