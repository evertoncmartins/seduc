"""
Uma pessoa pode doar sangue se:
- tem entre 16 e 69 anos, inclusive.
- pesa 50 kg ou mais.
- não está grávida.
- não doou sangue nos últimos 90 dias.
Escreva um programa que verifique se uma pessoa pode doar sangue ou não.
"""

idade = int(input("Digite a idade: "))
peso = float(input("Digite o seu peso: "))
gravida = input("Está grávida? (S/N): ").lower()
doou = input("Doou sangue nos últimos 90 dias? (S/N): ").lower()

if idade >= 16 and idade <= 69 and peso >= 50 and gravida == 'n' and doou == 'n':
    print("Você pode doar sangue")
else:
    print("Você não pode doar sangue")
