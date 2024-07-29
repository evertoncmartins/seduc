# Detalhes do Exercício:

# Você é um analista de TI em uma grande corporação. Sua tarefa é desenvolver um sistema simples que recomenda equipamentos de TI (computadores, laptops, tablets) para os departamentos da empresa, com base em suas necessidades específicas. Cada departamento tem diferentes requisitos e preferências:

# •	Departamento de Desenvolvimento de Software: prefere laptops com alto desempenho;
# •	Departamento de Marketing: prefere tablets para facilitar a apresentação e mobilidade;
# •	Departamento de Recursos Humanos: prefere computadores desktop devido à sua estabilidade e custo-benefício;
# •	Departamento de Pesquisa e Desenvolvimento (P&D): precisa de equipamentos com especificações de última geração.

# O programa deve perguntar ao usuário qual é o departamento e, com base na escolha, recomendar o equipamento mais adequado.

departamento = int(input('Departamentos: \n 1- Departamento de Desenvolvimento de Software \n 2- Departamento de Marketing \n 3- Departamento de Recursos Humanos \n 4- Departamento de Pesquisa e Desenvolvimento (P&D) \n Escolha o departamento: '))

if departamento == 1:
    print('Laptops de alto desempenho')
elif departamento == 2:
    print('Tablets')
elif departamento == 3:
    print('Desktop')
elif departamento == 4: 
    print('Desktops, Laptops e Tablets de última geração')
else: 
    print('Erro')