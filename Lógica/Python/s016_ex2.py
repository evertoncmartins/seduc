def conversao(qtde_dia):
    ano = 0
    mes = 0
    dias = 0

    while qtde_dia > 0:
        if qtde_dia >= 365:
            ano += 1
            qtde_dia -= 365
        elif qtde_dia >= 30:
            mes += 1
            qtde_dia -= 30
        else:
            dias += 1
            qtde_dia -= 1

    return f'Ano: {ano}, Mês: {mes}, Dia: {dias}'


qtde_dia = 800
resultado = conversao(qtde_dia)
print(resultado)
