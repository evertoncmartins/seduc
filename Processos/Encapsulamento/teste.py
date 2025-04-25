class Pessoa:
    def __init__(self, nome, idade):
        self.__nome = nome #atributo privado
        self.__idade = idade #atributo privado

    def get_nome(self):
        return self.__nome
    
    def get_idade(self):
        return self.__idade
    
pessoa = Pessoa("Ana", 28)

print(pessoa.get_nome())
print(pessoa.get_idade())
    


    