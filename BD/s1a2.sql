-- Criando o banco de dados
CREATE DATABASE SistemaReservas;
USE SistemaReservas;

-- Criando a tabela de hóspedes
CREATE TABLE Hospedes (
    HospedeID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- Criando a tabela de quartos
CREATE TABLE Quartos (
    QuartoID INT PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL,
    PrecoDiaria DECIMAL(10,2) NOT NULL CHECK (PrecoDiaria >= 0)
);

-- Criando a tabela de reservas
CREATE TABLE Reservas (
    ReservaID INT PRIMARY KEY,
    HospedeID INT NOT NULL,
    QuartoID INT NOT NULL,
    DataCheckIn DATE NOT NULL,
    DataCheckOut DATE NOT NULL,
    FOREIGN KEY (HospedeID) REFERENCES Hospedes(HospedeID),
    FOREIGN KEY (QuartoID) REFERENCES Quartos(QuartoID),
    CHECK (DataCheckOut > DataCheckIn)
);