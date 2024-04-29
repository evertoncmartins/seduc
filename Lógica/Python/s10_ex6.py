numero = 1500
encontrado = False

for numero in range(1500, 2700):
    if numero % 5 == 0 and numero % 7 == 0 and encontrado == False:
        print(f"O 1º número divisível por 5 e 7 entre 1500 e 2700 é: {numero}")
        encontrado = True
