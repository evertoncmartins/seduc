"""
Crie um programa que verifique se uma pessoa pode solicitar uma carteira de motorista com base nas seguintes regras:
- A pessoa deve ter 18 anos ou mais.
- A pessoa deve passar por um exame médico.
- A pessoa não deve ter nenhuma violação de trânsito registrada.
"""

idade = int(input("Digite a idade: "))
exame = input("Passou no exame médico? (S/N): ").lower()
violacao = input("Teve alguma violação de trânsito? (S/N): ").lower()

if idade >= 18 and exame == 's' and violacao == 'n':
    print("Você está apto para solicitar sua carteira de motorista")
else:
    print("Você NÃO está apto para solicitar sua carteira de motorista")
