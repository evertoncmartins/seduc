class Perfil(object):

    def __init__(self, nome, telefone):
        self.nome = nome
        self.telefone = telefone
        self.__curtidas = 0  # atributo privado (não pode ser acessado diretamente)

    def imprimir(self):
        print(f"Nome : {self.nome}, Telefone: {self.telefone}")

    def curtir(self):
        # Só esse método pode alterar o valor de __curtidas
        self.__curtidas += 1

    def obter_curtidas(self):
        # Método para acessar o valor atual de curtidas
        return self.__curtidas

perfil = Perfil('Flávio Almeida', 'não informado')

# Damos duas curtidas usando o método correto
perfil.curtir()
perfil.curtir()

# Agora obtemos o número de curtidas com o método
print(perfil.obter_curtidas())  # Saída: 2

# Se tentarmos acessar diretamente o atributo __curtidas:
# print(perfil.__curtidas)  → Isso vai dar erro!