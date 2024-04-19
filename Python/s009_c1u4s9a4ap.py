import random

# Gerar um número inteiro aleatório entre 1 e 100
num_aleatorio = random.randint(1, 5)

tentativas = 0

while True:
    numero = int(input('Adivinhe o número: '))
    tentativas += 1

    if numero == num_aleatorio:
        print('Parabéns você acertou! Tentativas {}'.format(tentativas))
        break #esse comando para o loop infinito
    elif numero > num_aleatorio:
        print('Tente outra vez, o número secreto é menor.')
    else:
        print('Tente outra vez, o número secreto é maior.')
