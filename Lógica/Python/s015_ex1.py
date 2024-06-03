# Importa a função 'math' para realizar operações matemáticas específicas
import math

# Função para processar os casos de teste


def process_figurinhas(casos_teste):
    # Criando uma lista de resultados
    lista_resultados = []
    for F1, F2 in casos_teste:
        # Calcular o MDC (GCD em inglês)
        mdc = math.gcd(F1, F2)
        # Adiciona cada MDC na lista_resultados
        lista_resultados.append(mdc)

    return lista_resultados


# Exemplos de casos de teste simulados
casos_teste = [
    (8, 12),
    (15, 25),
    (21, 14),
    (18, 24),
    (30, 45),
    (17, 19),
    (100, 80),
    (123, 321),
    (60, 90),
    (77, 35)
]

# Executar a função e imprimir os resultados
lista_resultados = process_figurinhas(casos_teste)
for resultado in lista_resultados:
    print(resultado)
