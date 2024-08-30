# Inicializa uma lista para armazenar as notas válidas
notas_validas = []

# Continua pedindo notas até que duas notas válidas sejam inseridas
while len(notas_validas) < 2:
    nota = float(input('Digite a nota: '))

    # Verifica se a nota é válida
    if 0 <= nota <= 10:
        notas_validas.append(nota)
    else:
        print("nota inválida")

# Calcula a média das duas notas válidas
media = sum(notas_validas) / 2

# Exibe a média com duas casas decimais
print(f"média = {media:.2f}")
