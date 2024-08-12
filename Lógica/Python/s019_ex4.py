# Leitura do valor de N
N = int(input('Digite um número para a sequência: ').strip())

# Inicializa uma string para armazenar a sequência
sequencia = ""

# Gerar a sequência
for i in range(1, N):
    for _ in range(i):
        sequencia += f"{i} "

# Imprimir a sequência removendo o espaço extra final
print(sequencia.strip())
