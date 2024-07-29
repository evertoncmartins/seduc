# Enunciado

# Escreva uma função em Python que receba dois parâmetros: valor_pedido (um número real representando o valor do pedido) e dias_para_entrega (um número inteiro representando os dias restantes para a entrega do pedido). Com base nesses parâmetros, a função deve classificar o pedido nas seguintes categorias:

# •	"Normal": para pedidos com valor menor que 100 reais ou com mais de 7 dias para entrega;
# •	"Prioritário": para pedidos com valor entre 100 e 500 reais ou com 4 a 7 dias para entrega;
# •	"Urgente": para pedidos com valor acima de 500 reais ou com menos de 4 dias para entrega.

def classificar_pedido(valor_pedido, dias_para_entrega):
    if valor_pedido < 100 or dias_para_entrega > 7:
        pedido = 'Normal'
    elif 100 <= valor_pedido <= 500 or 4 <= dias_para_entrega <= 7:
        pedido = 'Prioritário'
    else:
        pedido = 'Urgente'

    return pedido

valor_pedido = float(input('Digite o valor do pedido: '))
dias_para_entrega = int(input('Digite a quantidade de dias para entrega: '))

pedidos = classificar_pedido(valor_pedido, dias_para_entrega)

print(f'Classificação do pedido: {pedidos}')

