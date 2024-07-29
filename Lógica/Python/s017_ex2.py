# Calcule o consumo médio de um automóvel com base nas informações fornecidas: a distância total percorrida (em Km) e o total de combustível gasto (em litros).

# Entrada
# O arquivo de entrada contém dois valores: um valor inteiro X, representando a distância total percorrida (em Km), e um valor real Y, representando o total de combustível gasto, com um dígito após o ponto decimal.

# Saída
# Apresente o valor que representa o consumo médio do automóvel com 3 casas após a vírgula, seguido da mensagem "km/l".

def verificar_consumo(distancia, litros_combustivel):
    consumo = distancia / litros_combustivel

    return consumo


distancia = int(input('Digite a distância (km) percorrida: '))
litros_combustivel = float(
    input('Digite o total em litros de combústivel gasto: '))

consumo = verificar_consumo(distancia, litros_combustivel)

print(f'Consumo: {consumo:.3f} litros por km percorrido')
