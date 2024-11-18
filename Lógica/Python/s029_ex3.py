def exibir_lista(lista_compras):
    if not lista_compras:
        print("A lista de compras está vazia.")
    else:
        print("Lista de Compras:")
        for i, item in enumerate(lista_compras):
            print(f"{i + 1}. {item}")


def adicionar_item(lista_compras):
    item = input("Digite o item a ser adicionado: ")
    lista_compras.append(item)
    print(f"'{item}' adicionado à lista.")


def remover_item(lista_compras):
    exibir_lista(lista_compras)
    if lista_compras:
        while True:
            try:
                indice = int(input("Digite o número do item a ser removido: "))
                if 1 <= indice <= len(lista_compras):
                    item_removido = lista_compras.pop(indice - 1)
                    print(f"'{item_removido}' removido da lista.")
                    break
                else:
                    print("Índice inválido.")

            except ValueError:
                print("Entrada inválida. Digite um número.")


# Cria uma lista de compras vazia
lista_compras = []

# Loop principal do programa
while True:
    print("\nAções disponíveis:")
    print("1. Adicionar item")
    print("2. Remover item")
    print("3. Exibir lista")
    print("4. Sair")

    acao = input("Digite o número da ação desejada: ")

    if acao == '1':
        adicionar_item(lista_compras)
    elif acao == '2':
        remover_item(lista_compras)
    elif acao == '3':
        exibir_lista(lista_compras)
    elif acao == '4':
        break
    else:
        print("Ação inválida.")

print("Programa encerrado.")
