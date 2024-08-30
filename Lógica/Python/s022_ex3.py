qtde = int(input('Quantidade de testes: '))

for i in range(qtde):
    n1 = int(input('Nro 1: '))
    n2 = int(input('Nro 2: '))

    if (n1+n2) %2 != 0:
        print(n1+n2)
    else:
        print(0)
    