class Perfil(object):
    'Classe padrão para perfis de usuários'

    def __init__(self, nome, telefone, empresa):
        self.nome = nome
        self.telefone = telefone
        self.empresa = empresa
        self.__curtidas = 0

    def imprimir(self):
        print(f'Nome: {self.nome}, Telefone: {
              self.telefone}, Empresa: {self.empresa}')

    def curtir(self):
        self.__curtidas += 1

    def obter_curtidas(self):
        return self.__curtidas


perfil = Perfil('Flávio Almeida', 'não informado', 'Caelum')

# Incrementa 1 no curtidas
perfil.curtir()
perfil.curtir()

# Exibe o número de curtidas
print(perfil.obter_curtidas())
