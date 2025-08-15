CREATE DATABASE ecommerce_db;

USE ecommerce_db;

CREATE TABLE
	clientes (
		cliente_id INT PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(255) NOT NULL,
		email VARCHAR(255) UNIQUE NOT NULL
	);

CREATE TABLE
	compras (
		compra_id INT PRIMARY KEY AUTO_INCREMENT,
		cliente_id INT,
		valor_total DECIMAL(10, 2) NOT NULL,
		data_compra DATE NOT NULL,
		FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id)
	);

INSERT INTO
	clientes (nome, email)
VALUES
	('João Silva', 'joao.silva@example.com'),
	('Maria Oliveira', 'maria.oliveira@example.com'),
	('Carlos Pereira', 'carlos.pereira@example.com'),
	('Ana Costa', 'ana.costa@example.com'),
	('Lucas Souza', 'lucas.souza@example.com');

INSERT INTO
	compras (cliente_id, valor_total, data_compra)
VALUES
	(1, 150.75, '2025-07-15'),
	(2, 89.90, '2025-07-16'),
	(1, 299.99, '2025-07-18'),
	(3, 1200.00, '2025-07-20'),
	(4, 75.50, '2025-07-22'),
	(2, 550.25, '2025-07-25'),
	(5, 45.30, '2025-08-01'),
	(1, 50.00, '2025-08-05');

-- ➡️ CONSULTA 1: Subconsulta em SELECT – Qual o total de compras por cliente?
-- Consulta principal que seleciona o nome do cliente.
-- Para cada cliente da consulta externa, esta subconsulta calcula a soma do 'valor_total' de todas as suas compras na tabela 'compras'.


-- ➡️ CONSULTA 2: Subconsulta em WHERE – Quais clientes gastaram acima da média?
-- A consulta externa busca o nome de clientes distintos.
SELECT DISTINCT c.nome
FROM clientes c
JOIN compras co USING (cliente_id)
WHERE co.valor_total > (
		SELECT AVG(valor_total)
		FROM compras
	);

-- ➡️ CONSULTA 3: Subconsulta em FROM – Relatório com total de compras por cliente acima da média geral
-- A consulta principal seleciona as colunas da tabela temporária criada pela subconsulta no FROM.
SELECT
	tabela_temporaria.nome,
	tabela_temporaria.total_gasto
FROM
	(
		SELECT
			c.nome,
			SUM(co.valor_total) AS total_gasto
		FROM
			clientes c
			JOIN compras co ON c.cliente_id = co.cliente_id
		GROUP BY
			c.cliente_id,
			c.nome
	) AS tabela_temporaria
WHERE
	tabela_temporaria.total_gasto > (
		SELECT
			AVG(valor_total)
		FROM
			compras
	);