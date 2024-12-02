# 1. Use a compreensão de listas para gerar uma lista de números pares de 0 a 20
numeros_pares = [x for x in range(21) if x % 2 == 0]

# 2. Use a compreensão de listas para calcular o quadrado de cada número na lista
quadrados_pares = [x**2 for x in numeros_pares]

# 3. Exiba as duas listas
print("Números pares de 0 a 20:", numeros_pares)
print("Quadrados dos números pares:", quadrados_pares)
