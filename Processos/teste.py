class Perfil(object):
    
    def __init__(self nome, apelido):
        self.nome = nome
        self.apelido = apelido
        self.__curtidas = 0 # atributo privado

    def imprimir(self):
        print(f"Nome: {self.nome} - Apelido: {self.apelido}")

    def curtir(self):
        self.__curtidas += 1

    def obtercurtidas(self):
        return self.__curtidas
    
# Instância da Classe (objeto) - posso criar infinitos objetos
perfil = Perfil("João", "jaum")

perfil.curtir()
perfil.curtir() 

print(perfil.obtercurtidas())

