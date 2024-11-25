# Solicita inputs do usuário
pontuacao = int(input("Digite a pontuação de desempenho (0 a 100): "))
presenca_percentual = int(input("Digite a porcentagem de presença (0 a 100): "))

# Valida as entradas
if not (0 <= pontuacao <= 100 and 0 <= presenca_percentual <= 100):
    print("Valores de entrada inválidos. Certifique-se de que a pontuação e a presença estejam entre 0 e 100.")
else:
    # Avalia o desempenho
    if pontuacao >= 80:
        if presenca_percentual >= 90:
            categoria = "Excelente"
        else:
            categoria = "Bom"
    elif 50 <= pontuacao <= 79:
        if presenca_percentual >= 75:
            categoria = "Bom"
        else:
            categoria = "Regular"
    else:
        categoria = "Ruim"

    # Imprime o resultado
    print(f"Categoria do funcionário: {categoria}")