"""
Se o custo total for igual ou superior a R$ 100,00, o programa deve calcular e exibir o valor final da compra com um desconto de 10%. 

Caso contrário, deve informar que o usuário não ganhou o desconto, exibindo o valor final da compra por inteiro.

Desenvolva um programa em Python que receba o valor de uma compra realizada em uma loja e aplique ou não o desconto quando conveniente.
"""

valor = float(input("Digite o valor da compra: "))

if valor >= 100:
    print("Valor com desconto de 10%: R${}".format(valor*0.90))
else:
    print("Não ganhou desconto, valor da compra: R${}".format(valor))