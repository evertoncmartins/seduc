-- -------------------------------------------------------------
-- PARTE 1: CRIAÇÃO DO BANCO E DAS TABELAS (DDL)
-- -------------------------------------------------------------

-- 1.1) Reiniciando (útil para re-executar em laboratório)
DROP DATABASE IF EXISTS FoodPlusDB;
CREATE DATABASE FoodPlusDB;
USE FoodPlusDB;

-- Observação didática:
--  - DROP DATABASE remove completamente o banco e tudo dentro.
--  - CREATE DATABASE cria o banco vazio.
--  - USE seleciona o banco onde os próximos comandos atuarão.

-- 1.2) Criando a tabela Restaurante
CREATE TABLE Restaurante (
  id_restaurante INT AUTO_INCREMENT PRIMARY KEY, -- Chave primária
  nome VARCHAR(100) NOT NULL,                     -- Nome do restaurante (obrigatório)
  endereco VARCHAR(200) NOT NULL,                 -- Endereço (obrigatório)
  telefone VARCHAR(15)                             -- Telefone (será removido mais tarde)
) ENGINE=InnoDB; -- InnoDB necessário para suporte a FK no MySQL

-- 1.3) Criando a tabela Menu (itens do cardápio)
CREATE TABLE Menu (
  id_menu INT AUTO_INCREMENT PRIMARY KEY,
  id_restaurante INT NOT NULL,
  descricao VARCHAR(150) NOT NULL,
  disponibilidade BOOLEAN NOT NULL,
  CONSTRAINT fk_menu_restaurante FOREIGN KEY (id_restaurante)
    REFERENCES Restaurante(id_restaurante)
) ENGINE=InnoDB;

-- 1.4) Criando a tabela Pedido
CREATE TABLE Pedido (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_restaurante INT NOT NULL,
  data_pedido DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  CONSTRAINT fk_pedido_restaurante FOREIGN KEY (id_restaurante)
    REFERENCES Restaurante(id_restaurante)
) ENGINE=InnoDB;

-- Conferir as tabelas e estruturas iniciais
SHOW TABLES;
DESCRIBE Restaurante;
DESCRIBE Menu;
DESCRIBE Pedido;

-- -------------------------------------------------------------
-- PARTE 2: MODIFICAÇÕES DE ESTRUTURA (ALTER TABLE)
-- -------------------------------------------------------------

-- 2.1) Adicionar a coluna preco na tabela Menu
ALTER TABLE Menu
  ADD COLUMN preco DECIMAL(10,2) AFTER descricao;

-- Comentário: DECIMAL(10,2) é recomendado para valores monetários
-- porque evita imprecisão de ponto flutuante.

-- 2.2) Modificar disponibilidade para ter VALOR PADRÃO TRUE
ALTER TABLE Menu
  MODIFY disponibilidade BOOLEAN NOT NULL DEFAULT TRUE;

-- Comentário: DEFAULT TRUE facilita não enviar esse campo no INSERT
-- e garante comportamento esperado por padrão (item disponível).

-- 2.3) Alterar tabela Pedido para incluir id_menu e quantidade
ALTER TABLE Pedido
  ADD COLUMN id_menu INT,
  ADD COLUMN quantidade INT NOT NULL DEFAULT 1;

-- 2.4) Criar a restrição de chave estrangeira de Pedido -> Menu
ALTER TABLE Pedido
  ADD CONSTRAINT fk_pedido_menu FOREIGN KEY (id_menu)
    REFERENCES Menu(id_menu);

-- 2.5) Excluir a coluna telefone da tabela Restaurante
ALTER TABLE Restaurante
  DROP COLUMN telefone;

-- Conferir a estrutura após as alterações
DESCRIBE Restaurante;
DESCRIBE Menu;
DESCRIBE Pedido;

-- -------------------------------------------------------------
-- PARTE 3: TESTES PRÁTICOS (DML) - INSERT / SELECT / UPDATE / DELETE
-- -------------------------------------------------------------

-- 3.1) Inserir dados de exemplo em Restaurante
INSERT INTO Restaurante (nome, endereco) VALUES
  ('Sabor da Casa', 'Av. das Flores, 100'),
  ('Cantinho Veg',  'Rua Verde, 45');

-- 3.2) Inserir itens no Menu (note o uso do id_restaurante)
-- Repare que não precisamos informar 'disponibilidade' por causa do DEFAULT,
-- mas vamos demonstrar ambas formas (com e sem explicitar).
INSERT INTO Menu (id_restaurante, descricao, disponibilidade, preco) VALUES
  (1, 'Filé à Parmegiana', TRUE, 29.90),
  (1, 'Porção de Batata Frita', TRUE, 12.50),
  (2, 'Hambúrguer Vegano', TRUE, 24.00);

-- Conferir os dados inseridos
SELECT * FROM Restaurante;
SELECT * FROM Menu;

-- 3.3) Inserir pedidos que referenciam restaurante e item do menu
INSERT INTO Pedido (id_restaurante, data_pedido, status, id_menu, quantidade) VALUES
  (1, '2025-09-02', 'Em preparo', 1, 2),
  (2, '2025-09-02', 'Concluído', 3, 1);

-- Visualizar pedidos com JOIN para facilitar entendimento
SELECT p.id_pedido,
       r.nome      AS restaurante,
       m.descricao AS item_pedido,
       p.quantidade,
       p.status,
       p.data_pedido
FROM Pedido p
JOIN Restaurante r ON p.id_restaurante = r.id_restaurante
LEFT JOIN Menu m ON p.id_menu = m.id_menu;

-- 3.4) Atualizações de exemplo (UPDATE)
-- Ex.: marcar o item de id_menu=2 como indisponível
UPDATE Menu
  SET disponibilidade = FALSE
 WHERE id_menu = 2;

-- Conferir a atualização
SELECT * FROM Menu;

-- 3.5) Excluir um item do menu que não está referenciado (DELETE)
-- (Neste exemplo, id_menu=2 não está referenciado nas ordens atuais,
-- então é seguro apagar; se estivesse, o banco impediria a remoção por FK)
DELETE FROM Menu WHERE id_menu = 2;

-- Mostrar estado final das tabelas
SELECT * FROM Restaurante;
SELECT * FROM Menu;
SELECT * FROM Pedido;

-- -------------------------------------------------------------
-- PARTE 4: REFLEXÃO E EXPLICAÇÕES DIDÁTICAS
-- -------------------------------------------------------------
/*
1) Importância de planejar modificações em produção:
   - Alterações em esquema (DDL) podem causar indisponibilidade, perda de dados ou quebrar aplicações.
   - Recomenda-se testar em ambiente de homologação, ter backups e agendar janelas de manutenção.

2) Vantagem de valores padrão (DEFAULT):
   - Simplificam os inserts: o usuário/developer não precisa informar todos os campos sempre.
   - Garante comportamento consistente quando o campo não é informado (ex.: item disponível por padrão).
   - Facilita manutenção e evita que colunas fiquem com NULL quando um valor lógico é esperado.

3) Observações sobre chaves estrangeiras (FK):
   - As FKs asseguram que um id referenciado exista na tabela pai, mantendo integridade referencial.
   - Ex.: não será possível inserir em Pedido um id_menu que não exista em Menu.
   - Em operações de exclusão/atualização é preciso decidir políticas (ON DELETE CASCADE, RESTRICT, SET NULL).
     Aqui usamos comportamento padrão (RESTRICT) que impede exclusão de pai quando existe filho referenciando.
*/
