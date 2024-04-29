tabela_periodica = {
    "Au": {"numero_atomico": 79, "nome": "Ouro", "massa": 196.9665},
    "Ag": {"numero_atomico": 47, "nome": "Prata", "massa": 107.8682},
    "Cu": {"numero_atomico": 29, "nome": "Bronze", "massa": 63.546}
}

# Solicita ao usuário a sigla do elemento químico
sigla = input("Digite a sigla do elemento químico: ")

# Verifica se a sigla está na tabela periódica
if sigla in tabela_periodica:
    elemento = tabela_periodica[sigla]
    print("Número Atômico:", elemento["numero_atomico"])
    print("Nome do Elemento:", elemento["nome"])
    print("Massa Atômica:", elemento["massa"])
else:
    print("Elemento não encontrado na tabela periódica.")
