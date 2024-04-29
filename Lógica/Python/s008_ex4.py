"""
Em um cinema, é permitida a entrada em um filme somente para pessoas com 18 anos ou mais. No entanto, há exceções que permitem a entrada, caso:
- A pessoa tenha entre 15 e 17 anos E
- A pessoa esteja acompanhada por um adulto OU possua uma autorização dos pais.
- Escreva um programa que determine se uma pessoa pode assistir ao filme ou não.
"""

idade = int(input("Digite a idade: "))

if idade >= 15 and idade <= 17:
    acompanhado = input("Está acompanhado de adulto? (S/N): ").lower()
    if acompanhado == 's':
        print("Você pode assistir o filme")
    else:
        print("Não pode assistir o filme")
else:
    print("Você pode assistir o filme.")
