def classificar_produto(preco, categoria):
    categoria = categoria.lower()  # Ignora diferenciação por maiúsculas/minúsculas
    
    if categoria == "luxo":
        if preco > 1000:
            return "Premium"
        elif 500 <= preco <= 1000:
            return "Padrão"
        else:
            return "Acessível"
    
    elif categoria == "moda":
        if preco > 300:
            return "Premium"
        elif 100 <= preco <= 300:
            return "Padrão"
        else:
            return "Acessível"
    
    elif categoria == "eletronicos" or categoria == "eletrônicos":
        if preco > 1500:
            return "Premium"
        elif 700 <= preco <= 1500:
            return "Padrão"
        else:
            return "Acessível"
    
    else:
        return "Categoria não reconhecida"


# Testando o programa
preco = float(input("Digite o preço do produto: "))
categoria = input("Digite a categoria do produto (luxo, moda, eletrônicos): ")

classificacao = classificar_produto(preco, categoria)
print(f"O produto foi classificado como: {classificacao}")
