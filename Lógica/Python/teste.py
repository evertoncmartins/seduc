import random

tabuleiro = [[' ' for _ in range(3)] for _ in range(3)]
t_linha, t_coluna = random.randint(0, 2), random.randint(0, 2)
tabuleiro[t_linha][t_coluna] = 1

#Contador de tentativas
tentativas = 0
encontrou_t = False

print('\n Bem-vindo ao jogo!\n')

while not encontrou_t:
    for linha in tabuleiro:
        print(' '.join('?' for _ in linha))
    print()

    # Entrada do jogador
    linha = input('Escolha uma linha (0, 1 ou 2): ')
    coluna = input('Escolha uma coluna (0, 1 ou 2): ')

    # Verifica se a entrada não está vazia e se é válida
    if linha == '' or coluna == '' or not (linha.isdigit() and coluna.isdigit()):
        print('Entrada inválida! Digite corretamente (0, 1 ou 2).')
        continue

    # Converter as entradas apenas após a validação
    linha = int(linha)
    coluna = int(coluna)

    # Verifica se a entra está dentro dos limites
    if linha not in range(3) and coluna not in range(3):
        print('Entrada inválida! Digite corretamente (0, 1 ou 2).')
        continue

    # Verifica se encontrou o tesouro
    if linha == t_linha and coluna == t_coluna:
        print('Parabéns! Você encontrou o Tesouro!')
        encontrou_t = True
    else:
        print('Não foi desta vez!')
        tentativas += 1

# Resultado Final
print(f'Você encontrou em {tentativas+1} tentativas!')