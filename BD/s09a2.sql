-- =============================================================================
-- ATIVIDADE PRÁTICA: Consultas para uma Empresa de Logística
-- Objetivo: Praticar filtros com WHERE e agrupamentos com HAVING
-- =============================================================================

-- 1. Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS logistica_db;
USE logistica_db;

-- 2. Criação da tabela de Veículos
CREATE TABLE Veiculos (
    id_veiculo INT PRIMARY KEY,
    modelo VARCHAR(100),
    ano INT,
    capacidade_carga DECIMAL(10, 2)
);

-- 3. Inserção de dados na tabela Veículos
INSERT INTO Veiculos (id_veiculo, modelo, ano, capacidade_carga) VALUES
(1, 'Caminhão A', 2018, 10.0),
(2, 'Caminhão B', 2020, 15.0),
(3, 'Van X', 2015, 3.0),      
(4, 'Caminhão C', 2022, 12.0);

-- 4. Criação da tabela de Entregas
CREATE TABLE Entregas (
    id_entrega INT PRIMARY KEY,
    id_veiculo INT,
    data_entrega DATE,
    cidade VARCHAR(100),
    peso_entrega DECIMAL(10, 2),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculos(id_veiculo)
);

-- 5. Inserção de dados na tabela Entregas
INSERT INTO Entregas (id_entrega, id_veiculo, data_entrega, cidade, peso_entrega) VALUES
(1, 1, '2024-08-01', 'São Paulo', 8.0),     
(2, 2, '2024-08-03', 'Rio de Janeiro', 12.0),
(3, 3, '2024-08-05', 'Brasília', 2.5),      
(4, 1, '2024-08-07', 'Belo Horizonte', 9.5),
(5, 4, '2024-08-10', 'Salvador', 11.0),     
(6, 2, '2024-08-12', 'São Paulo', 13.5),    
(7, 3, '2024-08-14', 'Brasília', 2.0);      


-- =============================================================================
-- RESOLUÇÃO DAS TAREFAS
-- =============================================================================

-- TAREFA 1: Filtrar entregas feitas em São Paulo e após 2024-08-01 (usando WHERE)
-- O WHERE filtra as linhas antes de qualquer agrupamento.
SELECT *
FROM Entregas
WHERE cidade = 'São Paulo' AND data_entrega > '2024-08-01';


-- TAREFA 2: Filtrar veículos com capacidade maior que 10 toneladas (usando WHERE)
-- Aplicado diretamente sobre as colunas sem agregação.
SELECT *
FROM Veiculos
WHERE capacidade_carga > 10.0;


-- TAREFA 3: Agrupar entregas por cidade com peso total acima de 15 toneladas (usando HAVING)
-- O HAVING filtra os grupos após a agregação (SUM).
SELECT cidade, SUM(peso_entrega) AS total_peso
FROM Entregas
GROUP BY cidade
HAVING total_peso > 15.0;


-- TAREFA 4: Identificar veículos com entregas acima de 10 toneladas no total (usando HAVING)
-- Combina dados de veículos e entregas para calcular o total por modelo.
SELECT v.modelo, SUM(e.peso_entrega) AS total_peso_entregas
FROM Veiculos v
JOIN Entregas e ON v.id_veiculo = e.id_veiculo
GROUP BY v.modelo
HAVING total_peso_entregas > 10.0;