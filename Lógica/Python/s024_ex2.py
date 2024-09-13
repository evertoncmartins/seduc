# Simulação de dados de vendas mensais para produtos (6 meses)
vendas_mensais = {
    'Produto A': [100, 120, 130, 140, 150, 160],
    'Produto B': [200, 190, 180, 170, 160, 150],
    'Produto C': [300, 310, 320, 330, 340, 350],
    'Produto D': [400, 410, 405, 400, 395, 390],
}

# Inicializa listas para armazenar os resultados
aumento = []
diminuicao = []

# Percorre cada produto e suas vendas
for produto, vendas in vendas_mensais.items():
    # Verifica se as vendas aumentam ou diminuem
    if vendas == sorted(vendas):  # Se a lista estiver em ordem crescente
        aumento.append(produto)
    elif vendas == sorted(vendas, reverse=True):  # Se a lista estiver em ordem decrescente
        diminuicao.append(produto)

# Exibe os resultados
print("Produtos com aumento contínuo:", aumento)
print("Produtos com diminuição contínua:", diminuicao)
