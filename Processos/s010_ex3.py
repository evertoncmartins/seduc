class Termometro:
    def __init__(self, temperatura_celsius):
        self.__temperatura_celsius = temperatura_celsius

    def set_temperatura_celsius(self, temperatura_celsius):
        self.__temperatura_celsius = temperatura_celsius

    def get_temperatura_fahrenheit(self):
        return (self.__temperatura_celsius * 9/5) + 32


# Uso da classe
termometro = Termometro(20)  # Defina a temperatura inicial em Celsius
print(termometro.get_temperatura_fahrenheit())
