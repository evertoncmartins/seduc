CREATE DATABASE vendasDB;
USE vendasDB;

CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY,
  nome VARCHAR(255),
  email VARCHAR(255),
  data_registro DATE
);

CREATE TABLE vendas (
  id_venda INT PRIMARY KEY,
  id_cliente INT,
  data_venda DATE,
  valor_total DECIMAL(10, 2),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE produtos (
  id_produto INT PRIMARY KEY,
  nome_produto VARCHAR(255),
  preco DECIMAL(10, 2),
  estoque INT
);

INSERT INTO clientes (id_cliente, nome, email, data_registro) VALUES
(1, 'João Silva', 'joao.silva@email.com', '2023-01-15'),
(2, 'Maria Souza', 'maria.souza@email.com', '2023-03-22'),
(3, 'Pedro Santos', 'pedro.santos@email.com', '2023-05-05'),
(4, 'Ana Oliveira', 'ana.oliveira@email.com', '2023-07-19'),
(5, 'Lucas Pereira', 'lucas.pereira@email.com', '2023-09-10');

INSERT INTO vendas (id_venda, id_cliente, data_venda, valor_total) VALUES
(1, 1, '2024-01-10', 150.00),
(2, 2, '2024-02-15', 300.00),
(3, 3, '2024-03-20', 450.00),
(4, 1, '2024-04-25', 200.00),
(5, 4, '2024-05-30', 350.00),
(6, 2, '2024-06-04', 120.00),
(7, 5, '2024-06-18', 220.00),
(8, 3, '2024-07-10', 500.00),
(9, 4, '2024-08-15', 600.00),
(10, 5, '2024-09-20', 450.00);

INSERT INTO produtos (id_produto, nome_produto, preco, estoque) VALUES
(1, 'Notebook', 3500.00, 10),
(2, 'Smartphone', 2000.00, 5),
(3, 'Tablet', 1500.00, 8),
(4, 'Monitor', 700.00, 12),
(5, 'Teclado', 100.00, 50),
(6, 'Mouse', 50.00, 100),
(7, 'Impressora', 600.00, 3),
(8, 'Câmera', 1200.00, 4),
(9, 'Fone de ouvido', 250.00, 60),
(10, 'HD externo', 500.00, 15);

-- Vendas Recentes
SELECT c.nome, v.data_venda, v.valor_total
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE v.data_venda >= '2024-01-01';

-- Produtos com Estoque Baixo
SELECT nome_produto, estoque
FROM produtos
WHERE estoque < 50
ORDER BY estoque ASC;

-- Relatório Anual de Vendas
SELECT c.nome, SUM(v.valor_total) AS total_gasto
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE YEAR(v.data_venda) = 2023
GROUP BY c.nome
HAVING SUM(v.valor_total) > 1000
ORDER BY total_gasto DESC;

-- Entender como está executando
EXPLAIN SELECT c.nome, v.data_venda, v.valor_total
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE v.data_venda >= '2024-01-01';

-- Criação de índices
CREATE INDEX idx_vendas_data ON vendas(data_venda);
CREATE INDEX idx_vendas_cliente ON vendas(id_cliente);
CREATE INDEX idx_produtos_estoque ON produtos(estoque);

-- Reexecutar para comparar 
EXPLAIN SELECT c.nome, v.data_venda, v.valor_total
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE v.data_venda >= '2024-01-01';

-- Melhorar a consulta determinando o intervalo de datas
SELECT c.nome, SUM(v.valor_total) AS total_gasto
FROM vendas v JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE v.data_venda BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY c.nome
HAVING SUM(v.valor_total) > 1000
ORDER BY total_gasto DESC;

/*
1. EXPLAIN (Análise de Consultas)
- Mostra o plano de execução das queries
- Identifica operações custosas (Full Table Scan, filesort)
- Revela se índices estão sendo usados
- Principais colunas: type, key, rows, Extra

2. Índices - Quando Usar
- Colunas frequentes em WHERE, JOIN, ORDER BY
- Chaves primárias e estrangeiras
- Colunas com alta cardinalidade (muitos valores únicos)
- Consultas lentas em tabelas grandes

3. Índices - Quando Evitar
- Tabelas muito pequenas
- Colunas atualizadas constantemente
- Colunas com muitos NULLs
- Colunas com baixa cardinalidade (ex: sexo M/F)

4. Problemas Comuns que Invalidam Índices
- Usar funções em colunas indexadas (YEAR(), UPPER())
- Fazer cálculos com colunas (preco * 1.1)
- LIKE com curinga no início ('%termo')
- Comparações entre tipos diferentes 

5. Boas Práticas de Otimização
- Criar índices estratégicos (não exagerar)
- Preferir condições diretas em colunas
- Para datas: usar BETWEEN em vez de YEAR()
- Reescrever queries complexas
- Monitorar uso dos índices criados

6. Benefícios dos Índices
- Aceleram consultas em ordens de grandeza
- Reduzem carga no servidor
- Otimizam JOINs e ordenações
- Melhoram experiência do usuário final

7. Custos dos Índices
- Aumentam espaço em disco
- Sobrecarregam INSERT/UPDATE/DELETE
- Requerem manutenção pelo SGBD
/*