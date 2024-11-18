def exibir_inventario(inventario):
    if not inventario:
        print("O inventário está vazio.")
    else:
        print("Inventário:")
        for produto, preco in inventario.items():
            print(f"- {produto}: R$ {preco:.2f}")


def adicionar_produto(inventario):
    produto = input("Digite o nome do produto: ")
    while True:
        try:
            preco = float(input("Digite o preço do produto: "))
            if preco >= 0:  # Valida se o preço é não negativo
                inventario[produto] = preco
                print(f"{produto} adicionado ao inventário.")
                break
            else:
                print("Preço inválido. Digite um valor não negativo.")
        except ValueError:
            print("Entrada inválida. Digite um número.")


def remover_produto(inventario):
    produto = input("Digite o nome do produto a ser removido: ")
    if produto in inventario:
        del inventario[produto]
        print(f"{produto} removido do inventário.")
    else:
        print(f"{produto} não encontrado no inventário.")


# Cria um dicionário vazio para o inventário
inventario = {}

# Loop principal do programa
while True:
    print("\nAções disponíveis:")
    print("1. Adicionar produto")
    print("2. Remover produto")
    print("3. Exibir inventário")
    print("4. Sair")

    acao = input("Digite o número da ação desejada: ")

    if acao == '1':
        adicionar_produto(inventario)
    elif acao == '2':
        remover_produto(inventario)
    elif acao == '3':
        exibir_inventario(inventario)
    elif acao == '4':
        break
    else:
        print("Ação inválida.")

print("Programa encerrado.")
