import random


def criar_tabuleiro():
    # Cria uma matriz 3x3 preenchida com 0s (representando terrenos vazios)
    tabuleiro = [[0 for _ in range(3)] for _ in range(3)]
    # Define uma posição aleatória para o tesouro
    linha_tesouro = random.randint(0, 2)
    coluna_tesouro = random.randint(0, 2)
    # Coloca o tesouro na posição aleatória escolhida
    tabuleiro[linha_tesouro][coluna_tesouro] = 1
    return tabuleiro, linha_tesouro, coluna_tesouro


def imprimir_tabuleiro_oculto():
    # Exibe o tabuleiro oculto ao jogador, sem revelar o tesouro
    for i in range(3):
        print(" ".join("?" for _ in range(3)))
    print()


def jogar():
    tabuleiro, linha_tesouro, coluna_tesouro = criar_tabuleiro()
    tentativas = 0

    print("Bem-vindo ao jogo 'Encontre o Tesouro'!")
    print("O tesouro está escondido em uma matriz 3x3.")
    imprimir_tabuleiro_oculto()

    while True:
        try:
            # Recebe as coordenadas do jogador
            linha = int(input("Escolha uma linha (0, 1 ou 2): "))
            coluna = int(input("Escolha uma coluna (0, 1 ou 2): "))

            # Verifica se a entrada está dentro dos limites
            if linha not in range(3) or coluna not in range(3):
                print("Posição inválida. Escolha números entre 0 e 2.")
                continue

            tentativas += 1

            # Verifica se o jogador encontrou o tesouro
            if linha == linha_tesouro and coluna == coluna_tesouro:
                print(f"Parabéns! Você encontrou o tesouro em {
                      tentativas} tentativas!")
                break
            else:
                print("Não há tesouro nessa posição. Tente novamente.")
                imprimir_tabuleiro_oculto()

        except ValueError:
            print("Entrada inválida. Por favor, insira números inteiros.")


# Inicia o jogo
jogar()
