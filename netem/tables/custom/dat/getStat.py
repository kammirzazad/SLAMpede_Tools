#!/usr/bin/python

import	sys
import	numpy

fn = sys.argv[1]
fh = open(fn, 'r')

data = []

for line in fh:
	data.append(float(line.split('\n')[0]))

print "mean:", round(numpy.mean(data),3)
print "stdev:", round(numpy.std(data),3)
