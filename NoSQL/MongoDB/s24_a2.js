// Código completo.
// Criar a Conexão
// Criar o Banco de Dados: LojaDB
// Criar a Coleção: Produtos
// Executar o código: 
[
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
]

// Simular as buscas:
{ "categoria": "Computadores" }

// UPDATE: 

// No campo Filter o MongoDB, digite: 
{
  "nome": "Laptop Gamer"
}

// Após atualize, no Update:
{
  "$set": {
    "preco": 4800,
    "estoque": 8
  }
}

// Para procurar: 
{ "nome": "Laptop Gamer" }

// Procurar produtos acima de 300 reais:
{ "preco": { $gt: 3000 } }