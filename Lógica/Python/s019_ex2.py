n = int(input("Digite o número de termos da sequência de Fibonacci: "))

anterior = 0
atual = 1

for i in range(n - 1):
    proximo = anterior + atual
    anterior = atual
    atual = proximo

print(atual)
