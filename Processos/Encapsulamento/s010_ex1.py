# Classe que representa uma Lâmpada
class Lampada:
    def __init__(self):
        # A lâmpada começa desligada (False)
        self.estado = False

    def alterar_estado(self):
        # Inverte o estado atual (liga se estiver desligada e vice-versa)
        self.estado = not self.estado
        # Retorna o estado atual em formato de texto
        return "Ligada" if self.estado else "Desligada"

# Criando um objeto da classe Lâmpada
lampada = Lampada()

# Testando a mudança de estado
print(lampada.alterar_estado())  # Saída esperada: Ligada
print(lampada.alterar_estado())  # Saída esperada: Desligada
