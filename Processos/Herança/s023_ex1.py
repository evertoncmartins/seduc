# ------------------------------------------------------------------------------------
# PASSO 1: A CLASSE MÃE (Superclasse ou Classe Base)
# ------------------------------------------------------------------------------------
class ProdutoEletronico:
    def __init__(self, nome, marca, preco):
        print(f"--- Criando um produto genérico: {nome} ---")
        self.nome = nome
        self.marca = marca
        self.preco = preco

    def exibir_informacoes(self):
        print(
            f"Nome: {self.nome}, Marca: {self.marca}, Preço: R${self.preco:.2f}")

# ------------------------------------------------------------------------------------
# PASSO 2: AS CLASSES FILHAS (Subclasses)
# ------------------------------------------------------------------------------------


class Smartphone(ProdutoEletronico):
    def __init__(self, nome, marca, preco, capacidade_armazenamento):
        print(f"--- Criando um Smartphone específico: {nome} ---")
        super().__init__(nome, marca, preco)

        self.capacidade_armazenamento = capacidade_armazenamento

    # Este método vai SOBRESCREVER (substituir) o método da classe mãe.
    def exibir_informacoes(self):
        print("\nInformações Detalhadas do Smartphone:")
        super().exibir_informacoes()
        print(
            f"Capacidade de Armazenamento: {self.capacidade_armazenamento}GB")


class Laptop(ProdutoEletronico):
    def __init__(self, nome, marca, preco, memoria_ram):
        print(f"--- Criando um Laptop específico: {nome} ---")
        super().__init__(nome, marca, preco)

        self.memoria_ram = memoria_ram

    def exibir_informacoes(self):
        print("\nInformações Detalhadas do Laptop:")
        super().exibir_informacoes()
        print(f"Memória RAM: {self.memoria_ram}GB")


class Televisor(ProdutoEletronico):
    def __init__(self, nome, marca, preco, tamanho_tela):
        print(f"--- Criando um Televisor específico: {nome} ---")
        super().__init__(nome, marca, preco)
        self.tamanho_tela = tamanho_tela

    def exibir_informacoes(self):
        print("\nInformações Detalhadas do Televisor:")
        super().exibir_informacoes()
        print(f"Tamanho da Tela: {self.tamanho_tela} polegadas")


# ------------------------------------------------------------------------------------
# PASSO 3: TESTANDO O CÓDIGO
# ------------------------------------------------------------------------------------
print("==================================================")
print("INICIANDO CADASTRO DE PRODUTOS NA LOJA")
print("==================================================\n")

# Criando um objeto da classe Smartphone.
meu_celular = Smartphone(nome="Galaxy S23", marca="Samsung",
                         preco=3500.00, capacidade_armazenamento=256)

# Criando um objeto da classe Laptop.
meu_notebook = Laptop(nome="Macbook Air", marca="Apple",
                      preco=7500.50, memoria_ram=8)

# Criando um objeto da classe Televisor.
minha_tv = Televisor(nome="Smart TV OLED", marca="LG",
                     preco=4200.75, tamanho_tela=55)

print("\n==================================================")
print("EXIBINDO INFORMAÇÕES DOS PRODUTOS CADASTRADOS")
print("==================================================\n")

# Chamando o método exibir_informacoes() para cada objeto.
# Note que cada um vai executar sua própria versão do método.
meu_celular.exibir_informacoes()
meu_notebook.exibir_informacoes()
minha_tv.exibir_informacoes()
