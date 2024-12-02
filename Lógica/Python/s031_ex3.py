# 1. Use um loop while para solicitar números ao usuário até que ele digite um número negativo
while True:
    numero = int(input("Digite um número (negativo para encerrar): "))
    if numero < 0:
        print("Programa encerrado.")
        break  # Sai do loop principal se o número for negativo

    # 2. Utilize o comando continue para pular a verificação se o número for menor que 2
    if numero < 2:
        print("Números menores que 2 não são primos.")
        continue

    # 3. Verifique se o número é primo
    primo = True
    for i in range(2, int(numero ** 0.5) + 1):  # Checa divisores de 2 até a raiz quadrada do número
        if numero % i == 0:
            # 4. Utilize o comando break para sair do loop de verificação se o número não for primo
            primo = False
            break

    # 5. Exiba o resultado e solicite o próximo número
    if primo:
        print(f"{numero} é primo.")
    else:
        print(f"{numero} não é primo.")
