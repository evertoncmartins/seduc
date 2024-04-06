"""
Crie um programa em Python que solicite a nota final de um aluno em uma disciplina e verifique se ele foi aprovado. 
Considere que a nota mínima para aprovação é 7. 
Se a nota do aluno for maior ou igual a 7, exiba a mensagem: "Parabéns! Você foi aprovado.". Caso contrário, mostre a mensagem: "Infelizmente, você não foi aprovado. Estude mais e tente novamente!".
"""

n_final = float(input("Digite a nota final do aluno: "))

if n_final >= 7:
    print("Parabéns! Você foi aprovado.")
else:
    print("Infelizmente, você não foi aprovado. Estude mais e tente novamente!")
