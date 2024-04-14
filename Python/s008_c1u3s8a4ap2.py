"""
Um banco oferece empréstimos para clientes que:
- Têm uma renda mensal de pelo menos R$ 2000 E
- Têm um score de crédito de pelo menos 600 OU
- Têm um fiador com um score de crédito de pelo menos 700.
Escreva um programa que determine se um cliente é elegível para um empréstimo.
"""

renda = float(input("Qual sua renda?: "))
score = int(input("Qual seu score?: "))
fiador = float(input("Qual score do seu fiador?: "))

if renda >= 2000 and (score >= 600 or fiador >= 700):
    print("Elegível para empréstimo")
else:
    print("Não elegível para empréstimo")
