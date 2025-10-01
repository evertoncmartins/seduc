// Coleção "produtos"
[
  { "produto_id": 101, "nome": "Notebook X", "preco": 3500.00, "categoria": "Eletrônicos" },
  { "produto_id": 102, "nome": "Fone Y",     "preco": 300.00,  "categoria": "Acessórios" }
]

// Coleção Clientes
{ "cliente_id": 1, "nome": "Maria Silva", "email": "maria@example.com", "telefone": "11 99999-0000" }

// Coleção Pedidos
{
  "pedido_id": 1,
  "data": "2024-11-15T10:00:00Z",
  "cliente_id": 1,
  "status": "Processando",
  "itens": [
    { "produto_id": 101, "quantidade": 2, "preco_unitario": 3500.00 },
    { "produto_id": 102, "quantidade": 1, "preco_unitario": 300.00 }
  ]
}

// A) Ver o pedido completo (findOne)
{pedido_id: 1, status: 1, itens: 1}

//B) Agregação: trazer os nomes dos produtos + total do pedido (pipeline para a aba Aggregations ou aggregate() no shell)
// Cole esse pipeline na aba Aggregations da coleção Pedidos
[
  { $match: { pedido_id: 1 } },
  { $unwind: "$itens" },
  { $lookup: {
      from: "Produtos",
      localField: "itens.produto_id",
      foreignField: "produto_id",
      as: "produto_det"
  }},
  { $unwind: "$produto_det" },
  { $group: {
      _id: "$pedido_id",
      cliente_id: { $first: "$cliente_id" },
      data: { $first: "$data" },
      status: { $first: "$status" },
      itens: { $push: {
        produto_id: "$itens.produto_id",
        produto_nome: "$produto_det.nome",
        quantidade: "$itens.quantidade",
        preco_unitario: "$itens.preco_unitario"
      }},
      total: { $sum: { $multiply: ["$itens.quantidade", "$itens.preco_unitario"] } }
  }},
  { $project: { _id: 0, pedido_id: "$_id", cliente_id: 1, data: 1, status: 1, itens: 1, total: 1 } }
]

//C) Soma total de todos os pedidos de um cliente (aggregate)
[
  { $match: { cliente_id: 1 } },
  { $unwind: "$itens" },
  { $group: {
      _id: "$pedido_id",
      total_pedido: { $sum: { $multiply: ["$itens.quantidade", "$itens.preco_unitario"] } },
      cliente_id: { $first: "$cliente_id" },
      data: { $first: "$data" }
  }},
  { $sort: { data: 1 } }
]

//D) Listar pedidos com total direto (sem lookup)
[
  { $unwind: "$itens" },
  { $group: {
      _id: "$pedido_id",
      total: { $sum: { $multiply: ["$itens.quantidade", "$itens.preco_unitario"] } },
      cliente_id: { $first: "$cliente_id" }
  }},
  { $project: { _id: 0, pedido_id: "$_id", cliente_id: 1, total: 1 } }
]


