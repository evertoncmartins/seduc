# Você está programando um app de entrega de alimentos. O app deve calcular o custo de entrega com base nas seguintes condições:

# Se o pedido é inferior a R$10, há uma taxa de entrega fixa de R$5;
# Se o pedido é de R$10 ou mais, mas menos de R$20, a taxa de entrega é de R$3;
# Se o pedido é de R$20 ou mais, a entrega é gratuita.
# Se usuário é membro do programa de fidelidade do app, ele tem desconto de R$2 em qualquer taxa de entrega aplicável.

# Escreva o algoritmo de um programa que pegue o valor do pedido e a informação de que o usuário é ou não membro do programa de fidelidade e, então, calcule e imprima a taxa de entrega final.

pedido = float(input('Valor do pedido: '))
membro = input('Membro (S/N): ').lower()
entrega = 0

if pedido < 10:
    entrega += 5
elif pedido < 20:
    entrega += 3
else:
    entrega += 0

if membro == 's':
    entrega -= 2

print(f'Valor da entrega: {entrega}')