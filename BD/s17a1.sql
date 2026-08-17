-- ============================================================
-- 1. CRIAÇÃO DO BANCO DE DADOS
-- ============================================================

DROP DATABASE IF EXISTS ecommerce_aula;

CREATE DATABASE ecommerce_aula
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ecommerce_aula;


-- ============================================================
-- 2. TABELAS PRINCIPAIS DA ATIVIDADE
-- O material define duas tabelas principais:
-- clientes e compras.
-- ============================================================

CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
) ENGINE = InnoDB;


CREATE TABLE compras (
    compra_id INT PRIMARY KEY,
    cliente_id INT NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    data_compra DATE NOT NULL,

    CONSTRAINT fk_compras_clientes
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id)
) ENGINE = InnoDB;


-- ============================================================
-- 3. INSERÇÃO DE DADOS DE EXEMPLO
-- Incluímos compras em setembro/2024 para permitir a execução
-- da questão 4 exatamente no período sugerido pelo material.
-- ============================================================

INSERT INTO clientes (cliente_id, nome, email) VALUES
(1, 'Ana Souza',      'ana.souza@email.com'),
(2, 'Bruno Lima',     'bruno.lima@email.com'),
(3, 'Carla Mendes',   'carla.mendes@email.com'),
(4, 'Daniel Oliveira','daniel.oliveira@email.com'),
(5, 'Elisa Santos',   'elisa.santos@email.com'),
(6, 'Fabio Rocha',    'fabio.rocha@email.com');


INSERT INTO compras (compra_id, cliente_id, valor_total, data_compra) VALUES
(101, 1,  199.90, '2024-09-02'),
(102, 2,  350.00, '2024-09-05'),
(103, 1,   89.90, '2024-09-12'),
(104, 3, 1200.00, '2024-09-18'),
(105, 4,   75.50, '2024-09-28'),
(106, 2,  450.00, '2024-10-03'),
(107, 5,  220.00, '2024-10-19'),
(108, 3,  999.99, '2024-11-11'),
(109, 6,  149.90, '2025-01-20'),
(110, 1,  300.00, '2025-02-15');


-- ============================================================
-- 4. CONFERÊNCIA DOS DADOS INSERIDOS
-- ============================================================

SELECT * FROM clientes;
SELECT * FROM compras;


-- ============================================================
-- 5. EXEMPLOS DAS FUNÇÕES DE AGREGAÇÃO NA BASE PRINCIPAL
-- ============================================================

-- SUM: soma todos os valores da coluna valor_total.
SELECT SUM(valor_total) AS total_vendas
FROM compras;


-- AVG: calcula a média dos valores das compras.
SELECT AVG(valor_total) AS valor_medio_compra
FROM compras;


-- COUNT(*): conta o número total de linhas da tabela compras.
SELECT COUNT(*) AS total_compras
FROM compras;


-- COUNT(coluna): conta valores não nulos de uma coluna.
SELECT COUNT(cliente_id) AS registros_com_cliente
FROM compras;


-- COUNT(DISTINCT ...): conta clientes diferentes que fizeram compras.
SELECT COUNT(DISTINCT cliente_id) AS clientes_unicos
FROM compras;


-- ============================================================
-- 6. FUNÇÕES DE AGREGAÇÃO COM WHERE
-- WHERE filtra os registros ANTES da agregação.
-- ============================================================

-- Exemplo: quantidade de compras realizadas pelo cliente 1.
SELECT COUNT(*) AS compras_cliente_1
FROM compras
WHERE cliente_id = 1;


-- Exemplo: soma das compras feitas em setembro de 2024.
SELECT SUM(valor_total) AS total_setembro_2024
FROM compras
WHERE data_compra >= '2024-09-01'
  AND data_compra <  '2024-10-01';


-- ============================================================
-- 7. FUNÇÕES DE AGREGAÇÃO COM GROUP BY
-- GROUP BY cria grupos e aplica a função agregada a cada grupo.
-- ============================================================

-- Total gasto por cliente.
SELECT
    cliente_id,
    SUM(valor_total) AS total_gasto
FROM compras
GROUP BY cliente_id;


-- Quantidade de compras por cliente.
SELECT
    cliente_id,
    COUNT(*) AS quantidade_compras
FROM compras
GROUP BY cliente_id;


-- Valor médio das compras por cliente.
SELECT
    cliente_id,
    AVG(valor_total) AS media_por_cliente
FROM compras
GROUP BY cliente_id;


-- ============================================================
-- 8. GROUP BY COM DADOS DOS CLIENTES
-- Consulta útil para visualizar o nome junto com os agregados.
-- ============================================================

SELECT
    c.cliente_id,
    c.nome,
    COUNT(co.compra_id) AS quantidade_compras,
    SUM(co.valor_total) AS total_gasto,
    AVG(co.valor_total) AS valor_medio
FROM clientes AS c
INNER JOIN compras AS co
    ON c.cliente_id = co.cliente_id
GROUP BY
    c.cliente_id,
    c.nome
ORDER BY total_gasto DESC;


-- ============================================================
-- 9. EXEMPLO COM HAVING
-- O material cita HAVING como cláusula usada para filtrar
-- grupos DEPOIS da agregação.
--
-- Aqui, mostramos apenas clientes cujo total gasto ultrapassou
-- R$ 500,00.
-- ============================================================

SELECT
    cliente_id,
    SUM(valor_total) AS total_gasto
FROM compras
GROUP BY cliente_id
HAVING SUM(valor_total) > 500.00;


-- ============================================================
-- 10. RESOLUÇÃO DAS PERGUNTAS DA ATIVIDADE
-- ============================================================


-- ------------------------------------------------------------
-- PERGUNTA 1
-- Calculem o valor total das vendas realizadas até hoje.
-- Função solicitada: SUM
-- ------------------------------------------------------------

SELECT
    SUM(valor_total) AS valor_total_vendas
FROM compras;


-- ------------------------------------------------------------
-- PERGUNTA 2
-- Quantos clientes únicos fizeram compras no sistema?
-- Função solicitada: COUNT
-- ------------------------------------------------------------

SELECT
    COUNT(DISTINCT cliente_id) AS total_clientes_unicos
FROM compras;


-- ------------------------------------------------------------
-- PERGUNTA 3
-- Qual é o valor médio gasto por compra?
-- Função solicitada: AVG
-- ------------------------------------------------------------

SELECT
    AVG(valor_total) AS valor_medio_por_compra
FROM compras;


-- ------------------------------------------------------------
-- PERGUNTA 4
-- Quantas compras foram feitas em determinado mês?
-- Exemplo indicado no material: setembro de 2024.
--
-- O intervalo abaixo considera:
-- de 01/09/2024 inclusive
-- até 01/10/2024 exclusivo.
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS compras_setembro_2024
FROM compras
WHERE data_compra >= '2024-09-01'
  AND data_compra <  '2024-10-01';


-- ============================================================
-- 11. CONSULTA-RESUMO PARA RELATÓRIO
-- Reúne cliente, quantidade de compras, total e média.
-- ============================================================

SELECT
    c.nome,
    c.email,
    COUNT(co.compra_id) AS quantidade_compras,
    SUM(co.valor_total) AS total_gasto,
    AVG(co.valor_total) AS valor_medio_compra
FROM clientes AS c
INNER JOIN compras AS co
    ON c.cliente_id = co.cliente_id
GROUP BY
    c.cliente_id,
    c.nome,
    c.email
ORDER BY total_gasto DESC;


-- ============================================================
-- 12. TABELAS AUXILIARES PARA REPRODUZIR OS EXEMPLOS
-- EXPLICATIVOS QUE APARECEM NO MATERIAL
--
-- Elas não fazem parte das duas tabelas principais da atividade.
-- Servem apenas para que os exemplos "vendas", "funcionarios"
-- e "pedidos" também possam ser executados sem erro.
-- ============================================================


-- ------------------------------------------------------------
-- EXEMPLO: tabela vendas
-- Usada no material para SUM(valor_venda) e GROUP BY produto_id.
-- ------------------------------------------------------------

CREATE TABLE vendas (
    venda_id INT PRIMARY KEY,
    produto_id INT NOT NULL,
    valor_venda DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;

INSERT INTO vendas (venda_id, produto_id, valor_venda) VALUES
(1, 101, 120.00),
(2, 101,  80.00),
(3, 102, 250.00),
(4, 103,  90.00),
(5, 102, 150.00);


-- Exemplo de SUM apresentado no material.
SELECT
    SUM(valor_venda) AS total_vendas
FROM vendas;


-- Exemplo de GROUP BY apresentado no material.
SELECT
    produto_id,
    SUM(valor_venda) AS total_por_produto
FROM vendas
GROUP BY produto_id;


-- ------------------------------------------------------------
-- EXEMPLO: tabela funcionarios
-- Usada no material para AVG(idade).
-- ------------------------------------------------------------

CREATE TABLE funcionarios (
    funcionario_id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT NOT NULL
) ENGINE = InnoDB;

INSERT INTO funcionarios (funcionario_id, nome, idade) VALUES
(1, 'Mariana', 25),
(2, 'Ricardo', 32),
(3, 'Patricia', 41),
(4, 'Lucas', 28),
(5, 'Fernanda', 34);


-- Exemplo de AVG apresentado no material.
SELECT
    AVG(idade) AS idade_media
FROM funcionarios;


-- ------------------------------------------------------------
-- EXEMPLO: tabela pedidos
-- Usada no material para COUNT(*) e filtro por id_cliente = 123.
-- ------------------------------------------------------------

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL
) ENGINE = InnoDB;

INSERT INTO pedidos (id_pedido, id_cliente, data_pedido) VALUES
(1, 123, '2024-09-01'),
(2, 123, '2024-09-08'),
(3, 200, '2024-09-10'),
(4, 201, '2024-09-14'),
(5, 123, '2024-09-22');


-- Exemplo: contar todos os pedidos.
SELECT
    COUNT(*) AS total_pedidos
FROM pedidos;


-- Exemplo: contar pedidos do cliente 123.
SELECT
    COUNT(id_pedido) AS pedidos_cliente_123
FROM pedidos
WHERE id_cliente = 123;


-- ============================================================
-- FIM DO ARQUIVO
-- ============================================================