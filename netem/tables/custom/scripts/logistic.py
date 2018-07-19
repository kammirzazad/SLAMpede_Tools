#!/usr/bin/python

from scipy.stats import logistic
import numpy as np
import matplotlib.pyplot as plt

min_x = 0
max_x = 4

x = np.linspace(min_x, max_x, 100)

plt.plot(x, logistic.pdf(x, loc=1.9, scale=0.15), 'r-', lw=5, alpha=0.6, label='logistic pdf')
plt.show()
