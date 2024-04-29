import random

num_al = random.randint(1, 10)

tentativas = 0

while True:
    num = int(input('Adivinhe o numero: '))

    tentativas += 1

    if tentativas < 5:
        if num_al == num:
            print(f'Parabéns! Acertou. Qtde de tentativas: {tentativas}')
            break
        elif num_al < num:
            print('Errou! Número secreto é menor')
        else:
            print('Errou! Número secreto é maior')
    else:
        print(f'Excedeu o limite de 5 tentativas. Número secreto é: {num_al}')
