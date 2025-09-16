class Carro:
    def __init__(self, marca, modelo, ano, cor, preco):
        self.__marca = marca
        self.__modelo = modelo
        self.__ano = ano
        self.__cor = cor
        self.__preco = preco

    # Getter e Setter para marca
    def get_marca(self):
        return self.__marca

    def set_marca(self, nova_marca):
        self.__marca = nova_marca

    # Getter e Setter para modelo
    def get_modelo(self):
        return self.__modelo

    def set_modelo(self, novo_modelo):
        self.__modelo = novo_modelo

    # Getter e Setter para ano
    def get_ano(self):
        return self.__ano

    def set_ano(self, novo_ano):
        self.__ano = novo_ano

    # Getter e Setter para cor
    def get_cor(self):
        return self.__cor

    def set_cor(self, nova_cor):
        self.__cor = nova_cor

    # Getter e Setter para preco
    def get_preco(self):
        return self.__preco

    def set_preco(self, novo_preco):
        self.__preco = novo_preco


# Criando uma instância da classe Carro
meu_carro = Carro('Toyota', 'Corolla', 2025, 'Prata', 10000)

# Exibindo os valores iniciais dos atributos
print('Marca:', meu_carro.get_marca())
print('Modelo:', meu_carro.get_modelo())
print('Ano:', meu_carro.get_ano())
print('Cor:', meu_carro.get_cor())
print('Preço:', meu_carro.get_preco())

# Modificando os valores dos atributos
meu_carro.set_marca('Honda')
meu_carro.set_modelo('Civic')
meu_carro.set_ano(2024)
meu_carro.set_cor('Preto')
meu_carro.set_preco(90000)

# Exibindo os novos valores dos atributos
print('\nApós alteração:')
print('Marca:', meu_carro.get_marca())
print('Modelo:', meu_carro.get_modelo())
print('Ano:', meu_carro.get_ano())
print('Cor:', meu_carro.get_cor())
print('Preço:', meu_carro.get_preco())
