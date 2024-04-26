class Lampada:
    def __init__(self):
        self.estado = False  # Começa desligada


# Uso da classe
lampada = Lampada()

print(lampada.estado)  # Verifica o estado atual da lâmpada

lampada.estado = True   # Liga a lâmpada
print(lampada.estado)  # Verifica o estado atual da lâmpada

lampada.estado = False  # Desliga a lâmpada
print(lampada.estado)  # Verifica o estado atual da lâmpada
