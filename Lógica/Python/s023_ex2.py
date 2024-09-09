def direito_ferias(tempo, mes):
    alta_temporada = ['janeiro', 'julho', 'dezembro']

    if tempo >= 3:
        return True
    elif tempo <= 3 and mes in alta_temporada:
        return False
    else:
        return True


# Teste do programa
tempo = int(input("Digite o tempo de serviço do funcionário: "))
mes = input("Digite o mês pretendido das férias: ")

if direito_ferias(tempo, mes):
    print("Acesso Permitido.")
else:
    print("Acesso Negado.")
