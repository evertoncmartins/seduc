-- 1) criar o banco (se necessário) e usar ele
CREATE DATABASE IF NOT EXISTS seguranca_demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE seguranca_demo;

-- 2) criar a tabela customers
-- As colunas email e phone_number são VARBINARY para armazenar o resultado de AES_ENCRYPT.
CREATE TABLE IF NOT EXISTS customers (
  id INT AUTO_INCREMENT PRIMARY KEY,         -- id do cliente
  name VARCHAR(100) NOT NULL,                -- nome em texto normal
  email VARBINARY(255) DEFAULT NULL,         -- email (armazena dados cifrados)
  phone_number VARBINARY(255) DEFAULT NULL   -- telefone (armazena dados cifrados)
) ENGINE=InnoDB;

-- Atenção: aqui usamos a 'chave-secreta' como demonstração.
-- Em produção a chave NÃO deve ficar hardcoded em SQL.
INSERT INTO customers (name, email, phone_number)
VALUES (
  'João Silva',
  AES_ENCRYPT('joao@email.com', 'chave-secreta'),
  AES_ENCRYPT('123456789', 'chave-secreta')
);

-- Inserir mais dois clientes (exigido pelo enunciado)
INSERT INTO customers (name, email, phone_number) VALUES
('Mariana Santos', AES_ENCRYPT('mariana@mail.com','chave-secreta'), AES_ENCRYPT('998877665','chave-secreta')),
('Carlos Pereira', AES_ENCRYPT('carlos@mail.com','chave-secreta'), AES_ENCRYPT('112233445','chave-secreta'));

-- selecionar e descriptografar
SELECT
  id,
  name,
  CAST(AES_DECRYPT(email, 'chave-secreta') AS CHAR(200)) AS email,
  CAST(AES_DECRYPT(phone_number, 'chave-secreta') AS CHAR(50)) AS phone_number
FROM customers;

-- Automatizar com TRIGGER 
-- definir delimitador para criar trigger no cliente mysql
DELIMITER $$

CREATE TRIGGER trg_customers_encrypt_before_insert
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
  IF NEW.email IS NOT NULL THEN
    SET NEW.email = AES_ENCRYPT(NEW.email, 'chave-secreta');
  END IF;
  IF NEW.phone_number IS NOT NULL THEN
    SET NEW.phone_number = AES_ENCRYPT(NEW.phone_number, 'chave-secreta');
  END IF;
END$$

CREATE TRIGGER trg_customers_encrypt_before_update
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
  IF NEW.email IS NOT NULL THEN
    SET NEW.email = AES_ENCRYPT(NEW.email, 'chave-secreta');
  END IF;
  IF NEW.phone_number IS NOT NULL THEN
    SET NEW.phone_number = AES_ENCRYPT(NEW.phone_number, 'chave-secreta');
  END IF;
END$$

DELIMITER ;


-- ---------------------------------------------------
-- CONTROLE DE ACESSO — criar usuários e permissões
-- ---------------------------------------------------
-- criar o usuário administrador (para a demo)
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'root';

-- criar o usuário somente leitura
CREATE USER IF NOT EXISTS 'view_only'@'localhost' IDENTIFIED BY 'root';

-- Para excluir, caso queira (não executar, senão perde os usuários criados)
DROP USER IF EXISTS 'admin'@'localhost';
DROP USER IF EXISTS 'view_only'@'localhost';


-- --------------------------------
-- Conceder permissões específicas
-- --------------------------------

-- dar permissão total ao admin somente no schema seguranca_demo e tabela customers
GRANT ALL PRIVILEGES ON seguranca_demo.customers TO 'admin'@'localhost';

-- dar apenas SELECT (leitura) ao view_only na mesma tabela
GRANT SELECT ON seguranca_demo.customers TO 'view_only'@'localhost';

-- aplicar as mudanças imediatas
FLUSH PRIVILEGES;


-- --------------------------------------------------
-- Testar o acesso (passo a passo) view_only e admin
-- --------------------------------------------------

-- Entrar como view_only
.\mysql -u view_only -p
-- digite senha: root

-- Deve funcionar (SELECT)
USE seguranca_demo;
SELECT id, name, CAST(AES_DECRYPT(email,'chave-secreta') AS CHAR(200)) AS email FROM customers LIMIT 5;

-- Deve falhar: tentativa de UPDATE (espera erro de permissão)
UPDATE customers SET name = 'Teste' WHERE id = 1;
-- Resultado esperado: ERROR 1142 (ou similar) — acesso negado para UPDATE

-- para sair do mysql
\q

-- Testando o usuario admin
.\mysql -u admin -p
-- digite senha: senha-admin

USE seguranca_demo;

-- testar UPDATE (deve permitir)
UPDATE customers SET name = CONCAT(name, ' (atualizado pelo admin)') WHERE id = 1;

-- testar INSERT (deve permitir)
INSERT INTO customers (name, email, phone_number)
VALUES ('Usuário AdminTeste', AES_ENCRYPT('admin@test.com','chave-secreta'), AES_ENCRYPT('999888777','chave-secreta'));

-- checar
SELECT id, name, CAST(AES_DECRYPT(email,'chave-secreta') AS CHAR(200)) AS email FROM customers LIMIT 10;