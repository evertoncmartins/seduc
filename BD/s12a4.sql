CREATE DATABASE techfix;

USE techfix;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    data_nascimento DATE
);

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    fabricante VARCHAR(50),
    estoque INT
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- ALTER TABLE

-- ✅ Tarefa 1: Adicionar telefone_secundario em clientes
ALTER TABLE clientes 
ADD COLUMN telefone_secundario VARCHAR(15);

describe clientes;

-- ✅ Tarefa 2: Remover fabricante da tabela produtos
ALTER TABLE produtos 
DROP COLUMN fabricante;

DESCRIBE produtos;

-- ✅ Tarefa 3: Mudar data_pedido para DATETIME na tabela pedidos
ALTER TABLE pedidos 
MODIFY COLUMN data_pedido DATETIME;

DESCRIBE pedidos;

-- ✅ Tarefa 4: Adicionar peso e dimensao em produtos
ALTER TABLE produtos 
ADD COLUMN peso DECIMAL(5,2), 
ADD COLUMN dimensao VARCHAR(50);

DESCRIBE produtos;

-- ✅ Tarefa 5: Aumentar o tamanho do campo nome em clientes
ALTER TABLE clientes 
MODIFY COLUMN nome VARCHAR(100);

describe clientes;


/* 
✅ Questão 1:
Por que é importante usar o comando ALTER TABLE com cuidado em bancos de dados de produção?

1.O que é um banco de dados de produção?
- É o banco de dados real que está sendo usado por um sistema funcionando com usuários reais. Exemplo: o sistema da loja, hospital ou escola.

2.O que o comando ALTER TABLE faz?
- Ele modifica a estrutura de uma tabela: pode adicionar, remover ou alterar colunas.

3.	Por que usar com cuidado?
- Porque mudanças erradas ou sem planejamento podem causar problemas graves, como:
    - Perda de dados (por exemplo, se uma coluna for excluída);
    - Falhas no sistema (se ele depende daquela coluna);
    - Erros nos relatórios ou aplicativos conectados ao banco;
    - Interrupções no funcionamento da empresa.
 
✅ Questão 2:
Como você garantiria a integridade dos dados ao modificar o tipo de uma coluna?

1. O que é integridade dos dados?
- É garantir que os dados estejam corretos, completos e coerentes depois da alteração.

2. Como garantir essa integridade ao mudar o tipo de uma coluna?
- Fazer backup do banco de dados antes de qualquer alteração.
- Verificar se os dados existentes são compatíveis com o novo tipo.
- Testar em um banco de dados de teste, antes de fazer em produção.
- Comunicar a equipe que usa o banco, pois sistemas ou relatórios podem precisar ser ajustados.

✅ Questão 3:
Quais desafios podem surgir ao remover colunas que podem estar sendo usadas em outros sistemas ou relatórios?

1. O que pode estar usando essa coluna?
- A coluna pode estar sendo usada em relatórios automáticos, telas do sistema ou por aplicações externas.

2. O que acontece se a coluna for removida?
- O sistema pode parar de funcionar (erro).
- Relatórios podem mostrar resultados errados ou incompletos.
- Usuários ou programadores podem ter dificuldades para descobrir o motivo do erro.

3. Como evitar esse problema?
- Analisar onde essa coluna está sendo usada.
- Falar com os responsáveis pelo sistema.
- Testar a remoção com cuidado em ambiente de teste.
*/