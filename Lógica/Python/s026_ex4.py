import random

# Definindo o número de linhas e colunas
l = 5
c = 24

# Criando a matriz de 10x24 com valores aleatórios entre 0 e 35
temperaturas = [[random.randint(0, 40) for _ in range(c)] for _ in range(l)]

# Calculando a temperatura média de cada dia e identificando os dias com média superior a 20°C
dias_acima_20 = []

for i, dia in enumerate(temperaturas):
    media = sum(dia) / len(dia)
    print(f"Dia {i + 1}: Média de temperatura = {media:.2f}°C")
    
    if media > 20:
        dias_acima_20.append(i + 1)

# Exibindo os dias em que a média de temperatura foi superior a 20°C
if dias_acima_20:
    print("\nDias em que a temperatura média foi superior a 20°C:", dias_acima_20)
else:
    print("\nNenhum dia teve temperatura média superior a 20°C.")
