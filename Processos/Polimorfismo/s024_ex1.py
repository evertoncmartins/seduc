from abc import ABC, abstractmethod

# Classe base abstrata Produto


class Produto(ABC):
    def __init__(self, nome, preco):
        self.nome = nome
        self.preco = preco

    @abstractmethod
    def calcular_imposto(self):
        pass

# Subclasse para Livros (Isentos de imposto)


class Livro(Produto):
    def calcular_imposto(self):
        # Livros são isentos de impostos
        return 0

# Subclasse para Eletrônicos (Imposto de 20%)


class Eletronico(Produto):
    def calcular_imposto(self):
        # Eletrônicos têm imposto de 20%
        return self.preco * 0.2

# Subclasse para Alimentos (Imposto de 10%)


class Alimento(Produto):
    def calcular_imposto(self):
        # Alimentos têm imposto de 10%
        return self.preco * 0.1

# Função para demonstrar o polimorfismo


def mostrar_preco_com_imposto(produto):
    imposto = produto.calcular_imposto()
    preco_final = produto.preco + imposto
    print(f"{produto.nome}: Preço sem imposto: R${produto.preco:.2f}, Imposto: R${
          imposto:.2f}, Preço final: R${preco_final:.2f}")


# Criando objetos das subclasses
livro = Livro("O Senhor dos Anéis", 50.00)
eletronico = Eletronico("Notebook", 3000.00)
alimento = Alimento("Maçã", 5.00)

# Demonstrando polimorfismo
mostrar_preco_com_imposto(livro)
mostrar_preco_com_imposto(eletronico)
mostrar_preco_com_imposto(alimento)
