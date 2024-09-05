class CalculadoraTarifas:
    @staticmethod
    def calcular_tarifa_base():
        return 5  # Exemplo: tarifa base de R$ 5 para todas as contas

    @staticmethod
    def calcular_tarifa_transacao(numero_transacoes):
        if numero_transacoes > 10:
            return (numero_transacoes - 10) * 1.5  # Exemplo: R$ 1,50 por transação adicional
        else:
            return 0

    @staticmethod
    def calcular_tarifa_saldo(saldo):
        if saldo < 1000:
            return 10  # Exemplo: tarifa de R$ 10 para saldos abaixo de R$ 1000
        else:
            return 0


class ContaBancaria:
    def __init__(self, numero_conta, saldo=0, numero_transacoes=0):
        self.numero_conta = numero_conta
        self.saldo = saldo
        self.numero_transacoes = numero_transacoes

    def depositar(self, valor):
        self.saldo += valor
        self.numero_transacoes += 1

    def sacar(self, valor):
        self.saldo -= valor
        self.numero_transacoes += 1

    def calcular_tarifa(self):
        tarifa_base = CalculadoraTarifas.calcular_tarifa_base()
        tarifa_transacao = CalculadoraTarifas.calcular_tarifa_transacao(self.numero_transacoes)
        tarifa_saldo = CalculadoraTarifas.calcular_tarifa_saldo(self.saldo)
        return tarifa_base + tarifa_transacao + tarifa_saldo


class ContaCorrente(ContaBancaria):
    def __init__(self, numero_conta, saldo=0, numero_transacoes=0):
        super().__init__(numero_conta, saldo, numero_transacoes)


class ContaPoupanca(ContaBancaria):
    def __init__(self, numero_conta, saldo=0, numero_transacoes=0):
        super().__init__(numero_conta, saldo, numero_transacoes)


# Conta Universitária com custo gratuito
class ContaUniversitaria(ContaBancaria):
    def __init__(self, numero_conta, saldo=0, numero_transacoes=0):
        super().__init__(numero_conta, saldo, numero_transacoes)

    # Sobrescrevendo o método de cálculo de tarifa para ser sempre zero
    def calcular_tarifa(self):
        return 0  # Tarifa gratuita para contas universitárias


# Exemplo de uso
conta_corrente = ContaCorrente("12345")
conta_corrente.depositar(1000)
conta_corrente.sacar(200)
print("Tarifa da conta corrente:", conta_corrente.calcular_tarifa())

conta_poupanca = ContaPoupanca("54321")
conta_poupanca.depositar(500)
conta_poupanca.sacar(100)
print("Tarifa da conta poupança:", conta_poupanca.calcular_tarifa())

conta_universitaria = ContaUniversitaria("98765")
conta_universitaria.depositar(100)
conta_universitaria.sacar(50)
print("Tarifa da conta universitária:", conta_universitaria.calcular_tarifa())