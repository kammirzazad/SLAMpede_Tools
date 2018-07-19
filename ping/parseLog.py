#!/usr/bin/python

import sys

i_fh = open(sys.argv[1], 'r')
o_fh = open('parsed_time.txt', 'w')

for line in i_fh:
    if "time=" in line:
        time = line.split("time=")[1].split(" ms")[0]             
        o_fh.write(time + '\n')

o_fh.close()
