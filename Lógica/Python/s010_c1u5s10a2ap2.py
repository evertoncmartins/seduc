# Definindo a palavra secreta e o número máximo de tentativas
palavra_secreta = "abacaxi"
max_tentativas = 3

# Iniciando o jogo
letras_descobertas = ['_'] * len(palavra_secreta)
tentativas_erradas = 0

print("Bem-vindo ao jogo de adivinhação de palavras!")
print("A palavra tem", len(palavra_secreta), "letras.")

while '_' in letras_descobertas and tentativas_erradas < max_tentativas:
    print("\nPalavra atual:", " ".join(letras_descobertas))
    letra = input("Digite uma letra: ").lower()

    if len(letra) != 1 or not letra.isalpha():
        print("Por favor, digite apenas uma letra válida.")
        continue

    if letra in palavra_secreta:
        print("Boa! A letra", letra, "está na palavra.")
        for i in range(len(palavra_secreta)):
            if palavra_secreta[i] == letra:
                letras_descobertas[i] = letra
    else:
        print("Ops! A letra", letra, "não está na palavra.")
        tentativas_erradas += 1

    print("Tentativas restantes:", max_tentativas - tentativas_erradas)

if '_' not in letras_descobertas:
    print("\nParabéns! Você adivinhou a palavra:", palavra_secreta)
else:
    print("\nVocê não conseguiu adivinhar a palavra. A palavra era:", palavra_secreta)
