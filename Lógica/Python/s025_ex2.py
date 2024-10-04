# Matriz inicial de assentos (5 fileiras, 8 assentos por fileira)
assentos = [[0 for _ in range(8)] for _ in range(5)]

# Função para exibir o mapa atual dos assentos
def exibir_assentos(assentos):
    print("Mapa atual dos assentos (0 = disponível, 1 = reservado):")
    for i, fileira in enumerate(assentos):
        print(f"Fileira {i+1}: {fileira}")
    print()

# Função para reservar um assento
def reservar_assento(assentos, fileira, assento):
    if assentos[fileira][assento] == 0:
        assentos[fileira][assento] = 1
        print(f"Assento {assento+1} da fileira {fileira+1} reservado com sucesso!")
    else:
        print(f"O assento {assento+1} da fileira {fileira+1} já está reservado.")
    exibir_assentos(assentos)

# Função para cancelar a reserva de um assento
def cancelar_reserva(assentos, fileira, assento):
    if assentos[fileira][assento] == 1:
        assentos[fileira][assento] = 0
        print(f"Reserva do assento {assento+1} da fileira {fileira+1} cancelada com sucesso!")
    else:
        print(f"O assento {assento+1} da fileira {fileira+1} não está reservado.")
    exibir_assentos(assentos)

# Exemplo de uso
exibir_assentos(assentos)  # Exibe o mapa inicial dos assentos

# Reservar o assento 3 da fileira 2
reservar_assento(assentos, 1, 2)

# Cancelar a reserva do assento 3 da fileira 2
cancelar_reserva(assentos, 1, 2)
