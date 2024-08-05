# Leitura dos valores de C, P e F
C = int(input("Digite o número de competidores: "))
P = int(input("Digite a quantidade de folhas de papel compradas: "))
F = int(input("Digite a quantidade de folhas que cada competidor deve receber: "))

# Calcula o número total de folhas necessárias
total_folhas_necessarias = C * F

# Verifica se a quantidade comprada é suficiente
if P >= total_folhas_necessarias:
    print('S')  # Suficiente
else:
    print('N')  # Não suficiente
