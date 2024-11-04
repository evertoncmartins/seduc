import random

# Geração do tabuleiro 3x3 com todos os elementos vazios, exceto onde tiver o tesouro = '1'
tabuleiro = [[' ' for _ in range(3)] for _ in range(3)]
tesouro_linha, tesouro_coluna = random.randint(0, 2), random.randint(0, 2)
tabuleiro[tesouro_linha][tesouro_coluna] = 1

# Contador de tentativas
tentativas = 0
encontrou_tesouro = False

print('\nBem-vindo ao jogo do Caça ao Tesouro\n')
# Loop do jogo até o jogador encontrar o tesouro, que é 1
while not encontrou_tesouro:
    # Mostrar o tabuleiro ao jogador (sem revelar o tesouro)
    for linha in tabuleiro:
        print(" ".join("?" for _ in linha))
    print()

    # Entrada do jogador
    linha = input("Escolha uma linha (0, 1 ou 2): ")
    coluna = input("Escolha uma coluna (0, 1 ou 2): ")

    # Verifica se a entrada não está vazia e se é válida
    if linha == '' or coluna == '' or not (linha.isdigit() and coluna.isdigit()):
        print("Entrada inválida. Por favor, insira números entre 0 e 2.")
        continue

    # Convertendo as entradas apenas após a validação
    linha = int(linha)
    coluna = int(coluna)

    # Verifica se a entrada está dentro dos limites
    if linha not in range(3) or coluna not in range(3):
        print("Posição inválida. Escolha números entre 0 e 2.")
        continue

    # Verifica se encontrou o tesouro
    if linha == tesouro_linha and coluna == tesouro_coluna:
        print("Parabéns! Você encontrou o tesouro!")
        encontrou_tesouro = True
    else:
        print("Não há tesouro aqui. Tente novamente.")
        tentativas += 1

# Resultado final
print(f"Você encontrou o tesouro em {tentativas + 1} tentativas!")
