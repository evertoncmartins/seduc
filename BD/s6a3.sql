-- Parte 1: Criação da estrutura do banco de dados
CREATE DATABASE Reserva;
USE Reserva;

CREATE TABLE Salas (
    SalaID INT PRIMARY KEY,
    NomeSala VARCHAR(50),
    Capacidade INT
);

CREATE TABLE Reservas (
    ReservaID INT PRIMARY KEY,
    SalaID INT,
    DataReserva DATETIME,
    Usuario VARCHAR(100),
    FOREIGN KEY (SalaID) REFERENCES Salas(SalaID)
);



-- Parte 2: Implementação de transações
-- Simulação de reserva com controle de transação
-- Agora, vamos simular uma tentativa de reserva de uma sala com controle de transação. O objetivo é garantir que a sala não seja reservada duas vezes no mesmo horário.
BEGIN TRANSACTION;

-- Verifica se a sala está disponível no horário desejado
IF NOT EXISTS (
    SELECT * FROM Reservas
    WHERE SalaID = 1 AND DataReserva = '2024-08-21 10:00:00'
)
BEGIN
    -- Insere a nova reserva
    INSERT INTO Reservas (SalaID, DataReserva, Usuario)
    VALUES (1, '2024-08-21 10:00:00', 'Everton');

    -- Confirma a transação
    COMMIT;
END
ELSE
BEGIN
    -- Caso a sala já esteja reservada, cancela a transação
    ROLLBACK;
END;



-- Parte 3: Controle de concorrência e isolamento de transações
-- Controle de concorrência e isolamento de transações
-- Simulação de duas reservas simultâneas para a mesma sala e horário, utilizando o nível de isolamento SERIALIZABLE para evitar inconsistências.

-- Transição 1
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

-- Verifica e tenta reservar a sala
IF NOT EXISTS (
    SELECT * FROM Reservas
    WHERE SalaID = 1 AND DataReserva = '2024-08-21 10:00:00'
)
BEGIN
    INSERT INTO Reservas (SalaID, DataReserva, Usuario)
    VALUES (1, '2024-08-21 10:00:00', 'usuario1');

    COMMIT;
END
ELSE
BEGIN
    ROLLBACK;
END;


-- Transição 2
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

-- Verifica e tenta reservar a sala
IF NOT EXISTS (
    SELECT * FROM Reservas
    WHERE SalaID = 1 AND DataReserva = '2024-08-21 10:00:00'
)
BEGIN
    INSERT INTO Reservas (SalaID, DataReserva, Usuario)
    VALUES (1, '2024-08-21 10:00:00', 'usuario2');

    COMMIT;
END
ELSE
BEGIN
    ROLLBACK;
END;



-- Parte 4: Tratamento de conflitos e deadlocks
-- Tratamento de conflitos e deadlocks
-- Simulação de um cenário de deadlock, onde duas transações tentam acessar recursos que a outra está utilizando.

-- Transação A
BEGIN TRANSACTION;

-- Transação A bloqueia a Sala 1
UPDATE Salas SET NomeSala = 'Nova Sala A' WHERE SalaID = 1;

-- Transação A tenta acessar a Sala 2 (causando deadlock se a Transação B bloquear a Sala 2)
UPDATE Salas SET NomeSala = 'Nova Sala A' WHERE SalaID = 2;

COMMIT;

-- Transação B
BEGIN TRANSACTION;

-- Transação B bloqueia a Sala 2
UPDATE Salas SET NomeSala = 'Nova Sala B' WHERE SalaID = 2;

-- Transação B tenta acessar a Sala 1 (causando deadlock se a Transação A bloquear a Sala 1)
UPDATE Salas SET NomeSala = 'Nova Sala B' WHERE SalaID = 1;

COMMIT;