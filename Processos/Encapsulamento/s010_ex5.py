# Classe que representa uma conta bancária
class ContaBancaria:
    def __init__(self, saldo_inicial):
        self._saldo = saldo_inicial  # Atributo protegido

    def depositar(self, valor):
        # Adiciona o valor ao saldo
        if valor > 0:
            self._saldo += valor
        else:
            print("O valor do depósito deve ser positivo.")

    def get_saldo(self):
        # Retorna o saldo atual
        return self._saldo


# Criando uma conta com saldo inicial
conta = ContaBancaria(1000)

# Depositando dinheiro
conta.depositar(500)

# Verificando o saldo
print(conta.get_saldo())  # Saída esperada: 1500
