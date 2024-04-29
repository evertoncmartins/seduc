# Informações dos candidatos: [nome, partido, vice, cargos ocupados, idade]
candidatos = [
    ["João Silva", "Partido A", "Maria Santos", "Vereador", 45],
    ["Maria Santos", "Partido B", "João Silva", "Deputado Estadual", 38],
    ["Carlos Oliveira", "Partido C", "Fernanda Lima", "Prefeito", 52],
    ["Fernanda Lima", "Partido D", "Carlos Oliveira", "Vice-Prefeita", 42],
    ["Pedro Sousa", "Partido E", "Ana Oliveira", "Vereador", 40],
    ["Ana Oliveira", "Partido F", "Pedro Sousa", "Deputado Federal", 48],
    ["Luiza Costa", "Partido G", "José Silva", "Prefeita", 50],
    ["José Silva", "Partido H", "Luiza Costa", "Vice-Prefeito", 47],
    ["Mariana Santos", "Partido I", "Lucas Oliveira", "Vereadora", 35],
    ["Lucas Oliveira", "Partido J", "Mariana Santos", "Deputado Estadual", 39]
]

# Consulta o número do candidato
numero_candidato = int(input("Digite o número do candidato que deseja consultar: "))

# Verifica se o número do candidato é válido
if 1 <= numero_candidato <= len(candidatos):
    # Obtém as informações do candidato
    candidatos = candidatos[numero_candidato - 1]
    print("\nInformações do candidato:")
    print("Nome:", candidatos[0])
    print("Partido:", candidatos[1])
    print("Vice:", candidatos[2])
    print("Cargos já ocupados:", candidatos[3])
    print("Idade:", candidatos[4])
else:
    print("Número de candidato inválido.")
