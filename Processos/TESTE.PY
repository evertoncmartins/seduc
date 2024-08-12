class Livro:
    def __init__(self, titulo, autor, anoPublicacao, preco):
        self.__titulo = titulo
        self.__autor = autor
        self.__anoPublicacao = anoPublicacao
        self.__preco = preco

    # Get para título
    def getTitulo(self):
        return self.__titulo

    # Set para titulo
    def setTitulo(self, novoTitulo):
        self.__titulo = novoTitulo

    # Get para autor
    def getAutor(self):
        return self.__autor

    # Set para autor
    def setAutor(self, novoAutor):
        self.__autor = novoAutor

    # Get para anoPublicacao
    def getAnoPublicacao(self):
        return self.__anoPublicacao

    # Set para anoPublicacao
    def setAnoPublicacao(self, novoAnoPublicacao):
        self.__anoPublicacao = novoAnoPublicacao

    # Get para preco
    def getPreco(self):
        return self.__preco

    # Set para preco
    def setPreco(self, novoPreco):
        self.__preco = novoPreco


# Instanciar a classe
livro = Livro('Harry Potter', 'J. K.', 2025, 120.90)

# Imprimir
print(livro.getTitulo())
print(livro.getAutor())
print(livro.getAnoPublicacao())
print(livro.getPreco())

livro.setTitulo('Sombras de Mordor')

print(livro.getTitulo())