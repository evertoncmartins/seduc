# Solicita a quantidade de alunos ao usuário
quantidade_alunos = int(input("Digite a quantidade de alunos: "))

# Valida a entrada
if quantidade_alunos <= 0:
    print("Quantidade de alunos inválida.")
else:
    # Inicializa a soma das notas
    soma_notas = 0

    # Loop para solicitar e somar as notas de cada aluno
    for i in range(quantidade_alunos):
        while True:
            nota_str = input(f"Digite a nota do aluno {i + 1}: ")
            if nota_str.replace('.', '', 1).isdigit():  # Verifica se a string pode ser convertida para float
                nota = float(nota_str)
                if 0 <= nota <= 10:  # Valida se a nota está entre 0 e 10
                    soma_notas += nota
                    break  # Sai do loop interno se a nota for válida
                else:
                    print("Nota inválida. Digite uma nota entre 0 e 10.")
            else:
                print("Entrada inválida. Digite um número.")

    # Calcula a média das notas
    media = soma_notas / quantidade_alunos

    # Exibe a média das notas
    print(f"A média das notas da turma é: {media:.2f}")