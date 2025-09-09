-- cria o banco LojaXYZ
CREATE DATABASE IF NOT EXISTS LojaXYZ CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- seleciona o banco criado para usar nele
USE LojaXYZ;

-- cria tabela Clientes
CREATE TABLE IF NOT EXISTS Clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,   -- chave primária
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL
) ENGINE=InnoDB;  -- InnoDB permite transações e foreign keys

-- cria tabela Produtos
CREATE TABLE IF NOT EXISTS Produtos (
  id_produto INT AUTO_INCREMENT PRIMARY KEY,
  nome_produto VARCHAR(100) NOT NULL,
  preco DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- cria tabela Pedidos (com referências simples)
CREATE TABLE IF NOT EXISTS Pedidos (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  id_produto INT NOT NULL,
  data_pedido DATE NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
  FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
) ENGINE=InnoDB;

-- cria tabela Fornecedores
CREATE TABLE IF NOT EXISTS Fornecedores (
  id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
  nome_fornecedor VARCHAR(100) NOT NULL,
  telefone VARCHAR(20)
) ENGINE=InnoDB;

-- Inserindo 5 clientes
INSERT INTO Clientes (nome, email) VALUES
('Mariana Silva','mariana.silva@mail.com'),
('Carlos Souza','carlos.souza@mail.com'),
('Ana Pereira','ana.pereira@mail.com'),
('João Oliveira','joao.oliveira@mail.com'),
('Beatriz Lima','beatriz.lima@mail.com');

-- Inserindo 5 produtos
INSERT INTO Produtos (nome_produto, preco) VALUES
('Fone Gamer X', 199.90),
('Teclado Mecânico Y', 349.00),
('Mouse Óptico Z', 89.50),
('Monitor 24""', 899.99),
('Cabo HDMI 2m', 29.90);

-- Inserindo 5 pedidos (relacionando clientes e produtos)
INSERT INTO Pedidos (id_cliente, id_produto, data_pedido) VALUES
(1, 1, '2025-08-01'),
(2, 3, '2025-08-03'),
(3, 2, '2025-08-10'),
(4, 5, '2025-08-15'),
(5, 4, '2025-08-20');

-- Inserindo 5 fornecedores
INSERT INTO Fornecedores (nome_fornecedor, telefone) VALUES
('ForneceTech Ltda','(11)99999-0001'),
('Cabo e Cia','(11)99999-0002'),
('Displays SA','(11)99999-0003'),
('AudioParts','(11)99999-0004'),
('Periféricos BR','(11)99999-0005');

-- checa quantidade por tabela
SELECT * FROM Clientes;

SELECT * FROM Produtos;

SELECT * FROM Pedidos;

SELECT * FROM Fornecedores;



-- --------------------------------------------------
-- Etapa 2 — Backup completo do banco com mysqldump
-- -------------------------------------------------- 

-- Acessar o caminho no Prompt de Comando: 
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"

-- Faz backup completo do banco LojaXYZ para o arquivo backup_lojaXYZ.sql no diretório home do usuário
mysqldump -u root -p --databases LojaXYZ --single-transaction > "%USERPROFILE%\Downloads\backup_lojaXYZ.sql"



-- --------------------------------------
-- Etapa 3 — Simulação de perda de dados 
-- --------------------------------------

-- Simula falha: apaga todos os registros da tabela Pedidos
DELETE FROM pedidos WHERE id_pedido = 1;

-- checa se a tabela Pedidos foi excluída o id = 1
select * from pedidos;

-- (opção segura) apagar e recriar o banco antes de importar
.\mysql -u root -p -e "DROP DATABASE IF EXISTS LojaXYZ; CREATE DATABASE LojaXYZ CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

-- importa o backup (arquivo gerado na Etapa 2) para o servidor MySQL
mysql -u root -p LojaXYZ < "%USERPROFILE%\Downloads\backup_lojaXYZ.sql"



-- -------------------------------
-- Etapa 3 — Backup “incremental”
-- -------------------------------

-- cria tabela NovosProdutos (produtos adicionados recentemente)
CREATE TABLE IF NOT EXISTS NovosProdutos (
  id_produto INT AUTO_INCREMENT PRIMARY KEY,
  nome_produto VARCHAR(100) NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  data_inclusao DATE NOT NULL
) ENGINE=InnoDB;

-- insere alguns produtos novos
INSERT INTO NovosProdutos (nome_produto, preco, data_inclusao) VALUES
('Webcam HD', 159.90, '2025-09-01'),
('Headset USB', 129.90, '2025-09-02'),
('Suporte Monitor', 79.50, '2025-09-03');

-- faz backup apenas da tabela NovosProdutos
mysqldump -u root -p --single-transaction LojaXYZ NovosProdutos > "%USERPROFILE%\Downloads\backup_lojaXYZ_NovosProdutos.sql"

-- simula falha: apaga a tabela NovosProdutos
DROP TABLE IF EXISTS NovosProdutos;   -- simula que a tabela foi excluída

-- importa o backup incremental (arquivo gerado acima) para o servidor MySQL
mysql -u root -p LojaXYZ < "%USERPROFILE%\Downloads\backup_lojaXYZ_NovosProdutos.sql"