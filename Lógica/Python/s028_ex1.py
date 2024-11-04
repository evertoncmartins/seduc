import random

def generate_board():
    """Cria uma matriz 3x3 com o tesouro em uma posição aleatória."""
    board = [[0 for _ in range(3)] for _ in range(3)]
    # Coloca o tesouro em uma posição aleatória
    treasure_row = random.randint(0, 2)
    treasure_col = random.randint(0, 2)
    board[treasure_row][treasure_col] = 1
    return board

def display_board(board, revealed_positions):
    """Mostra o tabuleiro com posições reveladas."""
    for i in range(3):
        row = []
        for j in range(3):
            if (i, j) in revealed_positions:
                row.append(board[i][j])
            else:
                row.append("?")
        print(" ".join(str(cell) for cell in row))

def find_treasure():
    board = generate_board()
    revealed_positions = set()
    attempts = 0

    print("Bem-vindo ao jogo 'Encontre o Tesouro'!")
    print("Tente encontrar o tesouro em um tabuleiro 3x3.")

    while True:
        display_board(board, revealed_positions)
        try:
            row = int(input("Escolha uma linha (0, 1, ou 2): "))
            col = int(input("Escolha uma coluna (0, 1, ou 2): "))
            if row < 0 or row > 2 or col < 0 or col > 2:
                print("Posição inválida. Escolha números entre 0 e 2.")
                continue
        except ValueError:
            print("Entrada inválida. Por favor, insira números inteiros.")
            continue

        attempts += 1
        revealed_positions.add((row, col))

        if board[row][col] == 1:
            print(f"Parabéns! Você encontrou o tesouro em {attempts} tentativas!")
            break
        else:
            print("Nada aqui! Continue procurando.")

# Executa o jogo
find_treasure()
