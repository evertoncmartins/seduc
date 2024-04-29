valor = int(input('Digite o valor do saque: '))

nota_100 = 0
nota_50 = 0
nota_20 = 0
nota_10 = 0
nota_5 = 0
nota_2 = 0
moeda_1 = 0
moeda_50 = 0
moeda_25 = 0
moeda_10 = 0
moeda_5 = 0
moeda_1 = 0

while valor >= 100:
    nota_100 += 1
    valor -= 100

while valor >= 50:
    nota_50 += 1
    valor -= 50

while valor >= 20:
    nota_20 += 1
    valor -= 20

while valor >= 10:
    nota_10 += 1
    valor -= 10

while valor >= 5:
    nota_5 += 1
    valor -= 5

while valor >= 2:
    nota_2 += 1
    valor -= 2

print(f'{nota_100} notas de 100')
print(f'{nota_50} notas de 50')
print(f'{nota_20} notas de 20')
print(f'{nota_10} notas de 10')
print(f'{nota_5} notas de 5')
print(f'{nota_2} notas de 2')
