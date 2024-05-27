# Estrutura de repetição em Python
# Uma estrutura de repeitação, ou loop, é uma construção da programação que permite executar um bloco de código várias vezes de forma automática. 

# Utilizando FOR em um intervalo de números
for i in range(5):
    print(i)

# Utilizando FOR com uma lista
lista_frutas = ['maça', 'banana', 'pera']

for fruta in lista_frutas:
    print(fruta)

# Utilizando FOR para percorrer uma String
mensagem = 'Olá Mundo'
for caractere in mensagem:
    print(caractere)

# Utilizando FOR para criação de uma lista
quadrados = [x**2 for x in range(5)]
print(f'{quadrados}')

# Utilizando FOR com dicionários
dados = [{'nome': 'Ana', 'idade': 18},
         {'nome': 'Everton', 'idade': 32},
         {'nome': 'Andreia', 'idade': 31}]

for item in dados:
    print(f'{item["nome"]}, {item["idade"]}')


print("Número 1")
print("Número 2")
print("Número 3")
print("Número 4")
print("Número 5")

for i in range(1, 6):
    print(f'Número {i}')


# O código ficou mais curto, simples e prático.
# Utilizamos uma estrutura de repetição, chamado FOR. Nesta estrutura foi possível resolver o exercício de uma forma mais rápida, fácil interpretação e eficiente. 
# Foi utilizado uma variável de controle pra iteração i. Colocamos um range de 1 a 6 (pois o 0 conta).
# Por fim, utilizamos o comando print para imprimir o resultado na tela. Utilizamos o formato f, para formatar a string impressa.

soma_par = 0
soma_impar = 0
for i in range(101):
    if i % 2 == 0:
        soma_par = soma_par + i
    else:
        soma_impar = soma_impar + i

print(f'Soma Pares: {soma_par}, Soma impares: {soma_impar}')






soma = 0

for numero in range(1, 100):
    if numero % 2 == 0:
        soma += numero

print(f"Soma dos pares:  {soma}")


