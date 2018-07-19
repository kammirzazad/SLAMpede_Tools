#!/usr/bin/python

import numpy
from scipy.stats import logistic

locH = 1.9
scaleH = 0.15

locL = 6.25
scaleL = 0.125

dataH = logistic.rvs(loc=locH, scale=scaleH, size=25000)
dataL = logistic.rvs(loc=locL, scale=scaleL, size=25000)

print 'Hi SNR: mean=', numpy.mean(dataH), 'stdev=', numpy.std(dataH)
print 'Lo SNR: mean=', numpy.mean(dataL), 'stdev=', numpy.std(dataL)

fileH = open('logisticH.dat', 'w')
fileL = open('logisticL.dat', 'w') 

for item in dataH:
	fileH.write(str(round(item, 3))+'\n')

for item in dataL:
	fileL.write(str(round(item, 3))+'\n')

fileH.close()
fileL.close()
