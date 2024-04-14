"""
Uma universidade oferece bolsas de estudos para estudantes que:
- Têm um GPA (Grade Point Average) de 3.5 ou mais, OU
- Estão no top 10% de sua turma, OU
- Realizaram trabalho voluntário por mais de 100 horas no último ano.
Escreva um programa que determine se um estudante é elegível para uma bolsa de estudos.
"""

gpa = float(input("Qual o GPA: "))
top = input("Está no top 10% da turma? (S/N): ").lower()
voluntario = input(
    "Realizou trabalho voluntário por mais de 100 horas? (S/N): ").lower()

if gpa >= 3.5 or top == 's' or voluntario == 's':
    print("Poderá ter bolsa de estudos.")
else:
    print("Não poderá ter bolsa de estudos.")
