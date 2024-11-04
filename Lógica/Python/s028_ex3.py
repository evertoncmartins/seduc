# Problemas identificados:
# Erro de verificação de tentativa anterior:

# A linha elif grid[x][y] == 'T': está usando a letra 'T' como marcação de tentativa anterior, mas a matriz grid é inicialmente preenchida com números inteiros (0 e 1), então 'T' é um tipo de dado inconsistente.
# Print do tabuleiro oculta a posição do tesouro:

# A função imprimir_tabuleiro(grid) exibe o tesouro (1) como "X", mas deveria ocultar todas as posições com "?" para que o jogador não veja a localização real do tesouro até encontrá-lo.
# Contagem de tentativas:

# A variável tentativas não está sendo incrementada quando o jogador tenta uma posição já marcada. Isso leva a uma contagem incorreta das tentativas.

import random

def criar_tabuleiro():
    """ Cria um tabuleiro 3x3 com um tesouro escondido em uma célula aleatória. """
    grid = [[0 for _ in range(3)] for _ in range(3)]
    tesouro_x, tesouro_y = random.randint(0, 2), random.randint(0, 2)
    grid[tesouro_x][tesouro_y] = 1  # Coloca o tesouro
    return grid

def imprimir_tabuleiro(grid):
    """ Imprime o tabuleiro, escondendo onde está o tesouro. """
    for linha in grid:
        print(' '.join('?' if celula != 'T' else 'X' for celula in linha))

def jogar():
    grid = criar_tabuleiro()
    tentativas = 0

    while True:
        imprimir_tabuleiro(grid)
        try:
            x = int(input("Escolha uma linha (0-2): "))
            y = int(input("Escolha uma coluna (0-2): "))

            # Verifica se a entrada está dentro dos limites do tabuleiro
            if x not in range(3) or y not in range(3):
                print("Entrada inválida. Tente novamente dentro dos limites do tabuleiro.")
                continue

            if grid[x][y] == 1:
                print("Parabéns! Você encontrou o tesouro!")
                tentativas += 1
                break
            elif grid[x][y] == 'T':  # Checa se a tentativa já foi feita
                print("Você já tentou aqui. Tente novamente.")
            else:
                print("Não há tesouro aqui. Tente novamente.")
                grid[x][y] = 'T'  # Marca a tentativa do jogador
                tentativas += 1  # Incrementa tentativas para cada tentativa válida

        except ValueError:
            print("Entrada inválida. Por favor, insira um número.")

    print(f"Você encontrou o tesouro em {tentativas} tentativas!")

# Inicia o jogo
jogar()


