# Classe que representa um contador com valor privado
class Contador:
    def __init__(self):
        self.__valor = 0  # Atributo privado, não acessível diretamente

    def incrementar(self):
        self.__valor += 1  # Adiciona 1 ao valor

    def decrementar(self):
        self.__valor -= 1  # Subtrai 1 do valor

    def get_valor(self):
        return self.__valor  # Retorna o valor atual

# Criando um contador
contador = Contador()

contador.incrementar()
contador.incrementar()
print(contador.get_valor())  # Deve mostrar 2

contador.decrementar()
print(contador.get_valor())  # Deve mostrar 1
