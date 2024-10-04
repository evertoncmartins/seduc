# Vendas mensais (janeiro a dezembro)
vendas_mensais = [120, 130, 140, 150, 160, 170, 160, 150, 140, 130, 120, 110]

# Função para calcular o total anual de vendas
def total_vendas(vendas):
    return sum(vendas)

# Função para calcular a média mensal de vendas
def media_vendas(vendas):
    return sum(vendas) / len(vendas)

# Função para determinar o mês com a máxima venda
def mes_max_vendas(vendas):
    max_venda = max(vendas)
    mes = vendas.index(max_venda) + 1  # +1 para ajustar ao índice de 1 a 12
    return mes, max_venda

# Exemplo de uso
total_anual = total_vendas(vendas_mensais)
media_mensal = media_vendas(vendas_mensais)
mes_max, max_venda = mes_max_vendas(vendas_mensais)

# Exibição dos resultados
print(f"Total anual de vendas: {total_anual} unidades")
print(f"Média mensal de vendas: {media_mensal:.2f} unidades")
print(f"Mês com a máxima venda: Mês {mes_max} com {max_venda} unidades vendidas")
