class Livro:
    def __init__(self, titulo, autor, ano_publicacao, preco):
        self.__titulo = titulo
        self.__autor = autor
        self.__ano_publicacao = ano_publicacao
        self.__preco = preco

    # Getter para titulo
    def getTitulo(self):
        return self.__titulo

    # Setter para titulo
    def setTitulo(self, novoTitulo):
        self.__titulo = novoTitulo

    def getAutor(self):
        return self.__autor

    def setAutor(self, novoAutor):
        self.__autor = novoAutor

    def getAnoPublicacao(self):
        return self.__anoPublicacao

    def setAnoPublicacao(self, novoAnoPublicacao):
        self.__anoPublicacao = novoAnoPublicacao

    def getPreco(self):
        return self.__preco

    def setPreco(self, novoPreco):
        self.__preco = novoPreco


# Implementando a Classe
livro = Livro('Harry Potter', 'Desconhecido', '2025', 45)

print(livro.getTitulo())

livro.setTitulo('Sombras da noite')

print(livro.getTitulo())
