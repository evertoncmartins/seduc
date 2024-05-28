import pandas as pd
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords

# Certifique-se de que os pacotes de dados do NLTK estejam baixados
nltk.download('punkt')
nltk.download('stopwords')

# Função para pré-processamento de texto


def preprocess_text(text):
    # Tokenização
    tokens = word_tokenize(text)
    # Remoção de pontuações
    tokens = [word for word in tokens if word.isalpha()]
    # Transformação para minúsculas
    tokens = [word.lower() for word in tokens]
    # Remoção de stop words
    stop_words = set(stopwords.words('english'))
    tokens = [word for word in tokens if word not in stop_words]
    return tokens


# Exemplo de conjunto de dados
data = {
    'ID': [1, 2, 3, 4, 5],
    'Texto': [
        'This is the first document.',
        'This document is the second document.',
        'And this is the third one.',
        'Is this the first document?',
        'The quick brown fox jumps over the lazy dog.'
    ]
}

df = pd.DataFrame(data)

# Aplicar pré-processamento de texto à coluna 'Texto'
df['Texto_Processado'] = df['Texto'].apply(preprocess_text)

# Exibir o conjunto de dados após o pré-processamento de texto
print("Conjunto de dados após o pré-processamento de texto:")
print(df[['ID', 'Texto_Processado']])
