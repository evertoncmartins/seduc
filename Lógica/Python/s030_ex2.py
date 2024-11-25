# Solicita inputs do usuário
idade = int(input("Digite sua idade: "))
preferencia = input("Digite sua preferência (ação, comédia, drama): ").lower()

# Valida a preferência
if preferencia not in ("ação", "comédia", "drama"):
    print("Preferência inválida. Escolha entre ação, comédia ou drama.")
else:
    # Recomenda o filme com base na idade e preferência
    if idade >= 18:
        if preferencia == "ação" or preferencia == "comédia":
            recomendacao = "Recomendamos um filme de ação ou comédia para adultos."
        elif preferencia == "drama":
            recomendacao = "Recomendamos um filme de drama para adultos."
    else:
        if preferencia == "ação" or preferencia == "comédia":
            recomendacao = "Recomendamos um filme de ação ou comédia para adolescentes."
        elif preferencia == "drama":
            recomendacao = "Recomendamos um filme de drama para adolescentes."

    # Imprime a recomendação
    print(recomendacao)