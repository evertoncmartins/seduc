risco = input(
    'Digite o tipo de risco (Operacional, Financeiro, Mercado): ').lower()
if risco == 'operacional':
    print('Risco Operacional identificado.')
elif risco == 'financeiro':
    print('Risco Financeiro identificado.')
elif risco == 'mercado':
    print('Risco de Mercado identificado.')
else:
    print('Tipo de risco não identificado.')
