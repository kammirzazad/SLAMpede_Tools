#!/usr/bin/python

import sys
import math
import numpy
import matplotlib.pyplot as plt
from scipy.stats import gamma

g_shape = float(sys.argv[1])
g_scale = float(sys.argv[2])

mean = g_shape * g_scale
sigma = math.sqrt(mean * g_scale)

data = gamma.rvs(g_shape, scale=g_scale, size=25000)

data = (data-mean)/sigma

print 'mean:',numpy.mean(data),'var:',numpy.var(data)

plt.hist(data, bins=50)
plt.savefig('gamma_shape:'+sys.argv[1]+'_scale:'+sys.argv[2]+'.png')
