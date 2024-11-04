import random

# Geração do tabuleiro 3x3 com todos os elementos como 1, exceto um zero em posição aleatória
tabuleiro = [[1 for _ in range(3)] for _ in range(3)]
zero_linha, zero_coluna = random.randint(0, 2), random.randint(0, 2)
tabuleiro[zero_linha][zero_coluna] = 0

# Contador de tentativas
tentativas = 0
encontrou_zero = False

# Loop do jogo até o jogador encontrar o zero
while not encontrou_zero:
    # Mostrar o tabuleiro ao jogador (sem revelar o zero)
    for linha in tabuleiro:
        print(" ".join("1" for _ in linha))
    print()

    # Entrada do jogador
    linha = int(input("Escolha uma linha (0-2): "))
    coluna = int(input("Escolha uma coluna (0-2): "))

    # Verifica se a entrada está dentro dos limites
    if linha not in range(3) or coluna not in range(3):
        print("Posição inválida. Escolha números entre 0 e 2.")
        continue

    # Verifica se encontrou o zero
    if linha == zero_linha and coluna == zero_coluna:
        print("Parabéns! Você encontrou o zero!")
        encontrou_zero = True
    else:
        print("Não há zero aqui. Tente novamente.")
        tentativas += 1

# Resultado final
print(f"Você encontrou o zero em {tentativas + 1} tentativas!")
