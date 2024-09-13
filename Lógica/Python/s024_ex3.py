# Simulação de dados de vendas diárias para vários produtos
vendas_diarias = [
    ('Produto A', 10),
    ('Produto B', 20),
    ('Produto A', 15),
    ('Produto C', 5),
    ('Produto B', 10),
    ('Produto A', 12),
    ('Produto C', 7),
    ('Produto B', 22),
    ('Produto C', 8),
]

# Inicializa dicionários para armazenar o total de vendas e a contagem de dias para cada produto
vendas_totais = {}
dias_por_produto = {}

# Percorre cada venda registrada
for produto, vendas in vendas_diarias:
    if produto in vendas_totais:
        vendas_totais[produto] += vendas  # Soma as vendas
        dias_por_produto[produto] += 1    # Conta o dia
    else:
        vendas_totais[produto] = vendas   # Primeira venda do produto
        dias_por_produto[produto] = 1     # Primeiro dia do produto

# Relatório formatado
print("\n\nRelatório de Vendas\n")
print("{:<15} {:<15} {:<20}".format(
    "Produto", "Total de Vendas", "Média Diária"))
print("-" * 50)

# Exibe o total e a média de vendas diárias por produto em formato de tabela
for produto in vendas_totais:
    total_vendas = vendas_totais[produto]
    media_vendas = total_vendas / dias_por_produto[produto]
    print("{:<15} {:<15} {:.2f}".format(
        produto, total_vendas, media_vendas))
