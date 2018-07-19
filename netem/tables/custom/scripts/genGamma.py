#!/usr/bin/python

import	math
import	numpy as np
from scipy.stats import gamma

g_loc = -0.25
shapes = [2, 2.5, 3]
scales = [1, 1.25, 1.5]

def	genGamma(aIdx, bIdx):

	data = gamma.rvs(shapes[aIdx], loc=g_loc, scale=scales[bIdx], size=25000)
        
	print	"a="+str(aIdx), "b="+str(bIdx),\
		"avg="+str(round(np.mean(data), 2)),\
		"eAvg="+str(round((scales[bIdx] * shapes[aIdx])+g_loc, 2)),\
		"std="+str(round(np.std(data), 2)),\
		"eStd="+str(round(scales[bIdx] * math.sqrt(shapes[aIdx]), 2))

	fh = open('gamma'+str(aIdx)+str(bIdx)+'.dat', 'w')

	for item in data:
		fh.write(str(round(item,3))+'\n')

	fh.close()

########################################
for aIdx in range(len(shapes)):
	for bIdx in range(len(scales)):
		genGamma(aIdx, bIdx)
