import networkx as nx
import matplotlib.pyplot as plt

# Estruturação do grafo
# Cria uma grafo não-direcionado. As arestas não têm direção. A relação entre os nós é bidirecional. 
G = nx.Graph()

# Adição de nós ao grafo (usuários)
G.add_node(1, nome="Alice", idade=25)
G.add_node(2, nome="Bob", idade=30)
G.add_node(3, nome="Charlie", idade=35)
G.add_node(4, nome="Diana", idade=40)

# Adição de arestas ao grafo (amizades)
G.add_edge(1, 2)
G.add_edge(1, 3)
G.add_edge(2, 4)
G.add_edge(3, 4)

# Visualização do grafo
pos = nx.spring_layout(G)  # Layout para a visualização

# Desenho dos nós com os atributos
nx.draw(G, pos, with_labels=False, node_color='lightblue', node_size=500)

# Adicionando rótulos aos nós
node_labels = nx.get_node_attributes(G, 'nome')
nx.draw_networkx_labels(G, pos, labels=node_labels)

# Exibindo o grafo
plt.title("Rede Social - Relacionamentos de Amizade")
plt.show()
