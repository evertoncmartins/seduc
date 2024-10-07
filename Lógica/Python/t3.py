from datetime import datetime

# Definição da classe Evento
class Evento:
    def __init__(self, tipo, montante, usuario):
        self.tipo = tipo
        self.montante = montante
        self.data_hora = datetime.now()
        self.usuario = usuario

# Definição da classe ContaBancaria
class ContaBancaria:
    def __init__(self):
        self.saldo = 0
        self.historico_eventos = []

    def registrar_evento(self, tipo, montante, usuario):
        evento = Evento(tipo, montante, usuario)
        self.historico_eventos.append(evento)
        self.aplicar_evento(evento)

    def aplicar_evento(self, evento):
        if evento.tipo == "deposito":
            self.saldo += evento.montante
        elif evento.tipo == "retirada":
            if self.saldo >= evento.montante:
                self.saldo -= evento.montante
            else:
                print("Saldo insuficiente para a retirada.")

    def reconstruir_saldo(self):
        self.saldo = 0
        for evento in self.historico_eventos:
            self.aplicar_evento(evento)

    def obter_historico(self):
        return [(evento.data_hora, evento.tipo, evento.montante, evento.usuario) for evento in self.historico_eventos]

# Exemplo de uso
conta = ContaBancaria()

# Registrando alguns eventos
conta.registrar_evento("deposito", 100, "usuario1")
conta.registrar_evento("retirada", 30, "usuario2")
conta.registrar_evento("retirada", 50, "usuario1")
conta.registrar_evento("retirada", 30, "usuario3")  # Tentativa de retirada com saldo insuficiente

# Exibindo o saldo atual
print("Saldo atual:", conta.saldo)

# Exibindo o histórico de eventos
historico = conta.obter_historico()
print("Histórico de Eventos:")
for evento in historico:
    print(f"{evento[0]} - {evento[1]}: {evento[2]} (Usuário: {evento[3]})")

# Reconstruindo o saldo
conta.reconstruir_saldo()
print("Saldo reconstruído:", conta.saldo)
