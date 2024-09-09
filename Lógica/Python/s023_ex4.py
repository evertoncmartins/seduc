def gerenciar_recursos(nivel_experiencia, tipo_apresentacao):
    nivel_experiencia = nivel_experiencia.lower()
    tipo_apresentacao = tipo_apresentacao.lower()
    
    recursos = {
        "novato": {
            "workshop": {"tempo": 60, "equipamento": "projetor básico", "sala": "Sala B"},
            "palestra": {"tempo": 30, "equipamento": "microfone e projetor básico", "sala": "Sala A"},
            "demonstracao": {"tempo": 20, "equipamento": "microfone", "sala": "Sala C"}
        },
        "experiente": {
            "workshop": {"tempo": 90, "equipamento": "projetor avançado", "sala": "Sala B"},
            "palestra": {"tempo": 45, "equipamento": "microfone e projetor avançado", "sala": "Sala A"},
            "demonstracao": {"tempo": 30, "equipamento": "microfone e tela interativa", "sala": "Sala C"}
        },
        "especialista": {
            "workshop": {"tempo": 120, "equipamento": "projetor avançado e equipamentos adicionais", "sala": "Sala VIP"},
            "palestra": {"tempo": 60, "equipamento": "microfone e projetor avançado", "sala": "Sala A"},
            "demonstracao": {"tempo": 40, "equipamento": "microfone, tela interativa e equipamento especial", "sala": "Sala VIP"}
        }
    }

    if nivel_experiencia in recursos and tipo_apresentacao in recursos[nivel_experiencia]:
        alocacao = recursos[nivel_experiencia][tipo_apresentacao]
        return alocacao
    else:
        return "Nível de experiência ou tipo de apresentação inválidos."


# Testando o programa
nivel_experiencia = input("Digite o nível de experiência do palestrante (novato, experiente, especialista): ")
tipo_apresentacao = input("Digite o tipo de apresentação (workshop, palestra, demonstração): ")

resultado = gerenciar_recursos(nivel_experiencia, tipo_apresentacao)

if isinstance(resultado, dict):
    print(f"Tempo de apresentação: {resultado['tempo']} minutos")
    print(f"Equipamento disponível: {resultado['equipamento']}")
    print(f"Sala alocada: {resultado['sala']}")
else:
    print(resultado)
