def multa_livro(genero, dias):
    multa = {
        "ficcao": dias * 0.50,
        "nao-ficcao": dias * 0.60,
        "referencia": dias
    }

    return multa.get(genero, "Gênero inexistente.")


multa_valor = multa_livro("ficcao", 4)

print(multa_valor)
