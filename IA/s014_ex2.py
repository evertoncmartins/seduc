import pandas as pd

# Criar um conjunto de dados fictício com uma variável categórica
data = {
    'ID': [1, 2, 3, 4, 5],
    'Cor': ['Vermelho', 'Verde', 'Azul', 'Vermelho', 'Amarelo']
}
df = pd.DataFrame(data)

# Exibir o conjunto de dados original
print("Conjunto de dados original:")
print(df)

# Aplicar one-hot encoding
df_encoded = pd.get_dummies(df, columns=['Cor'], prefix='Cor')

# Exibir o conjunto de dados após one-hot encoding
print("Conjunto de dados após one-hot encoding:")
print(df_encoded)
