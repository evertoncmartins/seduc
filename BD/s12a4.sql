CREATE DATABASE techfix;

USE techfix;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    data_nascimento DATE
);

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    fabricante VARCHAR(50),
    estoque INT
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- ALTER TABLE

-- ✅ Tarefa 1: Adicionar telefone_secundario em clientes
ALTER TABLE clientes 
ADD COLUMN telefone_secundario VARCHAR(15);

describe clientes;

-- ✅ Tarefa 2: Remover fabricante da tabela produtos
ALTER TABLE produtos 
DROP COLUMN fabricante;

DESCRIBE produtos;

-- ✅ Tarefa 3: Mudar data_pedido para DATETIME na tabela pedidos
ALTER TABLE pedidos 
MODIFY COLUMN data_pedido DATETIME;

DESCRIBE pedidos;

-- ✅ Tarefa 4: Adicionar peso e dimensao em produtos
ALTER TABLE produtos 
ADD COLUMN peso DECIMAL(5,2), 
ADD COLUMN dimensao VARCHAR(50);

DESCRIBE produtos;

-- ✅ Tarefa 5: Aumentar o tamanho do campo nome em clientes
ALTER TABLE clientes 
MODIFY COLUMN nome VARCHAR(100);

describe clientes;