import random
from collections import deque

# Constantes
MAX_TENTATIVAS = 3

# Filas
fila_principal = deque()
dlq = deque()

# Função para tentar entregar a mensagem
def tentar_entregar():
    return random.choice([True, False])  # Simula uma entrega com 50% de falha

# Função para processar mensagens
def processar_mensagens():
    while fila_principal:
        mensagem = fila_principal.popleft()
        if tentar_entregar():
            print(f"Mensagem '{mensagem}' entregue com sucesso.")
        else:
            print(f"Falha ao entregar a mensagem '{mensagem}'.")
            if mensagem[1] < MAX_TENTATIVAS:
                mensagem[1] += 1  # Incrementa o contador de tentativas
                fila_principal.append(mensagem)  # Reenfileira a mensagem
                print(f"Mensagem reenfileirada: '{mensagem[0]}' (Tentativas: {mensagem[1]})")
            else:
                dlq.append(mensagem[0])  # Move para a DLQ
                print(f"Mensagem movida para a DLQ: '{mensagem[0]}'")

# Função para adicionar mensagens à fila principal
def adicionar_mensagem(conteudo):
    fila_principal.append((conteudo, 0))  # (conteúdo, contador de tentativas)

# Simulando o sistema de mensageria
adicionar_mensagem("Mensagem 1")
adicionar_mensagem("Mensagem 2")
adicionar_mensagem("Mensagem 3")

# Processar mensagens
print("Iniciando o processamento de mensagens...")
processar_mensagens()

# Exibir mensagens na DLQ
print("\nMensagens na DLQ:", list(dlq))
