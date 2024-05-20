def aplicar_desconto_estudante(valor):
    return valor * 0.9


def aplicar_desconto_membro(valor):
    return valor * 0.85


def aplicar_desconto_vip(valor):
    return valor * 0.8


def aplicar_desconto_padrao(valor):
    return valor


def calcular_desconto(tipo_cliente, valor):
    descontos = {
        "estudante": valor * 0.9,
        "membro": valor * 0.85,
        "vip": valor * 0.8
    }
    return descontos.get(tipo_cliente, aplicar_desconto_padrao)


valor_descontado = calcular_desconto("membro", 100)
print(valor_descontado)
