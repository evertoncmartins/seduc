# Classe que representa um usuário com nome e senha privados
class Usuario:
    def __init__(self, nome, senha):
        self.__nome = nome
        self.__senha = senha

    def alterar_senha(self, nova_senha):
        # Verifica se a nova senha tem pelo menos 8 caracteres
        if len(nova_senha) >= 8:
            self.__senha = nova_senha
            print("Senha alterada com sucesso.")
        else:
            print("Senha muito curta. Use pelo menos 8 caracteres.")


# Criando um usuário
usuario = Usuario("joao123", "senha123")

# Tentando alterar a senha
usuario.alterar_senha("novaSenha123")  # Saída esperada: sucesso
