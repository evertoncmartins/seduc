-- Criar o banco de dados
CREATE DATABASE GerenciamentoSegurancaDB;

-- Selecionar o banco de dados
USE GerenciamentoSegurancaDB;

-- Criar tabela de transações financeiras
CREATE TABLE transacoes_financeiras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100),
    valor DECIMAL(10, 2)
);

-- Criar tabela de relatórios
CREATE TABLE relatorios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    conteudo TEXT
);

-- Criar tabela de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100)
);


-- Criar usuário financeiro
CREATE USER 'financeiro'@'localhost' IDENTIFIED BY 'root';

-- Conceder permissões ao financeiro
GRANT SELECT, INSERT, UPDATE, DELETE ON GerenciamentoSegurancaDB.transacoes_financeiras TO 'financeiro'@'localhost';

-- Criar usuário analista
CREATE USER 'analista'@'localhost' IDENTIFIED BY 'root';

-- Conceder permissões ao analista
GRANT SELECT ON GerenciamentoSegurancaDB.relatorios TO 'analista'@'localhost';

-- Criar usuário suporte
CREATE USER 'suporte'@'localhost' IDENTIFIED BY 'root';

-- Conceder permissões ao suporte
GRANT SELECT, UPDATE ON GerenciamentoSegurancaDB.clientes TO 'suporte'@'localhost';

-- Aplicar as permissões
FLUSH PRIVILEGES;


-- Testando o Controle de Acesso
-- Teste 1: Acesso Negado

-- Conectar como analista (no terminal)
mysql -u analista -p

-- Selecionar o banco de dados
USE GerenciamentoSegurancaDB;

-- Tentar inserir na tabela transacoes_financeiras (deve falhar)
INSERT INTO transacoes_financeiras (descricao, valor) VALUES ('Teste', 1000);
-- ERRO: 1142 (42000): INSERT command denied to user 'analista'@'localhost' for table 'transacoes_financeiras'


-- Teste 2: Acesso Permitido
-- Continuando como analista
SELECT * FROM relatorios;
-- Deve mostrar os dados (se houver) sem erros



-- Teste 3: Operações do Suporte
-- Conectar como suporte
mysql -u suporte -p

-- Tentar atualizar cliente (deve funcionar)
UPDATE clientes SET nome = 'Novo Nome' WHERE id = 1;

-- Selecionar o banco de dados
USE GerenciamentoSegurancaDB;

-- Tentar deletar cliente (deve falhar)
DELETE FROM clientes WHERE id = 1;
-- ERRO: 1142 (42000): DELETE command denied to user 'suporte'@'localhost' for table 'clientes'

-- Teste 4: Acesso Permitido
SELECT * FROM clientes;



-- Monitoramento e Auditoria
-- Como administrador, verifique os logs binários
SHOW BINARY LOGS;


-- Para ver as permissões de cada usuário:

-- Mostrar permissões do financeiro
SHOW GRANTS FOR 'financeiro'@'localhost';

-- Mostrar permissões do analista
SHOW GRANTS FOR 'analista'@'localhost';

-- Mostrar permissões do suporte
SHOW GRANTS FOR 'suporte'@'localhost';





