custo = float(input('Digite o custo de implementação (em R$): '))
impacto = int(input('Digite o impacto esperado (1 a 10): '))

if custo < 50000 and impacto >= 7:
    print('Política classificada como Viável')
else:
    print('Política classificada como Análise Adicional Necessária')
