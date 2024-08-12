# Lê o valor de N
N = int(input('Digite um valor para N: '))

# Itera sobre o intervalo de 1 a N
for i in range(1, N + 1):
    # Imprime a primeira linha
    print(f'{i} {i * i} {i * i * i}')
    # Imprime a segunda linha
    print(f'{i} {i * i + 1} {i * i * i + 1}')
