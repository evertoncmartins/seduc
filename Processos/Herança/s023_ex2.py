#------------------------------------------------------------------------------------
# CLASSE BASE (OU SUPERCLASSE)
#------------------------------------------------------------------------------------
class Pessoa:
    def __init__(self, nome, idade, documento):
        self.nome = nome
        self.idade = idade
        self.documento = documento

    def exibir_informacoes(self):
        print(f"Nome: {self.nome}, Idade: {self.idade}, Documento: {self.documento}")

#------------------------------------------------------------------------------------
# CLASSES FILHAS (OU SUBCLASSES)
#------------------------------------------------------------------------------------
class Aluno(Pessoa):
    def __init__(self, nome, idade, documento, matricula):
        super().__init__(nome, idade, documento)
        self.matricula = matricula
        self.notas = [] 

    def adicionar_nota(self, nota):
        self.notas.append(nota)
        print(f"Nota {nota} adicionada para o aluno {self.nome}.")

    def calcular_media(self):
        if not self.notas:
            return 0
        return sum(self.notas) / len(self.notas)

    def exibir_informacoes(self):
        print("\n--- INFORMAÇÕES DO ALUNO ---")
        super().exibir_informacoes()
        print(f"Matrícula: {self.matricula}")
        print(f"Notas: {self.notas}")
        print(f"Média Final: {self.calcular_media():.2f}")

class Funcionario(Pessoa):
    def __init__(self, nome, idade, documento, cargo, salario):
        super().__init__(nome, idade, documento)
        self.cargo = cargo
        self.salario = salario

    def exibir_informacoes(self):
        print("\n--- INFORMAÇÕES DO FUNCIONÁRIO ---")
        super().exibir_informacoes()
        print(f"Cargo: {self.cargo}")
        print(f"Salário: R${self.salario:.2f}")


#------------------------------------------------------------------------------------
# TESTANDO AS CLASSES
#------------------------------------------------------------------------------------
print("==========================================")
print("  SISTEMA DE GERENCIAMENTO DA ESCOLA")
print("==========================================")

aluno1 = Aluno(nome="Carlos Souza", idade=15, documento="123.456.789-00", matricula="MAT-2025-001")

aluno1.adicionar_nota(8.5)
aluno1.adicionar_nota(9.0)
aluno1.adicionar_nota(7.5)

funcionario1 = Funcionario(nome="Ana Pereira", idade=34, documento="987.654.321-11", cargo="Professora", salario=4500.00)

aluno1.exibir_informacoes()
funcionario1.exibir_informacoes()