"""
Um site de vendas on-line oferece descontos em livros com base nas seguintes regras:
- Se o livro é um best-seller OU foi lançado há mais de 2 anos, ele tem 20% de desconto.
- Se um cliente está comprando mais de 3 livros, ele tem um desconto adicional de 5%.
Escreva um programa que aplique essas regras e calcule o preço final do livro.
"""

# Solicita informações sobre o livro
best = input("O livro é best-seller? (S/N): ").lower()
lancamento = int(input("Quanto tempo o livro foi lançado?: "))
qtde_compra = int(input("Quantos livros está comprando?: "))
valor = float(input("Digite o valor total da compra: "))

# Calcula o desconto baseado nas regras
desconto = 0

if best == 's' or lancamento > 2:
    desconto += 0.20
if qtde_compra >= 3:
     desconto += 0.05

 # Calcula o preço final com desconto
preco_final = valor - (valor * desconto)   

# Exibe o preço final
print("Total: {:.2f}".format(preco_final))