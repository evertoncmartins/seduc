# Lê a quantidade de intervalos registrados
n = int(input('Digite a quantidade intervalo(s) registrado(s): '))

# Inicializa a distância total como zero
distancia_total = 0

# Itera sobre cada intervalo
for _ in range(n):
    # Lê a linha de entrada, separa e converte os valores para inteiros
    T, V = input().split()
    T = int(T)
    V = int(V)
    
    # Calcula a distância percorrida no intervalo
    distancia_total += T * V

# Imprime a distância total percorrida
print(f'Distância total percorrida: {distancia_total}')
