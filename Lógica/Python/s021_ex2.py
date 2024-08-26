# Listas de pontuações e categorias
pontuacoes = [4, 2, 5, 3, 1]
categorias = ["produto", "atendimento", "produto", "entrega", "atendimento"]

# Dicionário para armazenar feedbacks críticos por categoria
feedbacks_criticos = {}

# Filtrar e agrupar feedbacks críticos
for i in range(len(pontuacoes)):
    if pontuacoes[i] < 3:
        categoria = categorias[i]
        if categoria not in feedbacks_criticos:
            feedbacks_criticos[categoria] = 1
        else:
            feedbacks_criticos[categoria] += 1

# Apresentar o resumo dos feedbacks críticos
print("Resumo dos Feedbacks Críticos por Categoria:")
for categoria, quantidade in feedbacks_criticos.items():
    print(f"- {categoria.capitalize()}: {quantidade} feedback(s) crítico(s)")
