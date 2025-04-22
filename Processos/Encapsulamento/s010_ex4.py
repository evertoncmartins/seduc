# Classe que representa uma pessoa com nome e idade privados
class Pessoa:
    def __init__(self, nome, idade):
        self.__nome = nome     # Atributo privado
        self.__idade = idade   # Atributo privado

    def get_nome(self):
        # Retorna o nome da pessoa
        return self.__nome

    def get_idade(self):
        # Retorna a idade da pessoa
        return self.__idade


# Criando um objeto da classe Pessoa
pessoa = Pessoa("Ana", 30)

# Acessando os dados de forma segura (encapsulada)
print(pessoa.get_nome())   # Saída esperada: Ana
print(pessoa.get_idade())  # Saída esperada: 30
