severidade = int(input('Informe a severidade do risco (1 a 5): '))
probabilidade = int(input('Informe a probabilidade do risco (1 a 5): '))

if severidade > 3 and probabilidade > 3:
    print('Risco de alta prioridade.')
elif severidade > 3 or probabilidade > 3:
    print('Risco de média prioridade.')
else:
    print('Risco de baixa prioridade.')
