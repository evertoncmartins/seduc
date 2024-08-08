class Livro:
    def __init__(self, titulo, autor, ano_publicacao, preco):
        self.__titulo = titulo
        self.__autor = autor
        self.__ano_publicacao = ano_publicacao
        self.__preco = preco

    # Getter para titulo
    def get_titulo(self):
        return self.__titulo

    # Setter para titulo
    def set_titulo(self, novo_titulo):
        self.__titulo = novo_titulo

    def get_autor(self):
        return self.__autor

    def set_autor(self, novo_autor):
        self.__autor = novo_autor

    def get_ano_publicacao(self):
        return self.__ano_publicacao

    def set_ano_publicacao(self, novo_ano_publicacao):
        self.__ano_publicacao = novo_ano_publicacao

    def get_preco(self):
        return self.__preco

    def set_preco(self, novo_preco):
        self.__preco = novo_preco


# Implementando a Classe
livro = Livro('Harry Potter', 'Desconhecido', '2025', 45)

print(livro.get_titulo())

livro.set_titulo('Sombras da noite')

print(livro.get_titulo())
