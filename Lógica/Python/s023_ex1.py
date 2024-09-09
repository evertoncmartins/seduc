def pode_acessar(cargo, dia_semana):
    dias_uteis = ["segunda-feira", "terça-feira", "quarta-feira", "quinta-feira",
                  "sexta-feira"]

    # Gerentes têm acesso irrestrito
    if cargo.lower() == "gerente":
        return True
    # Analistas e Estagiários têm acesso somente em dias úteis
    elif (cargo.lower() == "analista" or cargo.lower() == 'estagiário') and dia_semana.lower() in dias_uteis:
        return True
    else:
        return False


# Teste do programa
cargo = input("Digite o cargo do funcionário: ")
dia_semana = input("Digite o dia da semana: ")

if pode_acessar(cargo, dia_semana):
    print("Acesso Permitido.")
else:
    print("Acesso Negado.")
