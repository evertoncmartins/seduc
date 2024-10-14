import random

# Criação de uma matriz 100x100 com valores aleatórios de 0 a 255 para representar a imagem em escala de cinza
imagem = [[random.randint(0, 255) for _ in range(100)] for _ in range(100)]

# Coordenadas para extrair a ROI central de 10x10
start_row = 45
end_row = start_row + 10
start_col = 45
end_col = start_col + 10

# Extraindo a ROI de 10x10 e calculando a média
soma = 0
contador = 0

for i in range(start_row, end_row):
    for j in range(start_col, end_col):
        soma += imagem[i][j]
        contador += 1

media_intensidade = soma / contador

print(f"Média da intensidade dos pixels na ROI: {media_intensidade:.2f}")
