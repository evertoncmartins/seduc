/*
🛠️ ATIVIDADE PRÁTICA – Backup de Dados da Tech Dynamics
🎯 Objetivos
> Entender a importância do backup.
> Realizar backup completo com mysqldump.
> Restaurar o banco em caso de falha.
> Verificar a integridade após a restauração. */

-- ✅ PASSO 1 – Criar o banco e inserir dados
CREATE DATABASE empresa_dados;

USE empresa_dados;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100),
    cidade VARCHAR(50)
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

INSERT INTO clientes (nome, email, cidade) VALUES 
('Carlos Silva', 'carlos@email.com', 'São Paulo'),
('Ana Souza', 'ana@email.com', 'Rio de Janeiro');

INSERT INTO produtos (nome_produto, preco, estoque) VALUES 
('Notebook', 2500.00, 10),
('Smartphone', 1500.00, 25);

-- PASSO 2 – Fazer backup completo com mysqldump
-- > Acessar a pasta: 
cd C:\Program Files\MySQL\MySQL Server 8.0\bin>

mysqldump -u root -p empresa_dados > C:\BD\backup_empresa_dados.sql

/* 📘 Explicação:

> mysqldump: comando para gerar o backup.
> -u root: usuário (pode ser outro, dependendo da instalação).
> -p: solicita a senha.
> empresa_dados: nome do banco a ser salvo.
> backup_empresa_dados.sql: redireciona a saída para um arquivo .sql.

📂 Resultado:
Um arquivo chamado backup_empresa_dados.sql será gerado com toda a estrutura e dados do banco. */

-- ✅ PASSO 3 – Simular a perda de dados
DROP DATABASE empresa_dados; -- apagar o banco de dados

-- ✅ PASSO 4 – Restaurar a partir do backup
cd C:\Program Files\MySQL\MySQL Server 8.0\bin>

CREATE DATABASE empresa_dados;
mysql -u root -p empresa_dados < C:\BD\bkp.sql

-- ✅ PASSO 5 – Verificar a restauração
USE empresa_dados;

-- Consultar a tabela de clientes
SELECT * FROM clientes;

-- Consultar a tabela de produtos
SELECT * FROM produtos;