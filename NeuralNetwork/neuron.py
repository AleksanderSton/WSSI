import numpy as np
class Neuron:
    def __init__(self, n_inputs, bias=0., weights=None):
        self.b = bias
        if weights is not None:
            self.ws = np.array(weights)
        else:
            self.ws = np.random.rand(n_inputs)

    def _f(self, x):
        return max(x * 0.1, x)

    def __call__(self, xs):
        return self._f(xs @ self.ws + self.b)