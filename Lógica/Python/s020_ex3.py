# Elaborar um programa que apresente como resultado os quadrados dos números inteiros existentes na faixa de valores de 15 a 200.

num = 15

while True:
    # Calcula e exibe o quadrado do número atual
    print(f'O quadrado de {num} é {num ** 2}')

    # Incrementa o número para o próximo valor na faixa
    num += 1

    # Verifica se o número chegou ao limite superior da faixa
    if num > 200:
        break
