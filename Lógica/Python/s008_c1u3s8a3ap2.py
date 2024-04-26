"""
Uma empresa tem uma vaga de emprego que requer:
- Pelo menos 3 anos de experiência em Python E
- Pelo menos 2 anos de experiência em machine learning OU
- Um diploma de mestrado em ciência da computação.
Escreva um programa que determine se um candidato é elegível para a vaga.
"""

exp_python = int(input("Tempo de experiência com Python: "))
exp_ml = int(input("Tempo de experiência com Machine Learning: "))
diploma = input(
    "Tem diploma de mestrado em Ciência da Computação? (S/N): ").lower()

if (exp_python >= 3 and exp_ml >= 2) or diploma == 's':
    print("É elegível para a vaga.")
else:
    print("Não é elegível para a vaga.")
