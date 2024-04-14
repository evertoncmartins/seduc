"""
Uma academia de artes tem um processo de admissão que inclui o envio de um portfólio e uma audição. A academia admite candidatos que:
- Tenham um portfólio forte OU
- Tenham uma audição excelente e tenham feito pelo menos 2 anos de treinamento prévio.
Escreva um programa que determine se um candidato será admitido ou não.
"""

portifolio = input("Tem portifólio forte? (S/N): ")
audicao = input("Tem audição excelente? (S/N): ")
treinamento = input("Tem 2 anos de treinamento prévio? (S/N): ")

if portifolio == 's' or audicao == 's' and treinamento == 's':
    print("Você pode ser admitido")
else:
    print("Você não pode ser admitido")
