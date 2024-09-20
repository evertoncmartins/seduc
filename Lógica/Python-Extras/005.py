#  Escrever um algoritmo que leia uma quantidade desconhecida de números e conte quantos deles estão nos seguintes intervalos: [0-25], [26-50], [51-75] e [76-100]. A entrada de dados deve terminar quando for lido um número negativo.

# Inicializando os contadores para cada intervalo
contador_0_25 = 0
contador_26_50 = 0
contador_51_75 = 0
contador_76_100 = 0

while True:
    # Lê um número do usuário
    numero = int(input("Digite um número (negativo para sair): "))

    # Verifica se o número é negativo para terminar a entrada
    if numero < 0:
        break

    # Conta o número nos intervalos correspondentes
    if 0 <= numero <= 25:
        contador_0_25 += 1
    elif 26 <= numero <= 50:
        contador_26_50 += 1
    elif 51 <= numero <= 75:
        contador_51_75 += 1
    elif 76 <= numero <= 100:
        contador_76_100 += 1

# Exibe os resultados
print(f"Números entre 0 e 25: {contador_0_25}")
print(f"Números entre 26 e 50: {contador_26_50}")
print(f"Números entre 51 e 75: {contador_51_75}")
print(f"Números entre 76 e 100: {contador_76_100}")
