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
mysql -u root -p

-- Backup Completo (Full Backup) - Sem estar no mysql
mysqldump -u root -p TechSecureDB > C:\Users\ecmdi\Downloads\TechSecureDB_bck.sql

-- Recuperação do Backup Completo
mysql -u root -p -e "CREATE DATABASE TechSecureDB"
mysql -u root -p TechSecureDB < C:\Users\ecmdi\Downloads\TechSecureDB_bck.sql

-- Verificação
USE TechSecureDB;
SELECT * FROM clientes;
SELECT * FROM transacoes;



-- Configuração para Backups Incrementais
-- Edite o arquivo de configuração do MySQL (my.cnf ou my.ini):
[mysqld]
log_bin = /var/log/mysql/mysql-bin.log
server_id = 1
binlog_format = ROW
expire_logs_days = 7

-- Comandos para aplicar as mudanças:
net stop MySQL
net start MySQL

-- Verifique se o log binário está ativo:
SHOW VARIABLES LIKE 'log_bin';


-- Backup Incremental
-- Passo 1: Identifique o arquivo de log atual
SHOW MASTER STATUS;

-- Passo 2: Execute o backup incremental
mysqlbinlog --start-datetime="2023-01-17 00:00:00" /var/log/mysql/mysql-bin.000002 > C:\Users\ecmdi\Downloads\TechSecureDB.sql

-- Restauração do Backup Incremental
mysql -u root -p TechSecureDB < incremental_backup_20230118.sql

-- Verificação
USE TechSecureDB;
SELECT MAX(data_transacao) FROM transacoes;



-- Backup Diferencial
mysqldump -u root -p --single-transaction --flush-logs --master-data=2 TechSecureDB > differential_backup_$(date +%Y%m%d).sql

-- Restauração do Backup Diferencial
mysql -u root -p TechSecureDB < differential_backup_20230119.sql

-- Verificação
USE TechSecureDB;
SHOW TABLES;
SELECT COUNT(*) FROM transacoes;