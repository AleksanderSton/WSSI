import numpy as np
import neuron


class NeuralNetwork:
    def __init__(self, layer_sizes):
        self.layers = []
        for i in range(len(layer_sizes) - 1):
            layer = [neuron.Neuron(layer_sizes[i]) for _ in range(layer_sizes[i + 1])]
            self.layers.append(layer)

    def forward(self, inputs):
        for layer in self.layers:
            outputs = [neuron(inputs) for neuron in layer]
            inputs = np.array(outputs)
        return inputs