# Solicita a pontuação ao usuário
pontuacao = int(input("Digite a pontuação final do jogo: "))

# Determina o resultado usando o operador ternário
resultado = "Ganhou" if pontuacao >= 50 else "Perdeu"

# [verdadeiro] if condicao else [falso]

# Imprime o resultado
print(resultado)