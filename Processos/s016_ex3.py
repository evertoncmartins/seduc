import networkx as nx
from collections import deque
import matplotlib.pyplot as plt

# Função BFS para encontrar o caminho mais curto entre dois nós
def bfs_caminho_mais_curto(grafo, inicio, fim):
    if inicio == fim:
        return [inicio]

    # Fila para a BFS
    fila = deque([inicio])
    # Dicionário para rastrear os pais de cada nó
    pais = {inicio: None}
    
    while fila:
        no_atual = fila.popleft()
        
        for vizinho in grafo.neighbors(no_atual):
            if vizinho not in pais:
                pais[vizinho] = no_atual
                if vizinho == fim:
                    caminho = [vizinho]
                    while no_atual is not None:
                        caminho.append(no_atual)
                        no_atual = pais[no_atual]
                    caminho.reverse()
                    return caminho
                fila.append(vizinho)
    
    return None  # Caso não haja caminho entre inicio e fim

# Criando o grafo da rede social
G = nx.Graph()

# Adicionando nós (usuários)
G.add_node(1, nome="Alice", idade=25)
G.add_node(2, nome="Bob", idade=30)
G.add_node(3, nome="Charlie", idade=35)
G.add_node(4, nome="Diana", idade=40)
G.add_node(5, nome="Ana", idade=22)

# Adicionando arestas (amizades)
G.add_edge(1, 2)
G.add_edge(1, 3)
G.add_edge(1, 4)
G.add_edge(2, 4)
G.add_edge(3, 4)
G.add_edge(4, 5)

# Testando o BFS
inicio = 1  # Alice
fim = 5     # Ana

caminho = bfs_caminho_mais_curto(G, inicio, fim)
if caminho:
    print(f"O caminho mais curto de {inicio} para {fim} é: {caminho}")
else:
    print(f"Não há caminho de {inicio} para {fim}")

# Visualização do grafo
pos = nx.spring_layout(G)
nx.draw(G, pos, with_labels=True, node_color='lightblue', node_size=500)

# Adicionando rótulos aos nós
node_labels = nx.get_node_attributes(G, 'nome')

# Deslocando os rótulos para evitar sobreposição
offset = 0.1  # Ajuste a quantidade de deslocamento conforme necessário
pos_labels = {node: (pos[node][0], pos[node][1] + offset) for node in pos}

nx.draw_networkx_labels(G, pos_labels, labels=node_labels)
plt.title("Rede Social - Relacionamentos de Amizade")
plt.show()
