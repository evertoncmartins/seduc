# Classe que armazena temperatura em Celsius, mas permite também trabalhar com Fahrenheit
class Termometro:
    def __init__(self, temperatura=0):
        self.__temperatura_celsius = temperatura  # Atributo privado

    def set_temperatura_fahrenheit(self, temperatura_f):
        # Converte Fahrenheit para Celsius
        self.__temperatura_celsius = (temperatura_f - 32) * 5 / 9

    def get_temperatura_fahrenheit(self):
        # Converte Celsius para Fahrenheit
        return (self.__temperatura_celsius * 9 / 5) + 32

    def get_temperatura_celsius(self):
        # Retorna a temperatura em Celsius
        return self.__temperatura_celsius


# Criando um termômetro
termometro = Termometro()

# Definindo a temperatura em Fahrenheit
termometro.set_temperatura_fahrenheit(68)

# Exibindo em Fahrenheit e Celsius
print(termometro.get_temperatura_fahrenheit())  # Saída esperada: 68
print(termometro.get_temperatura_celsius())     # Saída esperada: 20
