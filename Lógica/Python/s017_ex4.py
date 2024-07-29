# Detalhes do Exercício:

# Na empresa que você trabalha, identificou que uma das principais dificuldades das pessoas é agendar a sala certa para a realização das reuniões de acordo com o número de pessoas presentes. Dessa forma, você está desenvolvendo um sistema de agendamento de reuniões para uma empresa. O sistema deve ajudar a definir a sala de reunião adequada com base no número de participantes e no tipo de reunião. A empresa tem três tipos de salas:

# 1.	Sala Pequena: ideal para reuniões com até 5 pessoas.
# 2.	Sala Média: adequada para reuniões de 6 a 15 pessoas.
# 3.	Sala Grande: para reuniões com mais de 15 pessoas ou reuniões executivas.

# Entrada:
# •	Número de participantes (inteiro);
# •	Tipo de reunião (string): "normal" ou "executiva".
# Saída:
# •	Recomendação da sala (string): "Sala Pequena", "Sala Média" ou "Sala Grande".

def recomendar_sala(numero_participantes, tipo_reuniao):

    if numero_participantes <= 5 and tipo_reuniao == 'normal':
        sala = 'Sala pequena'
    elif 6 <= numero_participantes <= 15 and tipo_reuniao == 'normal':
        sala = 'Sala média'
    else:
        sala = 'Sala grande'

    return sala


numero_participantes = int(input('Número de participantes: '))
tipo_reuniao = input('Tipo de reunião (normal ou executiva): ').strip().lower()

sala = recomendar_sala(numero_participantes, tipo_reuniao)

print(f'Sala recomendada: {sala}')
