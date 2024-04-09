# Uma livraria decidiu implementar um sistema de descontos para seus clientes com base na quantidade de livros comprados.

# O sistema de descontos é definido da seguinte maneira::

# Se o cliente comprar 1 livro, não terá desconto;
# Se o cliente comprar 2 ou 3 livros, terá um desconto de 10% sobre o valor total;
# Se o cliente comprar 4 ou 5 livros, terá um desconto de 20% sobre o valor total;
# Se o cliente comprar 6 ou mais livros, terá um desconto de 30% sobre o valor total.

# Descreva as estruturas de seleção (“if, elif, else”) necessárias para implementar este sistema de descontos.
# Se um cliente comprar 5 livros e o valor total, antes do desconto, for de R$ 150,00, quanto ele pagará após a aplicação do desconto?
# Como você adaptaria o código para incluir uma nova regra que diz que: se o cliente for membro de um clube de leitura, ele terá um desconto adicional de 5%, independentemente da quantidade de livros adquiridos?

qtde = int(input("Quantidade de livro comprado: "))
membro = int(input("É membro do clube de leitura (1 = sim e 2 = não): "))

if membro == 1:

    if qtde <= 1:
        print("Não tem desconto")
    elif qtde <= 3:
        print("Desconto de 15%")
    elif qtde <= 5:
        print("Desconto de 25%")
    else:
        print("Desconto de 35%")

else:

    if qtde <= 1:
        print("Não tem desconto")
    elif qtde <= 3:
        print("Desconto de 10%")
    elif qtde <= 5:
        print("Desconto de 20%")
    else:
        print("Desconto de 30%")
