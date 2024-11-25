# Solicita os pedidos ao usuário
total_pedido = 0

while True:
    tipo_prato = input(
        "Digite o tipo de prato (entrada, principal, sobremesa ou 'fim' para encerrar): ").lower()

    if tipo_prato == 'fim':
        break
    elif tipo_prato not in ("entrada", "principal", "sobremesa"):
        print(
            "Tipo de prato inválido. Digite 'entrada', 'principal', 'sobremesa' ou 'fim'.")
        continue  # Volta para o início do loop

    quantidade = int(input(f"Digite a quantidade de {tipo_prato}: "))

    # Define os preços e calcula o valor do item
    if tipo_prato == "entrada":
        preco = 20
    elif tipo_prato == "principal":
        preco = 50
    else:  # sobremesa
        preco = 15

    total_pedido += quantidade * preco


# Aplica o desconto se necessário
if total_pedido > 100:
    desconto = total_pedido * 0.1
    total_com_desconto = total_pedido - desconto
    print(f"Total do pedido: R$ {total_pedido:.2f}")
    print(f"Desconto aplicado: R$ {desconto:.2f}")
    print(f"Total com desconto: R$ {total_com_desconto:.2f}")
else:
    print(f"Total do pedido: R$ {total_pedido:.2f}")
