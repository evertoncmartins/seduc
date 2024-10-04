# Estoque inicial dos 5 produtos
estoque = [20, 15, 10, 30, 5]

# Função para exibir o estoque atual
def exibir_estoque(estoque):
    print("Estoque atual:")
    for i, quantidade in enumerate(estoque):
        print(f"Produto {i+1}: {quantidade} unidades")
    print()

# Função para atualizar estoque após uma venda
def vender_produto(estoque, produto_id, quantidade_vendida):
    if estoque[produto_id] >= quantidade_vendida:
        estoque[produto_id] -= quantidade_vendida
        print(f"Venda realizada! {quantidade_vendida} unidade(s) do Produto {produto_id + 1} vendida(s).")
    else:
        print(f"Estoque insuficiente! Produto {produto_id + 1} tem apenas {estoque[produto_id]} unidade(s).")
    exibir_estoque(estoque)

# Função para adicionar unidades ao estoque
def adicionar_estoque(estoque, produto_id, quantidade_adicionada):
    estoque[produto_id] += quantidade_adicionada
    print(f"{quantidade_adicionada} unidade(s) adicionada(s) ao Produto {produto_id + 1}.")
    exibir_estoque(estoque)

# Exemplo de uso
exibir_estoque(estoque)  # Exibir o estoque inicial

# Realizar uma venda de 3 unidades do Produto 2 (índice 1)
vender_produto(estoque, 1, 3)

# Adicionar 5 unidades ao Produto 5 (índice 4)
adicionar_estoque(estoque, 4, 5)
