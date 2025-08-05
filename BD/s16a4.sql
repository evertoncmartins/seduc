-- Passo 1: Criar e usar o banco de dados
CREATE DATABASE IF NOT EXISTS fasttech_db;

USE fasttech_db;

-- Passo 2: Criar tabelas
   CREATE TABLE IF NOT EXISTS clientes (
          id INT AUTO_INCREMENT PRIMARY KEY,
          nome VARCHAR(100),
          email VARCHAR(100)
          );

   CREATE TABLE IF NOT EXISTS produtos (
          id INT AUTO_INCREMENT PRIMARY KEY,
          nome VARCHAR(100),
          preco DECIMAL(10, 2)
          );

   CREATE TABLE IF NOT EXISTS vendas (
          id INT AUTO_INCREMENT PRIMARY KEY,
          id_cliente INT,
          id_produto INT,
          data_venda DATE,
          quantidade INT,
          FOREIGN KEY (id_cliente) REFERENCES clientes (id),
          FOREIGN KEY (id_produto) REFERENCES produtos (id)
          );

-- Passo 3: Inserir dados
   INSERT INTO clientes (nome, email)
   VALUES ('Ana Silva', 'ana@email.com'),
          ('Carlos Lima', 'carlos@email.com'),
          ('Fernanda Souza', 'fernanda@email.com');

   INSERT INTO produtos (nome, preco)
   VALUES ('Notebook', 3500.00),
          ('Mouse', 80.00),
          ('Teclado', 120.00),
          ('Monitor', 900.00),
          ('HD Externo', 250.00);

   INSERT INTO vendas (id_cliente, id_produto, data_venda, quantidade)
   VALUES (1, 1, '2025-08-01', 1),
          (2, 2, '2025-08-02', 15),
          (2, 3, '2025-08-03', 5),
          (3, 5, '2025-08-04', 2),
          (1, 4, '2025-08-05', 12);

-- Passo 4: Criar vista relatorio_vendas
CREATE
       OR REPLACE VIEW relatorio_vendas AS
             SELECT c.nome AS cliente,
                    p.nome AS produto,
                    v.data_venda,
                    v.quantidade
               FROM vendas v
               JOIN clientes c ON v.id_cliente = c.id
               JOIN produtos p ON v.id_produto = p.id;

-- Passo 5: Consulta à vista
   SELECT *
     FROM relatorio_vendas;

-- Passo 6: Consulta com filtro
   SELECT *
     FROM relatorio_vendas
    WHERE quantidade > 10;

-- Passo 7: Criar vista materializada (simulada)
   CREATE TABLE IF NOT EXISTS relatorio_vendas_materializada AS
   SELECT c.nome AS cliente,
          p.nome AS produto,
          v.data_venda,
          v.quantidade,
          p.preco
     FROM vendas v
     JOIN clientes c ON v.id_cliente = c.id
     JOIN produtos p ON v.id_produto = p.id
    WHERE p.preco > 100;

-- Passo 8: Consulta à vista materializada
   SELECT *
     FROM relatorio_vendas_materializada;

-- Passo 9: Atualizar vista materializada
     DROP TABLE IF EXISTS relatorio_vendas_materializada;

   CREATE TABLE relatorio_vendas_materializada AS
   SELECT c.nome AS cliente,
          p.nome AS produto,
          v.data_venda,
          v.quantidade,
          p.preco
     FROM vendas v
     JOIN clientes c ON v.id_cliente = c.id
     JOIN produtos p ON v.id_produto = p.id
    WHERE p.preco > 100;