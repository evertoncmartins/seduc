peso = float(input('Digite o peso em kg: '))
altura = float(input('Digite a sua altura em metros: '))

imc = peso / (altura ** 2)

if imc < 18.5:
    status = 'Abaixo do peso'
elif imc < 25:
    status = 'Peso normal'
elif imc < 30:
    status = 'Sobrepeso'
else:
    status = 'Obeso'

print('O Seu peso é: {:.2f}'.format(imc))
print('Status: {}'.format(status))
