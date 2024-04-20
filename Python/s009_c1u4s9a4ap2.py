idade = int(input('Digite a idade: '))

if idade <= 12:
    print('Criança')
elif idade <= 17:
    print('Adolescente')
elif idade <= 64:
    print('Adulto')
else:
    print('Idoso')
