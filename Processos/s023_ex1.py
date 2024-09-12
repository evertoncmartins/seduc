class Pessoa:
    def __init__(self, nome, idade, cpf):
        self.nome = nome
        self.idade = idade
        self.cpf = cpf

class Aluno(Pessoa):
    def __init__(self, nome, idade, cpf, matricula, curso):
        super().__init__(nome, idade, cpf)
        self.matricula = matricula
        self.curso = curso

class Funcionario(Pessoa):
    def __init__(self, nome, idade, cpf, cargo, salario):
        super().__init__(nome, idade, cpf)
        self.cargo = cargo
        self.salario = salario

class GerenciadorEscola:
    def __init__(self):
        self.alunos = []
        self.funcionarios = []

    def adicionar_aluno(self, aluno):
        self.alunos.append(aluno)

    def adicionar_funcionario(self, funcionario):
        self.funcionarios.append(funcionario)

    def listar_alunos(self):
        return [f"{aluno.nome}, {aluno.cpf}" for aluno in self.alunos]

    def listar_funcionarios(self):
        return [f"{funcionario.nome}, {funcionario.cpf}" for funcionario in self.funcionarios]

# Exemplo de uso
escola = GerenciadorEscola()
escola.adicionar_aluno(Aluno("João", 20, "123", "A001", "Engenharia"))
escola.adicionar_funcionario(Funcionario("Carlos", 35, "456", "Professor", 3500))

print("Alunos:", escola.listar_alunos())
print("Funcionários:", escola.listar_funcionarios())
