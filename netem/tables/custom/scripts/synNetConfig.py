#!/usr/bin/python

import sys
import json
import scipy.stats as st

def	extractEthIPs(hosts):

	ips = {}

	for host in hosts:
		host['name']

		for interface in host['interfaces']:
			if interface['name'] == 'eth0':
				ips[host['name']] = interface['IP']		
		
	

def	genData(link):

	dist  = getattr(st, link['distribution'])
	loc   = float(link['loc'].split('us')[0])
	scale = float(link['scale'].split('us')[0])

	if 'shape3' in link:
		data = dist.rvs(link['shape'], link['shape2'], link['shape3'], loc=loc, scale=scale, size=25000)
	elif 'shape2' in link:
		data = dist.rvs(link['shape'], link['shape2'], loc=loc, scale=scale, size=25000)
	elif 'shape' in link:
		data = dist.rvs(link['shape'], loc=loc, scale=scale, size=25000)
	else:
		data = dist.rvs(loc=loc, scale=scale, size=25000)

	return data


def	genDatFile(link):

	fn = link['src_host']+'_'+link['dst_host']+'.dat'	

	with open(fn, 'w') as fh:
		for datum in genData(link):
			fh.write(str(round(datum,3))+'\n')


def	genBashScript():
	config = sys.argv[1].split('/')[-1].split('.')[0]
	with open(config+'.sh','w') as fh:
		fh.write('#!/bin/bash'+'\n')


if len(sys.argv) != 2:
	print "usage:", "["+sys.argv[0]+"]", "[netConfig]"
	exit(1)

with open(sys.argv[1], 'r') as fh:
	net = json.load(fh)

for link in net['links']:
	genDatFile(link)
	print 'generated dat file for (', link['src_host'] + '\t' + link['dst_host'] + ')'

#genBashScript()
