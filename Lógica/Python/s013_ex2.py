def calcular_preco(cafe):
    precos = {
        "espresso": 1.50,
        "latte": 2.00,
        "cappuccino": 2.25
    }
    return precos.get(cafe, "Café não disponível")


preco = calcular_preco("espresso")
print(preco)
