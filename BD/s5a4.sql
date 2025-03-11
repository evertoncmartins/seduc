-- Criando o banco de dados
CREATE DATABASE LocadoraVeiculos;

-- Selecionando o banco de dados
USE LocadoraVeiculos;

-- Criando a tabela Veiculos
CREATE TABLE Veiculos (
    VeiculoID INT PRIMARY KEY AUTO_INCREMENT,
    Modelo VARCHAR(100),
    Marca VARCHAR(100),
    Ano INT,
    Status VARCHAR(20),
    PrecoDiaria DECIMAL(10, 2)
);

-- Criando a tabela Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Email VARCHAR(100),
    Cidade VARCHAR(50),
    Idade INT,
    CategoriaCliente VARCHAR(20)
);

-- Inserindo dados fictícios na tabela Veiculos
INSERT INTO Veiculos (Modelo, Marca, Ano, Status, PrecoDiaria) 
VALUES 
    ('Fusca', 'Volkswagen', 2015, 'Disponível', 50.00),
    ('Civic', 'Honda', 2019, 'Disponível', 90.00),
    ('Corolla', 'Toyota', 2021, 'Disponível', 120.00);

-- Inserindo dados fictícios na tabela Clientes
INSERT INTO Clientes (Nome, Email, Cidade, Idade, CategoriaCliente) 
VALUES 
    ('Carlos Silva', 'carlos@gmail.com', 'São Paulo', 30, 'Prata'),
    ('Maria Oliveira', 'maria@gmail.com', 'Rio de Janeiro', 40, 'Bronze'),
    ('João Souza', 'joao@gmail.com', 'Belo Horizonte', 35, 'Prata');


-- Atualização 1: Aumentando o preço da diária de veículos fabricados antes de 2020 em 10%
UPDATE Veiculos
SET PrecoDiaria = PrecoDiaria * 1.10
WHERE Ano < 2020;

-- Consulta para verificar o aumento de 10% no preço da diária dos veículos fabricados antes de 2020
SELECT VeiculoID, Modelo, Marca, Ano, Status, PrecoDiaria
FROM Veiculos
WHERE Ano < 2020;  -- Filtra apenas os veículos fabricados antes de 2020


-- Atualização 2: Promovendo clientes com mais de 5 anos de associação para a categoria "Ouro"
-- Supondo que todos os clientes têm mais de 5 anos de associação
UPDATE Clientes
SET CategoriaCliente = 'Ouro'
WHERE TIMESTAMPDIFF(YEAR, '2015-01-01', CURDATE()) > 5;

-- Consulta para verificar quais clientes foram promovidos para a categoria "Ouro"
SELECT ClienteID, Nome, Email, Cidade, Idade, CategoriaCliente
FROM Clientes
WHERE CategoriaCliente = 'Ouro';  -- Filtra os clientes que têm a categoria "Ouro"


-- Atualização 3: Atualizando o status dos veículos com VeiculoID 3 e 5 para "Em manutenção"
UPDATE Veiculos
SET Status = 'Em manutenção'
WHERE VeiculoID IN (3, 5);

-- Consulta para verificar o status dos veículos com VeiculoID 3 e 5, e verificar se foram atualizados para "Em manutenção"
SELECT VeiculoID, Modelo, Marca, Ano, Status, PrecoDiaria
FROM Veiculos
WHERE VeiculoID IN (3, 5);  -- Filtra os veículos com os VeiculoID 3 e 5
