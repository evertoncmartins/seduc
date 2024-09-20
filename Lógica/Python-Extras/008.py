# Desenvolver um algoritmo que efetue a soma de todos os números ímpares que são múltiplos de três no intervalo de 1 até 500.

# Inicializando a variável para armazenar a soma
soma = 0

# Percorrendo o intervalo de 1 a 500
for numero in range(1, 501):
    # Verifica se o número é ímpar e múltiplo de 3
    if numero % 2 != 0 and numero % 3 == 0:
        soma += numero

# Exibe o resultado
print(f"A soma dos números ímpares que são múltiplos de três no intervalo de 1 a 500 é: {soma}")
