# Matriz de temperatura para 3 cidades ao longo de 4 meses
temperaturas = [
    [30, 32, 29],  # Temperaturas de janeiro para as 3 cidades
    [28, 27, 25],  # Temperaturas de fevereiro
    [26, 24, 22],  # Temperaturas de março
    [24, 23, 20]   # Temperaturas de abril
]

# Função para transpor a matriz


def transpor_matriz(matriz):
    transposta = [[matriz[j][i]
                   for j in range(len(matriz))] for i in range(len(matriz[0]))]
    return transposta


# Exemplo de uso
matriz_transposta = transpor_matriz(temperaturas)

# Exibição da matriz transposta
print("Matriz original (Cidades x Meses):")
for linha in temperaturas:
    print(linha)

print("\nMatriz transposta (Meses x Cidades):")
for linha in matriz_transposta:
    print(linha)
