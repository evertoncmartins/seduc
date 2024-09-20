# Crie um algoritmo que imprima o produto (*) dos números ímpares e a soma (+) dos números pares no intervalo de 0 a 10.

# Inicializando variáveis
produto_impares = 1  # Começa em 1 porque é o elemento neutro da multiplicação
soma_pares = 0

# Percorrendo o intervalo de 0 a 10
for numero in range(0, 11):
    if numero % 2 == 0:  # Verifica se o número é par
        soma_pares += numero
    else:  # Se não for par, é ímpar
        produto_impares *= numero

# Exibindo os resultados
print(f"A soma dos números pares de 0 a 10 é: {soma_pares}")
print(f"O produto dos números ímpares de 0 a 10 é: {produto_impares}")
