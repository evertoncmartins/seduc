# Bliblioteca para gerar números randomicos
import random

# Variáveis para controlar linhas e colunas
l = 3
c = 3

# Criando a matriz com valores aleatórios
matrizA = [[random.randint(0, 9) for _ in range(c)] for _ in range(l)]
matrizB = [[random.randint(0, 9) for _ in range(c)] for _ in range(l)]
matrizC = [[0 for _ in range(c)] for _ in range(l)]

print('\nMatriz A')

for i in range(l):
    for j in range(c):
        print(f'{matrizA[i][j]:3}', end=' ')
    print()

print('\nMatriz B')

for i in range(l):
    for j in range(c):
        print(f'{matrizB[i][j]:3}', end=' ')
    print()

# Operação entre as Matrizes A e B
for i in range(l):
    for j in range(c):
        matrizC[i][j] = matrizA[i][j] + matrizB[i][j]

print('\nMatriz C')

for i in range(l):
    for j in range(c):
        print(f'{matrizC[i][j]:3}', end=' ')
    print()

print('\nMatriz C')

for elemento in matrizC:
    print(elemento)
