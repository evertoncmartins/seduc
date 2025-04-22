# Classe que representa um sensor de temperatura
class SensorTemperatura:
    def __init__(self, temperatura=0):
        self.__temperatura = temperatura  # Atributo privado

    def set_temperatura(self, nova_temperatura):
        # Validação de intervalo aceitável
        if -50 <= nova_temperatura <= 150:
            self.__temperatura = nova_temperatura
        else:
            print("Temperatura fora do intervalo permitido.")

    def get_temperatura(self):
        # Retorna a temperatura atual
        return self.__temperatura


# Criando o sensor
sensor = SensorTemperatura()

# Definindo a temperatura
sensor.set_temperatura(25)

# Obtendo a temperatura
print(sensor.get_temperatura())  # Saída esperada: 25
