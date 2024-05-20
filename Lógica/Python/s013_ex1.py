def switch_dia(dia):
    dias = {
        1: "Segunda-feira",
        2: "Terça-feira",
        3: "Quarta-feira",
        4: "Quinta-feira",
        5: "Sexta-feira",
        6: "Sábado",
        7: "Domingo",

    }
    return dias.get(dia, "Dia inválido")


dia_selecionado = switch_dia(3)
print("O dia é:", dia_selecionado)
