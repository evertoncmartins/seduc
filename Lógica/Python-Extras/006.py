# Construa um algoritmo que leia uma quantidade indeterminada de números inteiros positivos e identifique qual foi o menor número digitado. O programa deve parar quando o usuário digitar o número -1.

# Inicializando a variável para armazenar o menor número
menor_numero = None

while True:
    # Lê um número do usuário
    numero = int(input("Digite um número inteiro positivo (-1 para sair): "))

    # Verifica se o número é -1 para terminar a entrada
    if numero == -1:
        break

    # Verifica se o número é positivo
    if numero >= 0:
        # Atualiza o menor número
        if menor_numero is None or numero < menor_numero:
            menor_numero = numero
    else:
        print("Por favor, digite apenas números inteiros positivos.")

# Exibe o resultado
if menor_numero is not None:
    print(f"O menor número digitado foi: {menor_numero}")
else:
    print("Nenhum número positivo foi digitado.")
