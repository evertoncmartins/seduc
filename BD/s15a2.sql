/*

📌 1. O que é um Diagrama ER (Entidade-Relacionamento)?
Um diagrama ER é uma forma de desenhar como os dados de um sistema se relacionam.

Ele representa:
- Entidades (coisas que queremos guardar no banco, como Cliente, Produto, Venda).
- Atributos (informações dessas coisas, como nome, preço, email).
- Relacionamentos (como essas coisas se conectam, ex: um cliente faz uma venda).


📌 2. O que é Normalização?
A normalização é usada para organizar os dados em tabelas de forma que:

- Não haja repetição desnecessária.
- As informações fiquem bem separadas.
- Os erros e inconsistências sejam evitados.

As formas normais são passos para isso:

| Forma Normal | Objetivo                                          | Exemplo prático simplificado                  |
| ------------ | ------------------------------------------------- | --------------------------------------------- |
|     1FN      | Separar valores em colunas únicas                 | Não colocar dois telefones na mesma célula    |
|     2FN      | Separar dados que dependem só de parte da chave   | Separar dados do cliente em outra tabela      |
|     3FN      | Remover dados que não dependem da chave principal | Não guardar cidade junto com produto, por ex. |


🛠️ Etapa 2 – Resolução comentada da atividade
🔹 1. Principais entidades e seus atributos
Vamos identificar os principais "blocos de informação" (entidades) e o que cada um precisa armazenar (atributos):

✅ Entidade: Clientes
✅ Entidade: Produtos
✅ Entidade: Fornecedores
✅ Entidade: Vendas
✅ Entidade: Itens_venda (nova tabela para armazenar os produtos de cada venda)

🔹 2. Como a normalização ajuda a evitar duplicação
Imagine o seguinte cenário sem normalização:

- Você registra uma venda e escreve de novo o nome do cliente, o nome do produto, o preço, etc.
- Se o mesmo cliente comprar de novo, você repete o nome dele várias vezes.
- E se você precisar mudar o telefone dele? Teria que mudar em todos os registros!

✅ Com a normalização:
- O nome do cliente fica em uma única tabela.
- As vendas apenas se relacionam com o cliente via chave estrangeira (id_cliente).
- Menos duplicação, mais consistência e organização!

RODAR no https://dbdiagram.io/

Project TechSolutions {
  database_type: "MySQL"
}

Table clientes {
  id_cliente INT [pk, increment]
  nome VARCHAR(100)
  email VARCHAR(100)
  telefone VARCHAR(20)
  endereco VARCHAR(150)
}

Table fornecedores {
  id_fornecedor INT [pk, increment]
  nome VARCHAR(100)
  cnpj VARCHAR(20)
  telefone VARCHAR(20)
  cidade VARCHAR(100)
}

Table produtos {
  id_produto INT [pk, increment]
  nome VARCHAR(100)
  preco DECIMAL(10,2)
  estoque INT
  id_fornecedor INT [ref: > fornecedores.id_fornecedor]
}

Table vendas {
  id_venda INT [pk, increment]
  id_cliente INT [ref: > clientes.id_cliente]
  data_venda DATE
}

Table itens_venda {
  id_item INT [pk, increment]
  id_venda INT [ref: > vendas.id_venda]
  id_produto INT [ref: > produtos.id_produto]
  quantidade INT
  preco_unitario DECIMAL(10,2)
}

*/