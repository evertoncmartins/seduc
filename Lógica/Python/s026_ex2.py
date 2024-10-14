l = 12
c = 12
matriz = [[0 for _ in range(c)] for _ in range(l)]

linha = int(input('Digite a linha (0 a 11): '))
operacao = input('Digite a operação S (soma) / M (média): ').upper()
soma = 0

# Preenchendo a linha específica da matriz com valores do usuário
for j in range(c):
    matriz[linha][j] = float(input(f'matriz[{linha},{j}]: '))

# Mostrando a matriz para conferência
for v in matriz:
    print(v)
print()

# Calculando a soma ou a média da linha especificada
for j in range(c):
    soma += matriz[linha][j]

if operacao == 'S':
    print(f'Soma: {soma}')
elif operacao == 'M':
    media = soma / c
    print(f'Média: {media}')
else:
    print("Operação inválida!")
