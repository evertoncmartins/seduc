-- 📌 Parte 1 — Criação do banco de dados
CREATE DATABASE empresa_tech;

USE empresa_tech;

-- 🧱 Parte 2 — Comando DDL: Criar tabela de funcionários
CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10, 2),
    data_contratacao DATE
);

-- ➕ Parte 3 — Comando DML: Inserir registros na tabela
INSERT INTO funcionarios (id_funcionario, nome, cargo, salario, data_contratacao) VALUES 
(1, 'Ana Silva', 'Desenvolvedora', 5000.00, '2023-01-10'),
(2, 'Carlos Lima', 'Analista de Dados', 4200.00, '2022-09-05'),
(3, 'Marina Souza', 'Gerente de Projetos', 7500.00, '2021-03-18');

-- ✏️ Parte 4 — Comando DML: Atualizar dados
UPDATE funcionarios
SET cargo = 'Desenvolvedora Sênior', salario = 6000.00
WHERE id_funcionario = 1;

-- 🗑️ Parte 5 — Comando DML: Deletar um funcionário
DELETE FROM funcionarios
WHERE id_funcionario = 2;

-- 🔍 Parte 6 — Conferir os dados restantes
SELECT * FROM funcionarios;