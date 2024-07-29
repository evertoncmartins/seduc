# Descrição: Você foi contratado por uma empresa de segurança da informação e recebeu a tarefa de desenvolver um sistema de controle de acesso para um escritório. O acesso ao escritório é permitido com base no cargo e no dia da semana. Por exemplo, gerentes têm acesso irrestrito, enquanto estagiários só têm acesso em dias úteis.

# Enunciado: Crie um programa que receba o cargo do funcionário (por exemplo, "gerente", "analista", "estagiário") e o dia da semana (por exemplo, "segunda-feira", "sábado"). O programa deve decidir se o acesso ao escritório é permitido ou não.

# Definindo os cargos com acesso irrestrito
acesso_irrestrito = ["gerente"]
    
# Definindo os cargos com acesso restrito a dias úteis
acesso_dias_uteis = ["analista", "estagiário"]
    
# Definindo os dias úteis
dias_uteis = ["segunda-feira", "terça-feira", "quarta-feira", "quinta-feira", "sexta-feira"]

cargo = input('Digite o cargo: ').strip().lower()
dia = input('Digite o dia: ').strip().lower()

if cargo in acesso_irrestrito:
    print('Acesso permitido.')
elif cargo in acesso_dias_uteis and dia in dias_uteis:
    print('Acesso permitido.')
else:
    print('Acesso negado.')


# Outra maneira de fazer 
# if cargo == 'gerente':
#     print('Acesso permitido.')
# elif cargo == 'analista' or cargo == 'estagiário' and dia == 'segunda=feira' or dia == 'terça-feira':
#     print('Acesse permitido')
# else:
#     print('Acesso negado')