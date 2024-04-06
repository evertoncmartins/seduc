"""
Faça um programa em Python que solicite a quantidade de um produto desejado pelo cliente e verifique se há disponibilidade em estoque. Considere que o estoque mínimo é 10 unidades. 

Portanto, se a quantidade desejada for maior ou igual a 10, exiba a mensagem: "Produto disponível em estoque. Aproveite!". Caso contrário, mostre a mensagem: "Produto indisponível no momento. Volte mais tarde!".

"""
qtde = int(input("Digite a qtde do produto em estoque: "))

if qtde >= 10:
    print("Produto disponível em estoque. Aproveite!")
else:
    print('Produto indisponível no momento. Volte mais tarde!')
