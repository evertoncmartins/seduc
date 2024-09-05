class ContaBancaria:
    def __init__(self, numero_conta, saldo=0):
        self.numero_conta = numero_conta
        self.saldo = saldo
        self.transacoes = []

    def depositar(self, valor):
        self.saldo += valor
        self.registrar_transacao("Depósito", valor)

    def sacar(self, valor):
        if self.saldo >= valor:
            self.saldo -= valor
            self.registrar_transacao("Saque", valor)
        else:
            print("Saldo insuficiente.")

    def consultar_saldo(self):
        print("Saldo:", self.saldo)

    def registrar_transacao(self, tipo, valor):
        self.transacoes.append({"Tipo": tipo, "Valor": valor})


class ContaCorrente(ContaBancaria):
    def __init__(self, numero_conta, limite_cheque_especial=0):
        super().__init__(numero_conta)
        self.limite_cheque_especial = limite_cheque_especial

    def emitir_cheque(self, valor):
        if self.saldo + self.limite_cheque_especial >= valor:
            self.saldo -= valor
            self.registrar_transacao("Emissão de Cheque", valor)
        else:
            print("Limite de cheque especial excedido.")


class ContaPoupanca(ContaBancaria):
    def calcular_juros_mensal(self, taxa_juros):
        juros = self.saldo * (taxa_juros / 100)
        self.saldo += juros
        self.registrar_transacao("Juros Mensais", juros)


class ContaInvestimento(ContaBancaria):
    def __init__(self, numero_conta, saldo=0):
        super().__init__(numero_conta, saldo)
        self.investimentos = []

    def realizar_investimento(self, produto, valor):
        if self.saldo >= valor:
            self.saldo -= valor  # Subtrair o valor do saldo ao realizar o investimento
            self.investimentos.append({"Produto": produto, "Valor": valor})
            self.registrar_transacao("Investimento", valor)
        else:
            print("Saldo insuficiente para o investimento.")


# Implementando Conta Corrente
print('\n---Conta Corrente---\n')
corrente = ContaCorrente(123, 3000)
corrente.emitir_cheque(100)
corrente.consultar_saldo()

# Implementando Conta Poupança
print('\n---Conta Poupança---\n')
poupanca = ContaPoupanca(123, 1000)
poupanca.calcular_juros_mensal(10)
poupanca.consultar_saldo()

# Implementando Conta de Investimento
print('\n---Conta de Investimentos---\n')
investimento = ContaInvestimento(123, 5000)
investimento.realizar_investimento('CDB', 300)
investimento.consultar_saldo()
