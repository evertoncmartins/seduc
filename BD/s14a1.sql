-- ============================================================
-- ATIVIDADE: Análise de dados da DataInsights
-- DISCIPLINA: Modelagem e Desenvolvimento de Banco de Dados
-- TEMA: DDL, DML, subconsultas e funções analíticas
-- SGBD: MySQL 8 ou superior
-- ============================================================

-- ============================================================
-- PARTE 1 - CRIAÇÃO DO BANCO DE DADOS
-- ============================================================

-- Remove o banco de dados caso ele já exista.
-- Isso permite executar o script várias vezes sem erro.
DROP DATABASE IF EXISTS datainsights;

-- Cria o banco de dados chamado datainsights.
-- utf8mb4 permite armazenar acentos e caracteres especiais.
CREATE DATABASE datainsights
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

-- Seleciona o banco de dados que será utilizado.
USE datainsights;

-- ============================================================
-- PARTE 2 - CRIAÇÃO DAS TABELAS
-- ============================================================

-- Cria a tabela clientes.
-- Esta tabela armazena os dados básicos dos clientes.
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,        -- Identificador único do cliente.
    nome VARCHAR(100) NOT NULL,        -- Nome do cliente.
    cidade VARCHAR(100) NOT NULL       -- Cidade onde o cliente está localizado.
);

-- Cria a tabela vendas.
-- Esta tabela registra cada venda realizada.
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,           -- Identificador único da venda.
    data_venda DATE NOT NULL,           -- Data em que a venda foi realizada.
    valor_total DECIMAL(10,2) NOT NULL, -- Valor total da venda.
    id_cliente INT NOT NULL,            -- Cliente que realizou a compra.

    -- Cria uma chave estrangeira ligando vendas a clientes.
    CONSTRAINT fk_vendas_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);

-- Cria a tabela produtos_vendidos.
-- Esta tabela armazena os produtos vendidos em cada venda.
CREATE TABLE produtos_vendidos (
    id_produto_vendido INT PRIMARY KEY,    -- Identificador único do produto vendido.
    id_venda INT NOT NULL,                 -- Venda à qual o produto pertence.
    nome_produto VARCHAR(100) NOT NULL,    -- Nome do produto vendido.
    quantidade INT NOT NULL,               -- Quantidade vendida do produto.
    preco_unitario DECIMAL(10,2) NOT NULL, -- Preço unitário do produto.

    -- Cria uma chave estrangeira ligando produtos vendidos a vendas.
    CONSTRAINT fk_produtos_vendas
        FOREIGN KEY (id_venda)
        REFERENCES vendas(id_venda)
);

-- ============================================================
-- PARTE 3 - INSERÇÃO DOS DADOS
-- ============================================================

-- Insere clientes fictícios na tabela clientes.
INSERT INTO clientes (id_cliente, nome, cidade) VALUES
(1, 'Ana Silva', 'Ribeirão Preto'),
(2, 'Bruno Costa', 'Araraquara'),
(3, 'Carla Mendes', 'São Carlos'),
(4, 'Diego Santos', 'Ribeirão Preto'),
(5, 'Elisa Rocha', 'Campinas'),
(6, 'Fábio Lima', 'Araraquara');

-- Insere vendas fictícias na tabela vendas.
-- CURDATE() representa a data atual.
-- DATE_SUB() subtrai dias, meses ou anos da data atual.
INSERT INTO vendas (id_venda, data_venda, valor_total, id_cliente) VALUES
(1,  DATE_SUB(CURDATE(), INTERVAL 10 DAY),  120.00, 1),
(2,  DATE_SUB(CURDATE(), INTERVAL 20 DAY),  190.00, 1),
(3,  DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 900.00, 1),
(4,  DATE_SUB(CURDATE(), INTERVAL 3 MONTH), 240.00, 1),
(5,  DATE_SUB(CURDATE(), INTERVAL 4 MONTH), 270.00, 1),
(6,  DATE_SUB(CURDATE(), INTERVAL 6 MONTH), 100.00, 1),
(7,  DATE_SUB(CURDATE(), INTERVAL 8 MONTH), 1020.00, 1),

(8,  DATE_SUB(CURDATE(), INTERVAL 15 DAY),  300.00, 2),
(9,  DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 180.00, 2),
(10, DATE_SUB(CURDATE(), INTERVAL 5 MONTH), 940.00, 2),
(11, DATE_SUB(CURDATE(), INTERVAL 14 MONTH), 150.00, 2),

(12, DATE_SUB(CURDATE(), INTERVAL 5 DAY),   200.00, 3),
(13, DATE_SUB(CURDATE(), INTERVAL 25 DAY),  260.00, 3),
(14, DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 480.00, 3),
(15, DATE_SUB(CURDATE(), INTERVAL 3 MONTH), 160.00, 3),
(16, DATE_SUB(CURDATE(), INTERVAL 4 MONTH), 900.00, 3),
(17, DATE_SUB(CURDATE(), INTERVAL 5 MONTH), 220.00, 3),

(18, DATE_SUB(CURDATE(), INTERVAL 12 DAY),  920.00, 4),
(19, DATE_SUB(CURDATE(), INTERVAL 1 MONTH), 280.00, 4),
(20, DATE_SUB(CURDATE(), INTERVAL 3 MONTH), 200.00, 4),

(21, DATE_SUB(CURDATE(), INTERVAL 18 DAY),  400.00, 5),
(22, DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 150.00, 6);

-- Insere os produtos vendidos em cada venda.
INSERT INTO produtos_vendidos
(id_produto_vendido, id_venda, nome_produto, quantidade, preco_unitario) VALUES
(1,  1,  'Mouse',      2,  40.00),
(2,  1,  'Cabo HDMI',  2,  20.00),
(3,  2,  'Teclado',    1, 150.00),
(4,  2,  'Mouse',      1,  40.00),
(5,  3,  'Monitor',    1, 900.00),
(6,  4,  'Headset',    2, 120.00),
(7,  5,  'Mouse',      3,  40.00),
(8,  5,  'Teclado',    1, 150.00),
(9,  6,  'Cabo HDMI',  5,  20.00),
(10, 7,  'Monitor',    1, 900.00),
(11, 7,  'Headset',    1, 120.00),

(12, 8,  'Teclado',    2, 150.00),
(13, 9,  'Mouse',      2,  40.00),
(14, 9,  'Cabo HDMI',  5,  20.00),
(15, 10, 'Monitor',    1, 900.00),
(16, 10, 'Mouse',      1,  40.00),
(17, 11, 'Teclado',    1, 150.00),

(18, 12, 'Mouse',      5,  40.00),
(19, 13, 'Headset',    1, 120.00),
(20, 13, 'Cabo HDMI',  7,  20.00),
(21, 14, 'Teclado',    2, 150.00),
(22, 14, 'Mouse',      2,  40.00),
(23, 14, 'Cabo HDMI',  5,  20.00),
(24, 15, 'Mouse',      4,  40.00),
(25, 16, 'Monitor',    1, 900.00),
(26, 17, 'Mouse',      1,  40.00),
(27, 17, 'Headset',    1, 120.00),
(28, 17, 'Cabo HDMI',  3,  20.00),

(29, 18, 'Monitor',    1, 900.00),
(30, 18, 'Cabo HDMI',  1,  20.00),
(31, 19, 'Headset',    2, 120.00),
(32, 19, 'Mouse',      1,  40.00),
(33, 20, 'Mouse',      5,  40.00),

(34, 21, 'Teclado',    2, 150.00),
(35, 21, 'Cabo HDMI',  5,  20.00),
(36, 22, 'Teclado',    1, 150.00);

-- ============================================================
-- PARTE 4 - CONSULTAS PARA CONFERÊNCIA DOS DADOS
-- ============================================================

-- Mostra todos os clientes cadastrados.
SELECT * FROM clientes;

-- Mostra todas as vendas cadastradas.
SELECT * FROM vendas;

-- Mostra todos os produtos vendidos cadastrados.
SELECT * FROM produtos_vendidos;

-- ============================================================
-- TAREFA 1 - SUBCONSULTAS PARA ANÁLISE DE VENDAS
-- ============================================================

-- ------------------------------------------------------------
-- 1.1 Encontre o valor total das vendas realizadas no último mês.
-- ------------------------------------------------------------

SELECT
    -- Soma todos os valores da coluna valor_total.
    SUM(valor_total) AS total_vendas_ultimo_mes
FROM vendas
WHERE
    -- Filtra apenas vendas realizadas nos últimos 30 dias.
    data_venda >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- ------------------------------------------------------------
-- 1.2 Liste os clientes que realizaram mais de cinco vendas
-- no último ano, ordenados pela quantidade de vendas em ordem
-- decrescente.
-- ------------------------------------------------------------

SELECT
    c.id_cliente,              -- Mostra o código do cliente.
    c.nome,                    -- Mostra o nome do cliente.
    c.cidade,                  -- Mostra a cidade do cliente.
    resumo.quantidade_vendas   -- Mostra a quantidade de vendas calculada.
FROM clientes c
INNER JOIN (
    -- Subconsulta que conta quantas vendas cada cliente realizou no último ano.
    SELECT
        id_cliente,                   -- Identificador do cliente.
        COUNT(*) AS quantidade_vendas -- Conta o número de vendas do cliente.
    FROM vendas
    WHERE
        -- Considera somente as vendas realizadas nos últimos 12 meses.
        data_venda >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    GROUP BY
        -- Agrupa as vendas por cliente.
        id_cliente
    HAVING
        -- Filtra apenas clientes com mais de cinco vendas.
        COUNT(*) > 5
) AS resumo
    -- Liga o resultado da subconsulta com a tabela clientes.
    ON c.id_cliente = resumo.id_cliente
ORDER BY
    -- Ordena do cliente com mais vendas para o cliente com menos vendas.
    resumo.quantidade_vendas DESC;

-- ============================================================
-- TAREFA 2 - FUNÇÕES ANALÍTICAS
-- ============================================================

-- ------------------------------------------------------------
-- 2.1 Utilizando ROW_NUMBER(), liste os produtos vendidos,
-- junto com a posição deles no ranking de vendas por quantidade,
-- por cliente.
-- ------------------------------------------------------------

SELECT
    nome,               -- Nome do cliente.
    nome_produto,       -- Nome do produto vendido.
    total_quantidade,   -- Quantidade total vendida do produto para o cliente.
    ROW_NUMBER() OVER (
        PARTITION BY id_cliente        -- Reinicia a numeração para cada cliente.
        ORDER BY total_quantidade DESC -- Coloca o produto mais vendido na primeira posição.
    ) AS posicao_ranking
FROM (
    -- Subconsulta que calcula a quantidade total vendida de cada produto por cliente.
    SELECT
        c.id_cliente,                         -- Código do cliente.
        c.nome,                               -- Nome do cliente.
        pv.nome_produto,                      -- Nome do produto.
        SUM(pv.quantidade) AS total_quantidade -- Soma a quantidade vendida.
    FROM clientes c
    INNER JOIN vendas v
        -- Liga clientes às suas vendas.
        ON c.id_cliente = v.id_cliente
    INNER JOIN produtos_vendidos pv
        -- Liga vendas aos produtos vendidos.
        ON v.id_venda = pv.id_venda
    GROUP BY
        -- Agrupa por cliente e produto.
        c.id_cliente,
        c.nome,
        pv.nome_produto
) AS produtos_por_cliente
ORDER BY
    -- Organiza a saída pelo nome do cliente e posição no ranking.
    nome,
    posicao_ranking;

-- ------------------------------------------------------------
-- 2.2 Com RANK(), liste os três produtos mais vendidos
-- em termos de quantidade para cada cliente.
-- ------------------------------------------------------------

SELECT
    nome,                -- Nome do cliente.
    nome_produto,        -- Nome do produto.
    total_quantidade,    -- Quantidade total vendida.
    ranking_produto      -- Posição do produto no ranking.
FROM (
    SELECT
        id_cliente,
        nome,
        nome_produto,
        total_quantidade,
        RANK() OVER (
            PARTITION BY id_cliente        -- Cria um ranking separado para cada cliente.
            ORDER BY total_quantidade DESC -- Ordena pela maior quantidade vendida.
        ) AS ranking_produto
    FROM (
        -- Subconsulta que soma a quantidade de cada produto comprado por cada cliente.
        SELECT
            c.id_cliente,                          -- Código do cliente.
            c.nome,                                -- Nome do cliente.
            pv.nome_produto,                       -- Produto vendido.
            SUM(pv.quantidade) AS total_quantidade -- Quantidade total do produto.
        FROM clientes c
        INNER JOIN vendas v
            -- Liga clientes às vendas.
            ON c.id_cliente = v.id_cliente
        INNER JOIN produtos_vendidos pv
            -- Liga vendas aos produtos vendidos.
            ON v.id_venda = pv.id_venda
        GROUP BY
            -- Agrupa por cliente e produto.
            c.id_cliente,
            c.nome,
            pv.nome_produto
    ) AS soma_produtos
) AS ranking
WHERE
    -- Filtra somente os produtos que estão nas três primeiras posições.
    ranking_produto <= 3
ORDER BY
    -- Ordena por cliente e posição do ranking.
    nome,
    ranking_produto;

-- ============================================================
-- TAREFA 3 - ANÁLISE DE TENDÊNCIAS POR CIDADE
-- ============================================================

-- ------------------------------------------------------------
-- 3.1 Calcule a soma total das vendas por cidade e ordene
-- as cidades pela soma total em ordem decrescente.
-- ------------------------------------------------------------

SELECT
    c.cidade,                          -- Cidade do cliente.
    SUM(v.valor_total) AS total_vendas -- Soma total das vendas da cidade.
FROM clientes c
INNER JOIN vendas v
    -- Liga cada venda ao cliente que realizou a compra.
    ON c.id_cliente = v.id_cliente
GROUP BY
    -- Agrupa os resultados por cidade.
    c.cidade
ORDER BY
    -- Ordena da cidade com maior venda total para a menor.
    total_vendas DESC;

-- ------------------------------------------------------------
-- 3.2 Use LAG() para comparar o valor total de vendas de cada
-- cidade no mês atual com o mês anterior.
-- ------------------------------------------------------------

SELECT
    cidade,                  -- Cidade analisada.
    ano_mes,                 -- Ano e mês da venda.
    total_mes,               -- Total vendido naquele mês.
    LAG(total_mes) OVER (
        PARTITION BY cidade  -- Compara os meses dentro da mesma cidade.
        ORDER BY ano_mes     -- Ordena os meses em sequência cronológica.
    ) AS total_mes_anterior,
    total_mes - LAG(total_mes) OVER (
        PARTITION BY cidade  -- Mantém a comparação dentro da mesma cidade.
        ORDER BY ano_mes     -- Compara com o mês anterior.
    ) AS diferenca_para_mes_anterior
FROM (
    -- Subconsulta que calcula o total mensal de vendas por cidade.
    SELECT
        c.cidade,                                  -- Cidade do cliente.
        DATE_FORMAT(v.data_venda, '%Y-%m') AS ano_mes, -- Transforma a data no formato ano-mês.
        SUM(v.valor_total) AS total_mes            -- Soma total das vendas no mês.
    FROM clientes c
    INNER JOIN vendas v
        -- Liga clientes às vendas.
        ON c.id_cliente = v.id_cliente
    GROUP BY
        -- Agrupa por cidade e por mês.
        c.cidade,
        DATE_FORMAT(v.data_venda, '%Y-%m')
) AS vendas_mensais
ORDER BY
    -- Ordena por cidade e mês.
    cidade,
    ano_mes;

-- ============================================================
-- TAREFA 4 - CÁLCULO DE PERCENTUAL
-- ============================================================

-- ------------------------------------------------------------
-- 4.1 Usando NTILE(), distribua os clientes em quatro grupos
-- com base no valor total de suas vendas.
-- ------------------------------------------------------------

SELECT
    nome,                  -- Nome do cliente.
    cidade,                -- Cidade do cliente.
    total_vendas_cliente,  -- Valor total vendido para o cliente.
    NTILE(4) OVER (
        ORDER BY total_vendas_cliente DESC -- Divide os clientes em quatro grupos, do maior para o menor valor.
    ) AS grupo_quartil
FROM (
    -- Subconsulta que calcula o total vendido por cliente.
    SELECT
        c.id_cliente,                           -- Código do cliente.
        c.nome,                                 -- Nome do cliente.
        c.cidade,                               -- Cidade do cliente.
        SUM(v.valor_total) AS total_vendas_cliente -- Soma o valor total das vendas do cliente.
    FROM clientes c
    INNER JOIN vendas v
        -- Liga clientes às vendas.
        ON c.id_cliente = v.id_cliente
    GROUP BY
        -- Agrupa por cliente.
        c.id_cliente,
        c.nome,
        c.cidade
) AS total_por_cliente
ORDER BY
    -- Exibe primeiro o grupo 1, depois o grupo 2, 3 e 4.
    grupo_quartil,
    total_vendas_cliente DESC;

-- ------------------------------------------------------------
-- 4.2 Calcule a participação de cada produto no total de vendas
-- da empresa usando SUM().
-- ------------------------------------------------------------

SELECT
    nome_produto,      -- Nome do produto.
    total_produto,     -- Valor total vendido do produto.
    ROUND(
        total_produto / SUM(total_produto) OVER () * 100,
        2
    ) AS percentual_participacao -- Percentual do produto em relação ao total geral.
FROM (
    -- Subconsulta que calcula o valor total vendido de cada produto.
    SELECT
        pv.nome_produto,                                -- Nome do produto.
        SUM(pv.quantidade * pv.preco_unitario) AS total_produto -- Quantidade vezes preço unitário.
    FROM produtos_vendidos pv
    GROUP BY
        -- Agrupa pelo nome do produto.
        pv.nome_produto
) AS vendas_por_produto
ORDER BY
    -- Ordena pelo maior percentual de participação.
    percentual_participacao DESC;

-- ============================================================
-- FIM DO SCRIPT
-- ============================================================
