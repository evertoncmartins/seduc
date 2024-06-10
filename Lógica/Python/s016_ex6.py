def qtde_litro(tempo, velo):
    distancia = velo * tempo
    consumo = distancia / 12
    return f'Consumo: {consumo :.3f} litros'


tempo = int(input('Digite o tempo gasto na viagem (em horas): '))
velo = int(input('Digite a velocidade média durante a viagem (em km/h): '))

print(qtde_litro(tempo, velo))