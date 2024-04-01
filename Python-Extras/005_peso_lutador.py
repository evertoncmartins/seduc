""" 
Desenvolva um programa em Python que solicite ao usuário que insira o preço e a quantidade de três itens diferentes comprados em uma loja. O programa deve calcular o preço total da compra, multiplicando o preço de cada item pela quantidade comprada e somando os resultados. Após o cálculo, o programa deve exibir o preço total da compra. 

Desenvolva um programa em Python que solicite ao usuário que insira o peso de um lutador de boxe. O programa deve verificar em qual categoria de peso o lutador se enquadra, de acordo com as seguintes faixas:

- Peso Galo: até 57 kg
- Peso Pluma: acima de 57 kg e até 61 kg
- Peso Leve: acima de 61 kg e até 69 kg
- Peso Meio-Médio: acima de 69 kg e até 75 kg
- Peso Médio: acima de 75 kg e até 81 kg
- Peso Meio-Pesado: acima de 81 kg e até 91 kg
- Peso Pesado: acima de 91 kg
"""

peso = float(input("Digite o peso do lutador: "))

if peso <= 57:
    print("Peso Galo")
elif peso <= 61:
    print("Peso Pluma")
elif peso <= 69:
    print("Peso Leve")
elif peso <= 75:
    print("Peso Meio-Médio")
elif peso <= 81:
    print("Peso Médio")
elif peso <= 91:
    print("Peso Médio-Pesado")
else:
    print("Peso Pesado")
