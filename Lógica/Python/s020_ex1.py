# Exemplo 1

# Simulando do...while em Python

while True:
    num = int(input('Digite um número inteiro positivo: '))
    print(f'Resultado: {num * 3}')

    resposta = input('Deseja continuar (S / N)?: ').lower()

    if resposta != 's':
        print('Fim')
        break
