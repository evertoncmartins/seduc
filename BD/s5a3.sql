-- Criando o banco de dados
CREATE DATABASE SistemaVendas;
USE SistemaVendas;

-- Criando a tabela de clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Cidade VARCHAR(50),
    Idade INT
);

-- Criando a tabela de vendas
CREATE TABLE Vendas (
    VendaID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT NOT NULL,
    DataVenda DATE NOT NULL,
    ValorVenda DECIMAL(10,2) NOT NULL CHECK (ValorVenda >= 0),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

INSERT INTO Clientes (Nome, Email, Cidade, Idade) VALUES
('João Silva', 'joao.silva@example.com', 'São Paulo', 30),
('Maria Oliveira', 'maria.oliveira@example.com', 'Rio de Janeiro', 25),
('Carlos Pereira', 'carlos.pereira@example.com', 'Belo Horizonte', 40),
('Ana Costa', 'ana.costa@example.com', 'São Paulo', 35);

INSERT INTO Vendas (ClienteID, DataVenda, ValorVenda) VALUES
(1, '2024-08-01', 100.00), -- Venda realizada para João Silva
(2, '2024-08-02', 80.00),  -- Venda realizada para Maria Oliveira
(3, '2024-08-03', 150.00), -- Venda realizada para Carlos Pereira
(4, '2024-08-04', 120.00); -- Venda realizada para Ana Costa

SELECT * FROM Clientes;
SELECT * FROM Vendas;

SELECT * FROM Vendas WHERE ClienteID = 1;

SELECT V.VendaID, C.Nome AS NomeCliente, V.DataVenda, V.ValorVenda
FROM Vendas V
JOIN Clientes C ON V.ClienteID = C.ClienteID;
