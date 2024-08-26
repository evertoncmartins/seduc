# Lista original de artistas
artistas = ["Artista A", "Artista B", "Artista C", "Artista D"]

# Índice do artista que cancelou (por exemplo, Artista B)
indice_cancelado = 1

# Novo artista que será adicionado
novo_artista = "Artista E"

# Removendo o artista que cancelou
artistas.pop(indice_cancelado)

# Adicionando o novo artista na mesma posição
artistas.insert(indice_cancelado, novo_artista)

print(artistas)
