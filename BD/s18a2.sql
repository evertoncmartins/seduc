CREATE DATABASE IF NOT EXISTS data_insights_db;

USE data_insights_db;

CREATE TABLE IF NOT EXISTS funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(100),
    id_supervisor INT,
    FOREIGN KEY (id_supervisor) REFERENCES funcionarios(id_funcionario)
);

CREATE TABLE IF NOT EXISTS vendas (
    id_venda INT PRIMARY KEY,
    id_funcionario INT,
    valor_venda DECIMAL(10, 2),
    data_venda DATE,
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

INSERT INTO funcionarios (id_funcionario, nome, id_supervisor) VALUES
(1, 'João Gerente Geral', NULL),
(2, 'Maria Supervisora', 1),
(3, 'Pedro Vendedor', 2),
(4, 'Ana Vendedora', 2),
(5, 'Carlos Vendedor', 3);

INSERT INTO vendas (id_venda, id_funcionario, valor_venda, data_venda) VALUES
(1, 1, 50000.00, '2024-05-01'),
(2, 2, 25000.00, '2024-05-02'),
(3, 3, 15000.00, '2024-05-03'),
(4, 3, 10000.00, '2024-05-04'),
(5, 4, 8000.00, '2024-05-05'),
(6, 4, 12000.00, '2024-05-06'),
(7, 5, 5000.00, '2024-05-07'),
(8, 5, 7500.00, '2024-05-08');

-- ==============================================================================
-- 📝 Seção 4: Consultas com CTEs
-- ==============================================================================

-- 4.1 Consulta 1: Total de vendas por funcionário [cite: 28]
-- Usamos uma CTE para calcular a soma das vendas de cada funcionário
-- de forma separada antes de juntar com a tabela de nomes.
WITH total_vendas AS (
    SELECT
        id_funcionario,
        SUM(valor_venda) AS total
    FROM
        vendas
    GROUP BY
        id_funcionario
)
SELECT
    f.nome,
    COALESCE(tv.total, 0) AS total_vendas_funcionario
FROM
    funcionarios f
LEFT JOIN
    total_vendas tv ON f.id_funcionario = tv.id_funcionario
ORDER BY
    f.nome;

-- 4.2 Consulta 2: Hierarquia de funcionários com CTE recursiva [cite: 41]
-- A parte "âncora" seleciona o topo da hierarquia (id_supervisor IS NULL).
-- A parte "recursiva" se junta à CTE para encontrar os subordinados
-- e avança para o próximo nível.
WITH RECURSIVE hierarquia_funcionarios AS (
    -- Parte Âncora: Seleciona os funcionários no topo da hierarquia
    SELECT
        id_funcionario,
        nome,
        id_supervisor,
        1 AS nivel
    FROM
        funcionarios
    WHERE
        id_supervisor IS NULL

    UNION ALL

    -- Parte Recursiva: Encontra os subordinados
    SELECT
        f.id_funcionario,
        f.nome,
        f.id_supervisor,
        hf.nivel + 1 AS nivel
    FROM
        funcionarios f
    INNER JOIN
        hierarquia_funcionarios hf ON f.id_supervisor = hf.id_funcionario
)
SELECT
    hf.id_funcionario,
    CONCAT(REPEAT('  ', hf.nivel - 1), hf.nome) AS nome_hierarquia,
    (SELECT nome FROM funcionarios WHERE id_funcionario = hf.id_supervisor) AS nome_supervisor,
    hf.nivel
FROM
    hierarquia_funcionarios hf
ORDER BY
    hf.nivel, hf.id_funcionario;

-- 4.3 Consulta 3: Total de vendas da equipe (incluindo subordinados) [cite: 55]
-- Combinamos uma CTE recursiva para a hierarquia com uma CTE de vendas.
-- A `hierarquia_subordinados` encontra todos os subordinados de cada líder.
-- Depois, somamos as vendas de todos os membros de cada equipe.
WITH RECURSIVE hierarquia_subordinados AS (
    -- Parte Âncora: Cada funcionário é seu próprio líder
    SELECT
        id_funcionario,
        id_funcionario AS id_lider
    FROM
        funcionarios
    
    UNION ALL
    
    -- Parte Recursiva: Encontra os subordinados diretos e indiretos de cada líder
    SELECT
        f.id_funcionario,
        hs.id_lider
    FROM
        funcionarios f
    INNER JOIN
        hierarquia_subordinados hs ON f.id_supervisor = hs.id_funcionario
),
total_vendas AS (
    -- CTE para calcular o total de vendas individuais
    SELECT
        id_funcionario,
        SUM(valor_venda) AS total_vendas_pessoais
    FROM
        vendas
    GROUP BY
        id_funcionario
)
SELECT
    f.nome AS lider,
    SUM(COALESCE(tv.total_vendas_pessoais, 0)) AS total_vendas_equipe
FROM
    funcionarios f
LEFT JOIN
    hierarquia_subordinados hs ON f.id_funcionario = hs.id_lider
LEFT JOIN
    total_vendas tv ON hs.id_funcionario = tv.id_funcionario
GROUP BY
    f.nome
ORDER BY
    f.nome;