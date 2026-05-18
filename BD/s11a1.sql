-- ✅ PARTE 1 – Importando dados com LOAD DATA INFILE (MySQL)
CREATE DATABASE ProdutoDB;

USE ProdutoDB;

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

-- Criar CSV e salvar na pasta com o nome produtos.csv > C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/
nome_produto,preco,estoque
Notebook,2500.00,15
Smartphone,1500.00,30
Tablet,800.00,20
Fone de Ouvido,200.00,50 

-- Importando com LOAD DATA INFILE
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/produtos.csv'
INTO TABLE produtos
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES 
(nome_produto, preco, estoque);

/* 💡 Explicações importantes:

- FIELDS TERMINATED BY ',': os campos são separados por vírgula (padrão CSV).
- LINES TERMINATED BY '\n': cada linha representa um produto.
- IGNORE 1 LINES: ignora o cabeçalho do arquivo.
- Os campos listados são os que existem no arquivo (não inclui id_produto porque é automático). */


-- ✅ PARTE 2 – Comparação com o comando BCP (SQL Server)
-- 🔹Exportar para CSV
SELECT nome_produto, preco, estoque
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/produtos_exportados.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM produtos;

/* 📘 Explicação:

- INTO OUTFILE: grava a saída da consulta em um arquivo.
- ENCLOSED BY '"': cada valor será envolto por aspas.
- Formato CSV padrão, ideal para Excel ou importação em outros sistemas. */

--🔹 Exportar para XML
SELECT 
    CONCAT(
        '<produto>',
        '<nome>', nome_produto, '</nome>',
        '<preco>', preco, '</preco>',
        '<estoque>', estoque, '</estoque>',
        '</produto>'
    ) AS xml_output
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/produtos_exportados.xml'
FROM produtos;

/* 📘 Explicação:

- Cada linha da tabela gera uma estrutura XML com <produto>...</produto>.
- O CONCAT monta a string no formato XML.
- Útil para sistemas que usam XML para integração. */


/*
📁 CSV (Comma-Separated Values)

🔹 Use quando: 
- Os dados serão abertos em planilhas (Excel, Google Sheets).
- A simplicidade e leveza forem mais importantes que a estrutura.

🔹 Vantagens:
- Leve, fácil de manipular e compatível com vários programas.

🔹 Limitações:
- Não suporta hierarquia ou dados complexos.


🧩 XML (Extensible Markup Language)

🔹 Use quando:
- Precisa representar dados estruturados (ex: listas dentro de listas).
- Vai integrar com sistemas, APIs ou softwares que usam XML.

🔹 Vantagens:
- Organizado, estruturado, ideal para sistemas.

🔹 Limitações:
- Mais pesado e difícil de editar manualmente. */