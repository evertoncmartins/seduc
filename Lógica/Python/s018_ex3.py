# Leitura dos valores de C (distância a correr) e N (comprimento da pista)
C = int(input("Digite a distância que Leonardo vai correr (C) em metros: "))
N = int(input("Digite o comprimento da pista (N) em metros: "))

# Calcula o ponto de término
ponto_termino = C % N

# Imprime o resultado
print(ponto_termino)
