import pandas as pd
import numpy as np

# Criar um conjunto de dados fictício
data = {
    'ID': [1, 2, 3, 4, 5],
    'Nome': ['Alice', 'Bob', np.nan, 'David', 'Eva'],
    'Idade': [25, 30, 22, np.nan, 28],
    'Saldo': [1000, np.nan, 500, 1200, 800]
}

df = pd.DataFrame(data)

# Exibir o conjunto de dados original
print("Conjunto de dados original:")
print(df)

# Identificar valores ausentes
missing_values = df.isnull().sum()
print("\nValores ausentes por coluna:")
print(missing_values)

# Lidar com valores ausentes
# Para colunas numéricas, preencher com a média
df['Idade'].fillna(df['Idade'].mean(), inplace=True)

# Para colunas categóricas, preencher com o valor mais frequente
df['Nome'].fillna(df['Nome'].mode()[0], inplace=True)

# Para outras colunas numéricas, preencher com 0
df['Saldo'].fillna(0, inplace=True)

# Exibir o conjunto de dados após o tratamento
print("\nConjunto de dados após o tratamento de valores ausentes:")
print(df)
