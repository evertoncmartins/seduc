-- Criar o banco de dados
CREATE DATABASE ecommerceDB;
USE ecommerceDB;

-- Criar a tabela Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Cidade VARCHAR(100)
);

-- Criar a tabela Pedidos
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT,
    DataPedido DATE,
    ValorTotal DECIMAL(10, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Inserir dados na tabela Clientes
INSERT INTO Clientes (ClienteID, Nome, Cidade) VALUES 
(1, 'Alice', 'São Paulo'),
(2, 'Bruno', 'Rio de Janeiro'),
(3, 'Carla', 'Curitiba'),
(4, 'Daniel', 'Belo Horizonte');

-- Inserir dados na tabela Pedidos
INSERT INTO Pedidos (ClienteID, DataPedido, ValorTotal) VALUES 
(1, '2024-08-01', 150.00),
(1, '2024-08-15', 200.00),
(2, '2024-08-20', 300.00),
(3, '2024-08-18', 100.00);

-- Listar todos os clientes que fizeram pedidos, juntamente com os detalhes desses pedidos.
SELECT Clientes.Nome, Pedidos.PedidoID, Pedidos.DataPedido, Pedidos.ValorTotal
FROM Clientes
INNER JOIN Pedidos ON Clientes.ClienteID = Pedidos.ClienteID;

-- Listar todos os clientes, incluindo aqueles que não fizeram nenhum pedido.
SELECT C.Nome, P.PedidoID, P.DataPedido, P.ValorTotal
FROM Clientes AS C
LEFT JOIN Pedidos AS P
ON C.ClienteID = P.ClienteID;

-- Listar todos os pedidos feitos, incluindo aqueles feitos por clientes que podem não estar mais no banco de dados (por exemplo, registros de clientes excluídos).
SELECT C.Nome, P.PedidoID, P.DataPedido, P.ValorTotal
FROM Clientes AS C
RIGHT JOIN Pedidos AS P
USING(ClienteID);

-- Listar todos os clientes e todos os pedidos, independentemente de haver correspondência entre eles.
SELECT Clientes.Nome, Pedidos.PedidoID, Pedidos.DataPedido, Pedidos.ValorTotal
FROM Clientes
LEFT JOIN Pedidos ON Clientes.ClienteID = Pedidos.ClienteID
UNION
SELECT Clientes.Nome, Pedidos.PedidoID, Pedidos.DataPedido, Pedidos.ValorTotal
FROM Clientes
RIGHT JOIN Pedidos ON Clientes.ClienteID = Pedidos.ClienteID;