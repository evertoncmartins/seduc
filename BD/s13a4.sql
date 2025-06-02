-- 🧱 1. Criação do banco de dados

-- Cria o banco de dados
CREATE DATABASE datasoft;

-- Usa o banco criado
USE datasoft;

-- Tabela de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_cadastro DATE
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Inserindo clientes
INSERT INTO clientes (nome, email, data_cadastro) VALUES
('João Silva', 'joao@email.com', '2024-01-15'),
('Maria Oliveira', 'maria@email.com', '2024-02-10'),
('Carlos Souza', 'carlos@email.com', '2024-03-05');

-- Inserindo pedidos
INSERT INTO pedidos (id_cliente, data_pedido, status) VALUES
(1, '2024-04-01', 'Pendente'),
(1, '2024-04-05', 'Enviado'),
(2, '2024-04-02', 'Pendente'),
(3, '2024-04-10', 'Cancelado');

-- 🔁 2. Trigger: Exclusão automática de pedidos ao remover cliente
DELIMITER $$

CREATE TRIGGER excluir_pedidos_cliente
AFTER DELETE ON clientes
FOR EACH ROW
BEGIN
    DELETE FROM pedidos WHERE id_cliente = OLD.id_cliente;
END$$

DELIMITER ;

-- ✅ Teste:
-- Deleta o cliente João Silva (id = 1)
DELETE FROM clientes WHERE id_cliente = 1;

-- Verifica se os pedidos dele foram excluídos
SELECT * FROM pedidos;

-- 📋 3. Trigger: Auditoria de atualizações em pedidos
CREATE TABLE auditoria_pedidos (
    id_pedido INT,
    data_atualizacao DATETIME
);

-- Criar trigger de auditoria
DELIMITER $$

CREATE TRIGGER auditar_pedidos
AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_pedidos (id_pedido, data_atualizacao)
    VALUES (NEW.id_pedido, NOW());
END$$

DELIMITER ;

-- ✅ Teste:
-- Atualiza um pedido
UPDATE pedidos SET status = 'Enviado' WHERE id_pedido = 3;

-- Verifica a tabela de auditoria
SELECT * FROM auditoria_pedidos;


-- ⛔ 4. Trigger: Impedir exclusão de pedidos com status "Enviado"
DELIMITER $$

CREATE TRIGGER bloquear_exclusao_enviados
BEFORE DELETE ON pedidos
FOR EACH ROW
BEGIN
    IF OLD.status = 'Enviado' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pedidos com status "Enviado" não podem ser excluídos.';
    END IF;
END$$

DELIMITER ;

-- ✅ Teste:
-- Tentar excluir um pedido com status "Enviado"
DELETE FROM pedidos WHERE id_pedido = 3;
-- Deve exibir erro impedindo a exclusão

-- 💡 5. Trigger criativa: Log de novos clientes
CREATE TABLE log_novos_clientes (
    id_cliente INT,
    nome VARCHAR(100),
    data_registro DATETIME
);

-- Criar trigger de inserção:
DELIMITER $$

CREATE TRIGGER registrar_novo_cliente
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO log_novos_clientes (id_cliente, nome, data_registro)
    VALUES (NEW.id_cliente, NEW.nome, NOW());
END$$

DELIMITER ;

-- ✅ Teste:
-- Adicionar novo cliente
INSERT INTO clientes (nome, email, data_cadastro) VALUES 
('Ana Costa', 'ana@email.com', '2024-05-10');

-- Verifica o log
SELECT * FROM log_novos_clientes;

/* 📌 Conclusão
- Com esse roteiro completo, você poderá demonstrar aos alunos:
- Como cada trigger funciona
- Os efeitos automáticos após determinadas ações
- Como manter a integridade dos dados com facilidade
- Se desejar, posso converter todo esse material em PDF formatado para aula ou mesmo gerar um script .sql completo para importar direto no MySQL. Deseja isso?
*/