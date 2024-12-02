# 1. Inicialize variáveis para armazenar a soma dos números e a contagem de entradas
soma = 0
contagem = 0

# 2. Use um loop while para solicitar números ao usuário até que ele digite 0
while True:
    numero = int(input("Digite um número (ou 0 para encerrar): "))
    if numero == 0:
        break  # Sai do loop se o usuário digitar 0
    # 3. Adicione o número digitado à soma e incremente a contagem
    soma += numero
    contagem += 1

# 4. Após o loop, calcule a média dos números digitados
if contagem > 0:  # Certifique-se de evitar divisão por zero
    media = soma / contagem
    # 5. Exiba a média
    print(f"A média dos números digitados é: {media:.2f}")
else:
    print("Nenhum número foi digitado.")
