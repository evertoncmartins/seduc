# Solicita a quantidade de peças e o preço unitário ao usuário
quantidade = int(input("Digite a quantidade de peças: "))
preco = float(input("Digite o preço unitário: "))

# Valida as entradas
if quantidade <= 0 or preco <= 0:
    print("Quantidade de peças ou preço unitário inválido.")
else:
    # Calcula o preço total sem desconto
    preco_total_sem_desconto = quantidade * preco

    # Calcula o desconto com base na quantidade de peças
    if quantidade <= 5:
        desconto = 0
    elif quantidade <= 10:
        desconto = 0.10  # 10% de desconto
    else:
        desconto = 0.20  # 20% de desconto

    # Calcula o valor do desconto e o preço final
    valor_desconto = preco_total_sem_desconto * desconto
    preco_final = preco_total_sem_desconto - valor_desconto

    # Exibe os resultados
    print(f"Preço total sem desconto: R$ {preco_total_sem_desconto:.2f}")
    print(f"Desconto aplicado: R$ {valor_desconto:.2f}")
    print(f"Preço final com desconto: R$ {preco_final:.2f}")
