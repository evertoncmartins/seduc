# Construir um programa que apresente a soma dos cem primeiros números naturais (1+2+3+...+98+99+100).

# Inicialização das variáveis
soma = 0
num = 1

while True:
    # Adiciona o número atual à soma
    soma += num

    # Incrementa o número para o próximo
    num += 1

    # Verifica se já somou até 100
    if num > 100:
        break

# Exibe o resultado final
print(f'A soma dos cem primeiros números naturais é {soma}')
