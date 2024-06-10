qualidade_do_ar = int(input('Digite a qualidade do ar (0-100): '))

if qualidade_do_ar > 80:
    print('Qualidade do ar excelente. Mantenha as políticas atuais.')
elif qualidade_do_ar > 60:
    print('Qualidade do ar boa. Considere políticas moderadas de melhoria.')
else:
    print('Qualidade do ar ruim. Implementar políticas rigorosas de melhoria.')
