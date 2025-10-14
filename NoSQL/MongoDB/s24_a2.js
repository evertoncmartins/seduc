// ===============================================
//  MongoDB — Operações CRUD
//  Banco de dados: Loja
// ===============================================


// ---------------------------
// CONFIGURAÇÕES INICIAIS
// ---------------------------

// Acessar o banco de dados
use Loja
// Saída esperada:
// switched to db Loja


// Criar a coleção
db.createCollection("Produtos")
// Saída esperada:
// { "ok" : 1 }



// ---------------------------
// 1. CRIAÇÃO DE DOCUMENTOS
// ---------------------------

// Inserir três produtos na coleção "Produtos"
db.Produtos.insertMany([
  {
    "nome": "Smartphone XYZ",
    "categoria": "Celulares",
    "preco": 2500,
    "estoque": 50,
    "fornecedor": {
      "nome": "Mega Eletrônicos",
      "contato": "contato@megaeletronicos.com"
    }
  },
  {
    "nome": "Laptop Gamer",
    "categoria": "Computadores",
    "preco": 5000,
    "estoque": 10,
    "fornecedor": {
      "nome": "Tech Distribuidora",
      "contato": "tech@distribuidora.com"
    }
  },
  {
    "nome": "Fone de Ouvido sem Fio",
    "categoria": "Áudio",
    "preco": 350,
    "estoque": 100,
    "fornecedor": {
      "nome": "Sons Perfeitos",
      "contato": "contato@sonsperfeitos.com"
    }
  }
])

// Saída esperada:
// {
//   "acknowledged": true,
//   "insertedIds": [
//     ObjectId("..."),
//     ObjectId("..."),
//     ObjectId("...")
//   ]
// }



// ---------------------------
// 2. LEITURA DE DOCUMENTOS
// ---------------------------

// Exibir todos os produtos
db.Produtos.find()
// Saída esperada: lista com os 3 produtos inseridos


// Encontrar um produto da categoria "Computadores"
db.Produtos.find({ "categoria": "Computadores" })
// Saída esperada:
// [
//   {
//     "_id": ObjectId("..."),
//     "nome": "Laptop Gamer",
//     "categoria": "Computadores",
//     "preco": 5000,
//     "estoque": 10,
//     "fornecedor": {
//       "nome": "Tech Distribuidora",
//       "contato": "tech@distribuidora.com"
//     }
//   }
// ]



// ---------------------------
// 3. ATUALIZAÇÃO DE DOCUMENTOS
// ---------------------------

// Atualizar o preço e o estoque do produto "Laptop Gamer"
db.Produtos.updateOne(
  { "nome": "Laptop Gamer" },
  { $set: { "preco": 4800, "estoque": 8 } }
)
// Saída esperada:
// { "acknowledged": true, "matchedCount": 1, "modifiedCount": 1 }

// Verificação:
db.Produtos.find({ "nome": "Laptop Gamer" })



// ---------------------------
// 4. EXCLUSÃO DE DOCUMENTOS
// ---------------------------

// Remover o produto "Fone de Ouvido sem Fio"
db.Produtos.deleteOne({ "nome": "Fone de Ouvido sem Fio" })
// Saída esperada:
// { "acknowledged": true, "deletedCount": 1 }

// Verificação:
db.Produtos.find()
// O produto "Fone de Ouvido sem Fio" não aparecerá mais



// ---------------------------
// DESAFIOS EXTRAS
// ---------------------------

// 1. Buscar produtos com preço maior que 3000
db.Produtos.find({ "preco": { $gt: 3000 } })
// Saída esperada:
// [
//   {
//     "_id": ObjectId("..."),
//     "nome": "Laptop Gamer",
//     "categoria": "Computadores",
//     "preco": 4800,
//     "estoque": 8,
//     "fornecedor": {
//       "nome": "Tech Distribuidora",
//       "contato": "tech@distribuidora.com"
//     }
//   }
// ]


// 2. Atualizar vários documentos (diminuir estoque em 2)
db.Produtos.updateMany(
  { "categoria": "Computadores" },
  { $inc: { "estoque": -2 } }
)
// Saída esperada:
// { "acknowledged": true, "matchedCount": 1, "modifiedCount": 1 }

// Verificação:
db.Produtos.find()
// Estoque do "Laptop Gamer" agora deve ser 6
