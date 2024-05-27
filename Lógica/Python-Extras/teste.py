# Utilizando FOR em um intervalo de números
for numero in range(5):
    print(numero)

# Utilizando FOR com uma lista
frutas = ['maçã', 'banana', 'laranja']
for fruta in frutas:
    print(fruta)

# Utilizando FOR para percorrer uma String
mensagem = "Olá!"
for caractere in mensagem:
    print(caractere)

# Utilizando FOR para criação de uma lista
quadrados = [x**2 for x in range(5)]
print(f'{quadrados}')

# Utilizando FOR com dicionários
dados = [{'nome': 'Ana', 'idade': 25},
         {'nome': 'Beto', 'idade': 30}
         ]
for item in dados:
    print(f'{item['nome']} tem {item['idade']} anos')


matriz = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

for linha in matriz:
    for elemento in linha:
        print(elemento, end=" ")
    print()

print('\n \n')
# Exemplo de matriz de dados
# Cada sublista é uma empresa
dados = [[75, 90, 60], [65, 70, 85], [80, 55, 75]]

# Calculando a média de sucesso para cada tipo de projeto
for i in range(len(dados)):
    soma = 0
    for empresa in dados:
        soma += empresa[i]
    media = soma / len(dados)
    print(f'Média do Projeto {i}: {media}')

# Identificar o projeto mais bem-sucedido por empresa
for i, empresa in enumerate(dados):
    projeto_mais_bem_sucedido = max(empresa)
    print(
        f'Empresa {i} - Projeto Mais Bem-Sucedido: {projeto_mais_bem_sucedido}')
