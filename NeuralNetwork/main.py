import numpy as np
import matplotlib.pyplot as plt
import neuralNetwork


def visualize_network(layer_sizes):
    fig, ax = plt.subplots()
    layer_offsets = np.cumsum([0] + [size for size in layer_sizes[:-1]])
    node_pos = []

    for i, layer_size in enumerate(layer_sizes):
        x = np.full(layer_size, i * 2)
        y = np.linspace(-1, 1, layer_size) + np.random.uniform(-0.1, 0.1, layer_size)
        node_pos.append(np.stack([x, y], axis=1))
        ax.scatter(x, y, s=500)

    for i in range(len(layer_sizes) - 1):
        for j in range(layer_sizes[i]):
            for k in range(layer_sizes[i + 1]):
                ax.plot([node_pos[i][j, 0], node_pos[i + 1][k, 0]], [node_pos[i][j, 1], node_pos[i + 1][k, 1]], 'k-')

    ax.axis('off')
    plt.show()


layer_sizes = [3, 4, 4, 1]
network = neuralNetwork.NeuralNetwork(layer_sizes)
input = np.array([-0.1,0.075,0.1])
print(network.forward(input))
visualize_network(layer_sizes)
