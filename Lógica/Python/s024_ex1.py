# Simulação da base de dados de bugs reportados (dicionário) > Id, Titulo, Gravidade e Contagem
bugs_reportados = [
    {"id": 1, "titulo": "Bug na página de login", "gravidade": "Alta", "contagem": 3},
    {"id": 2, "titulo": "Erro de carregamento de imagem", "gravidade": "Média", "contagem": 7},
    {"id": 3, "titulo": "Falha na validação de formulário", "gravidade": "Baixa", "contagem": 1},
    {"id": 4, "titulo": "Bug na integração com API", "gravidade": "Alta", "contagem": 8},
    {"id": 5, "titulo": "Problema no sistema de notificações", "gravidade": "Média", "contagem": 6},
    {"id": 6, "titulo": "Erro no layout do dashboard", "gravidade": "Baixa", "contagem": 2},
]

# Relatório de bugs com mais de 5 reportagens
def gerar_relatorio(bugs):
    print("Relatório de Bugs Reportados (Prioridade: Mais de 5 reportagens)\n")
    print(f"{'ID':<5}{'Título':<40}{'Gravidade':<10}{'Reportagens'}")
    print("-" * 60)
    
    # Processamento dos dados
    for bug in bugs:
        if bug["contagem"] > 5:
            print(f"{bug['id']:<5}{bug['titulo']:<40}{bug['gravidade']:<10}{bug['contagem']}")

# Chamada da função para gerar o relatório
gerar_relatorio(bugs_reportados)
