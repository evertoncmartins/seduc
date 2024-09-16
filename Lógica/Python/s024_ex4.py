# Iniciar o programa solicitando a quantidade de itens a serem inseridos
quantidade_itens = int(input("Quantos itens deseja inserir no inventário?: "))

# Inicializar uma lista para armazenar os itens do inventário
inventario = []

# Usar um laço para inserir cada item
for i in range(quantidade_itens):
    print(f"\nInserindo o item {i+1}:")
    nome = input("Digite o nome do equipamento: ")
    categoria = input("Digite a categoria do equipamento: ")
    quantidade = int(input("Digite a quantidade do equipamento: "))

    # Criar um dicionário para armazenar os dados de cada equipamento
    item = {
        "Nome": nome,
        "Categoria": categoria,
        "Quantidade": quantidade
    }

    # Adicionar o item à lista de inventário
    inventario.append(item)

# Exibir o inventário completo
print("\nInventário Completo:")
print("{:<20} {:<20} {:<10}".format("Nome", "Categoria", "Quantidade"))
print("-" * 55)

# Usar um laço para mostrar os itens do inventário
for item in inventario:
    print("{:<20} {:<20} {:<10}".format(
        item["Nome"], item["Categoria"], item["Quantidade"]))
