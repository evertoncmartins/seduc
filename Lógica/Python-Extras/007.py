# Construa um algoritmo que leia uma quantidade indeterminada de números inteiros positivos e identifique qual foi o maior número digitado. O programa deve parar quando o usuário digitar um número negativo.

num_maior = None

while True:
    num = int(input('Digite um numero inteiro positivo (ou número negativo para sair): '))

    if num < 0:
        break

    if num > 0 and num is not None or num > num_maior:
        num_maior = num

print('Número maior: ', num_maior)
