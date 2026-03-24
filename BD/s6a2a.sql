-- Criação e uso do banco de dados
CREATE DATABASE LocadoraSimples;
USE LocadoraSimples;

-- Criação da tabela de Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15)
);

-- Criação da tabela de Filmes
-- A coluna id_cliente_locacao indica com quem o filme está.
-- O padrão NULL significa que o filme está na prateleira da locadora.
CREATE TABLE filmes (
    id_filme INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    id_cliente INT DEFAULT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Inserindo Clientes
-- João e Maria farão locações. Pedro e Ana não farão nenhuma.
INSERT INTO clientes (nome, telefone) VALUES
('João Silva', '11999991111'),
('Maria Souza', '11999992222'),
('Pedro Santos', '11999993333'),
('Ana Oliveira', '11999994444');

-- Inserindo Filmes
-- Vinculando filmes aos clientes 1 (João) e 2 (Maria).
-- Deixando Titanic e O Poderoso Chefão sem vínculo (NULL).
INSERT INTO filmes (titulo, id_cliente) VALUES
('Matrix', 1),                -- Com o João
('A Origem', 2),              -- Com a Maria
('Avatar', 2),                -- Com a Maria
('Titanic', NULL),            -- Disponível na locadora
('O Poderoso Chefão', NULL);  -- Disponível na locadora



-- INNER JOIN: A Interseção (Apenas locações ativas)
-- O INNER JOIN traz apenas os registros que possuem correspondência em ambas as tabelas.
SELECT c.nome AS Cliente, f.titulo AS Filme
FROM clientes c
INNER JOIN filmes f ON c.id_cliente = f.id_cliente;



-- LEFT JOIN: Prioridade para a tabela da Esquerda (Todos os clientes)
-- O LEFT JOIN traz todos os registros da tabela à esquerda (clientes), independentemente de terem correspondência na tabela à direita.
SELECT c.nome AS Cliente, f.titulo AS Filme
FROM clientes c
LEFT JOIN filmes f ON c.id_cliente = f.id_cliente;



-- RIGHT JOIN: Prioridade para a tabela da Direita (Todos os filmes)
-- O RIGHT JOIN traz todos os registros da tabela à direita (filmes), mesmo que não estejam vinculados a ninguém.
SELECT c.nome AS Cliente, f.titulo AS Filme
FROM clientes c
RIGHT JOIN filmes f ON c.id_cliente = f.id_cliente;



-- UNION: Unindo Resultados (Simulando um FULL OUTER JOIN)
-- Como bancos de dados como o MySQL não possuem o comando FULL OUTER JOIN nativamente, a melhor forma de explicar o UNION para turmas de desenvolvimento é usá-lo para unir o LEFT JOIN com o RIGHT JOIN. Ele junta os resultados e remove as duplicatas.
SELECT c.nome AS Cliente, f.titulo AS Filme
FROM clientes c
LEFT JOIN filmes f ON c.id_cliente = f.id_cliente

UNION

SELECT c.nome AS Cliente, f.titulo AS Filme
FROM clientes c
RIGHT JOIN filmes f ON c.id_cliente = f.id_cliente;