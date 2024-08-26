# Matriz representando o hotel: cada sublista é um andar e cada elemento é um quarto
hotel = [
    ['ocupado', 'vazio', 'ocupado'],
    ['vazio', 'vazio', 'ocupado'],
    ['ocupado', 'ocupado', 'vazio']
]

# Inicializar a contagem total de quartos vazios
total_vazios = 0

# Percorrer cada andar na matriz
for andar in hotel:
    # Contar os quartos vazios no andar atual
    total_vazios += andar.count('vazio')

# Exibir o total de quartos vazios
print(f"Total de quartos disponíveis: {total_vazios}")
