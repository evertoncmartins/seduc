CREATE DATABASE bibliotecaDB;

USE bibliotecaDB;

CREATE TABLE CATEGORIA (
    id_categoria INT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(15),
    tipo_usuario VARCHAR(20) -- Ex: 'aluno', 'professor'
);

CREATE TABLE LIVRO (
    id_livro INT PRIMARY KEY,
    titulo VARCHAR(200),
    autor VARCHAR(100),
    editora VARCHAR(100),
    ano_publicacao INT,
    isbn VARCHAR(20),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria)
);

CREATE TABLE EMPRESTIMO (
    id_emprestimo INT PRIMARY KEY,
    id_usuario INT,
    id_livro INT,
    data_emprestimo DATE,
    data_devolucao_prevista DATE,
    data_devolucao_real DATE,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES LIVRO(id_livro)
);

-- Inserindo categorias
INSERT INTO CATEGORIA VALUES (1, 'Tecnologia');
INSERT INTO CATEGORIA VALUES (2, 'Literatura');
INSERT INTO CATEGORIA VALUES (3, 'História');

-- Inserindo usuários
INSERT INTO USUARIO VALUES (1, 'Ana Silva', 'ana@email.com', '11999999999', 'aluno');
INSERT INTO USUARIO VALUES (2, 'Carlos Souza', 'carlos@email.com', '11888888888', 'professor');

-- Inserindo livros
INSERT INTO LIVRO VALUES (1, 'Introdução à Programação', 'José da Silva', 'Editora A', 2020, '978-1234567890', 1);
INSERT INTO LIVRO VALUES (2, 'Dom Casmurro', 'Machado de Assis', 'Editora B', 1899, '978-0987654321', 2);
INSERT INTO LIVRO VALUES (3, 'Harry Potter', 'J. K. Rowling', 'Editora C', 2002, '978-0987654323', 2);

-- Inserindo empréstimos
INSERT INTO EMPRESTIMO VALUES (1, 1, 1, '2025-06-01', '2025-06-15', NULL);
INSERT INTO EMPRESTIMO VALUES (2, 2, 2, '2025-06-03', '2025-06-30', NULL);

-- 1. Listar todos os livros e suas categorias
SELECT l.titulo, c.nome_categoria
FROM LIVRO l
JOIN CATEGORIA c ON l.id_categoria = c.id_categoria;

-- 2. Listar os empréstimos em aberto
SELECT u.nome, l.titulo, e.data_emprestimo, e.data_devolucao_prevista
FROM EMPRESTIMO e
JOIN USUARIO u ON e.id_usuario = u.id_usuario
JOIN LIVRO l ON e.id_livro = l.id_livro
WHERE e.data_devolucao_real IS NULL;

-- 3. Quantidade de empréstimos por usuário
SELECT u.nome, COUNT(*) AS total_emprestimos
FROM EMPRESTIMO e
JOIN USUARIO u ON e.id_usuario = u.id_usuario
GROUP BY u.nome;

-- 4. Livros não emprestados atualmente
SELECT titulo FROM LIVRO
WHERE id_livro NOT IN (
    SELECT id_livro FROM EMPRESTIMO WHERE data_devolucao_real IS NULL
);
