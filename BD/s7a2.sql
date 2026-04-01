-- Cria o banco de dados TechSecureDB
CREATE DATABASE TechSecureDB;

-- Seleciona o banco de dados para uso
USE TechSecureDB;

-- Cria tabela de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100)
);

-- Cria tabela de transações
CREATE TABLE transacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    valor DECIMAL(10, 2),
    data_transacao DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Insere dados de exemplo na tabela clientes
INSERT INTO clientes (nome, email) VALUES
('João Silva', 'joao.silva@email.com'),
('Maria Santos', 'maria.santos@email.com'),
('Carlos Oliveira', 'carlos.oliveira@email.com');

-- Insere dados de exemplo na tabela transacoes
INSERT INTO transacoes (cliente_id, valor, data_transacao) VALUES
(1, 150.00, '2023-01-15'),
(2, 300.50, '2023-01-16'),
(3, 99.90, '2023-01-17');


-- Acessar banco de dados
C:\Program Files\MySQL\MySQL Server 8.0\bin

-- Backup Completo (Full Backup) - Sem estar no mysql
.\mysqldump -u root -p TechSecureDB > C:\Users\evert\Downloads\TechSecureDB_bck.sql

-- Recuperação do Backup Completo
.\mysql -u root -p -e "CREATE DATABASE TechSecureDB"
Get-Content C:\Users\evert\Downloads\TechSecureDB_bck.sql | .\mysql -u root -p TechSecureDB


.\mysql -u root -p


-- Verificação
USE TechSecureDB;
SELECT * FROM clientes;
SELECT * FROM transacoes;