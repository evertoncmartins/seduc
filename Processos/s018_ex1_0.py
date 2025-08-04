class Perfil(object):

    def __init__(self, nome, telefone, empresa):
        # Atributos públicos (acessíveis diretamente)
        self.nome = nome
        self.telefone = telefone
        self.empresa = empresa
        self.curtidas = 0  # qualquer um pode alterar esse valor diretamente

    def imprimir(self):
        # Imprime as informações do perfil
        print("Nome : %s, Telefone: %s, Empresa: %s" % (self.nome, self.telefone, self.empresa))

# Criamos um perfil normalmente
perfil = Perfil('Flávio Almeida', 'não informado', 'Caelum')

# Valor inicial das curtidas é zero
print(perfil.curtidas)  # Saída: 0

# Podemos adicionar curtidas diretamente
perfil.curtidas += 1
print(perfil.curtidas)  # Saída: 1

# MAS TAMBÉM podemos quebrar a regra e fazer:
perfil.curtidas = 1000
print(perfil.curtidas)  # Saída: 1000 (quebra a regra do exercício!)
