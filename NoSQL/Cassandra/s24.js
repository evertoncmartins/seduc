Saída// O comando SET armazena um único valor associado a uma chave. Se você precisa de um campo único, como o nome de um produto, o uso de uma string é apropriado.

// Comando para armazenar dados (SET):
SET produto:123:nome "Camiseta"
// Saída Esperada: OK

// Comando para recuperar dados (GET):
GET produto:123:nome
// Saída Esperada: "Camiseta"

// Listas
// Listas permitem adicionar e recuperar múltiplos elementos, mantendo a ordem de inserção. É útil para dados como um histórico de produtos vendidos.
// Comando para adicionar um item à lista (LPUSH):
LPUSH produtos:vendidos "Camiseta"
LPUSH produtos:vendidos "Calça"
LPUSH produtos:vendidos "Tênis"
// Saída Esperada (após cada comando): O número de elementos na lista. Por exemplo, 1, 2, 3.

// Comando para obter todos os itens de uma lista (LRANGE):
LRANGE produtos:vendidos 0 -1
// Saída Esperada:
// 1) "Tênis"
// 2) "Calça"
// 3) "Camiseta"
// Observação: A ordem é inversa, pois o LPUSH adiciona elementos no início da lista.

// Conjuntos (Sets)
// Conjuntos armazenam valores únicos e não ordenados. Isso é perfeito para listas onde você não quer repetições, como as categorias de produtos.
// Comando para adicionar itens a um conjunto (SADD):
SADD categorias:roupas "Camisetas" "Calças" "Tênis"
// Saída Esperada: O número de elementos adicionados ao conjunto, por exemplo, 3

// Comando para verificar se um item está no conjunto (SISMEMBER):
SISMEMBER categorias:roupas "Camisetas"
// Saída Esperada: (integer) 1 (Se o item existir, retorna 1. Se não, 0.)

//  Hashes
// Hashes são a estrutura ideal para armazenar múltiplos campos e valores em uma única chave. É a melhor forma de representar um objeto como um produto, com seus diversos atributos (nome, preço, estoque, etc.).
// Comando para definir um campo em um hash (HSET):
HSET produto:123 nome "Camiseta" preco 39.99 estoque 100
// Saída Esperada: O número de campos definidos (ou atualizados) no hash. Se for a primeira vez, será 3.

// Comando para obter um campo específico do hash (HGET):
HGET produto:123 nome
// Saída Esperada: "Camiseta"