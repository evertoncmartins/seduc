-- 1) CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS commerce_tech DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_0900_ai_ci;

-- 2) SELECIONA O BANCO PARA USO
USE commerce_tech;

-- 3) CRIAÇÃO DA TABELA 'vendas'
-- Observações:
--  - CHECKs são aplicáveis em MySQL 8.0.16+
--  - AUTO_INCREMENT em id_venda para facilitar os inserts
CREATE TABLE IF NOT EXISTS vendas (
  id_venda INT PRIMARY KEY AUTO_INCREMENT,
  -- Chave primária
  data_venda DATE NOT NULL,
  -- Data da venda
  produto VARCHAR(100) NOT NULL,
  -- Nome do produto
  vendedor VARCHAR(100) NOT NULL,
  -- Nome do vendedor
  quantidade INT NOT NULL CHECK (quantidade > 0),
  -- Qtde vendida
  valor_total DECIMAL(10, 2) NOT NULL CHECK (valor_total >= 0) -- Valor total (R$)
) ENGINE = InnoDB;

-- 4) ÍNDICES ÚTEIS PARA CONSULTAS
CREATE INDEX idx_vendas_data ON vendas (data_venda);

CREATE INDEX idx_vendas_vendedor ON vendas (vendedor);

CREATE INDEX idx_vendas_produto ON vendas (produto);

-- 5) INSERÇÕES DE EXEMPLO (16 registros, datas e valores variados)
-- Dica: valor_total aqui já representa o total da venda (qtde x preço unitário)
INSERT INTO
  vendas (
    data_venda,
    produto,
    vendedor,
    quantidade,
    valor_total
  )
VALUES
  (
    '2025-07-01',
    'Fone Bluetooth A10',
    'Ana',
    2,
    299.80
  ),
  (
    '2025-07-03',
    'Teclado Mecânico K87',
    'Bruno',
    1,
    399.90
  ),
  (
    '2025-07-05',
    'Mouse Gamer X5',
    'Carla',
    3,
    357.00
  ),
  (
    '2025-07-08',
    'Monitor 27\" IPS',
    'Diego',
    1,
    1399.00
  ),
  (
    '2025-07-08',
    'Fone Bluetooth A10',
    'Bruno',
    1,
    149.90
  ),
  (
    '2025-07-10',
    'Cadeira Office Pro',
    'Ana',
    1,
    899.00
  ),
  (
    '2025-07-12',
    'Teclado Mecânico K87',
    'Carla',
    2,
    799.80
  ),
  (
    '2025-07-13',
    'Webcam 1080p',
    'Diego',
    2,
    259.80
  ),
  (
    '2025-07-15',
    'Mouse Gamer X5',
    'Ana',
    1,
    119.00
  ),
  (
    '2025-07-16',
    'Monitor 27\" IPS',
    'Bruno',
    2,
    2798.00
  ),
  (
    '2025-07-18',
    'Cadeira Office Pro',
    'Carla',
    1,
    899.00
  ),
  (
    '2025-07-20',
    'Hub USB-C 7x1',
    'Diego',
    3,
    447.00
  ),
  (
    '2025-07-21',
    'Fone Bluetooth A10',
    'Ana',
    4,
    599.60
  ),
  (
    '2025-07-23',
    'Webcam 1080p',
    'Bruno',
    1,
    129.90
  ),
  (
    '2025-07-24',
    'Hub USB-C 7x1',
    'Carla',
    1,
    149.00
  ),
  (
    '2025-07-25',
    'Monitor 27\" IPS',
    'Ana',
    1,
    1399.00
  );

-- 6) CONSULTA 1: Numeração geral por data (vendas mais recentes primeiro)
--    ROW_NUMBER() OVER (ORDER BY data_venda DESC, id_venda DESC)
SELECT
  id_venda,
  data_venda,
  produto,
  vendedor,
  ROW_NUMBER() OVER (
    ORDER BY
      data_venda DESC,
      id_venda DESC
  ) AS numero_venda
FROM
  vendas
ORDER BY
  data_venda DESC,
  id_venda DESC;

-- ROW_NUMBER() -> É uma função que atribui um número sequencial a cada linha do resultado.
-- OVER (...) -> É onde você define como a numeração deve ser feita.
-- -> ORDER BY → ordenação da numeração (qual linha recebe 1, 2, 3, etc.).
-- -> PARTITION BY → (opcional) reinicia a numeração dentro de grupos.
-- 7) CONSULTA 2: Numeração por vendedor (reinicia a cada vendedor)
--    ROW_NUMBER() OVER (PARTITION BY vendedor ORDER BY data_venda DESC, id_venda DESC)
SELECT
  id_venda,
  data_venda,
  produto,
  vendedor,
  ROW_NUMBER() OVER (
    PARTITION BY vendedor
    ORDER BY
      data_venda DESC,
      id_venda DESC
  ) AS numero_venda_por_vendedor
FROM
  vendas
ORDER BY
  vendedor,
  data_venda DESC,
  id_venda DESC;

-- 8) CONSULTA 3: Maior venda (valor_total) por produto
--    Estratégia: ranquear por produto decrescentemente pelo valor_total e pegar rn = 1
WITH ranking_prod AS (
  SELECT
    id_venda,
    data_venda,
    produto,
    vendedor,
    quantidade,
    valor_total,
    ROW_NUMBER() OVER (
      PARTITION BY produto
      ORDER BY
        valor_total DESC,
        data_venda DESC,
        id_venda DESC
    ) AS rn
  FROM
    vendas
)
SELECT
  id_venda,
  data_venda,
  produto,
  vendedor,
  quantidade,
  valor_total
FROM
  ranking_prod
WHERE
  rn = 1
ORDER BY
  produto;

/* 
 
 A parte principal é a subconsulta ranking_prod. Dentro dela, a função de janela ROW_NUMBER() é usada para atribuir um número de linha (rn) a cada registro.
 
 - PARTITION BY produto: Essa cláusula divide os dados em grupos, com cada grupo contendo todas as vendas de um único produto.
 
 - ORDER BY valor_total DESC: Dentro de cada grupo de produto, as vendas são ordenadas de forma decrescente pelo valor_total. Isso significa que a maior venda de cada produto estará sempre no topo (na primeira linha).
 
 - ROW_NUMBER(): Atribui o número 1 à primeira linha de cada grupo, o número 2 à segunda, e assim por diante.
 
 */