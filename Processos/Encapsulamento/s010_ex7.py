# Classe que representa um livro
class Livro:
    def __init__(self, titulo, autor, ano):
        self.titulo = titulo
        self.autor = autor
        self.ano = ano

# Classe que representa a biblioteca


class Biblioteca:
    def __init__(self):
        self.livros = []  # Lista para armazenar os livros

    def adicionar_livro(self, livro):
        self.livros.append(livro)  # Adiciona um novo livro à lista

    def listar_livros(self):
        # Mostra os livros cadastrados
        if self.livros:
            for livro in self.livros:
                print(f"{livro.titulo}, {livro.autor}, {livro.ano}")
        else:
            print("Nenhum livro cadastrado.")


# Criando a biblioteca e adicionando um livro
biblioteca = Biblioteca()
biblioteca.adicionar_livro(Livro("1984", "George Orwell", 1949))

# Listando os livros
biblioteca.listar_livros()
