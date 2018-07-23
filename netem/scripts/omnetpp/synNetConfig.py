#!/usr/bin/python

#	
#	synNetConfig.py
#
#	- generates emulation script & '.dist' files for Linux's netEm fron given network config
#
#	Author	    : Kamyar Mirzazad (kammirzazad@utexas.edu)
#	Created  On : Fri, July 20th, 2018
#	Modified On : Mon, July 23rd, 2018
#

import	os
import	sys
import	json
import  numpy as np
import	scipy.stats as st

minEthDelay = 250
path2converter = '/home/osboxes/Documents/RIoT_slampede/netem/tables/maketable'

distParams = {}

abb = { 'blue0':'b0', 'orange0':'o0', 'pink0':'p0', 'blue1':'b1', 'orange1':'o1', 'pink1':'p1' } 

tc_cmd = \
{\
	'band':'sudo tc qdisc add dev eth0 root handle 1: prio bands ',\
	'delay':'sudo tc qdisc add dev eth0 parent 1:',\
	'filter':'sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst ',\
	'default':'sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1'\
}

def	getNetEmID(config,link):
	return config + '_' + abb[link['src_host']] + '_' + abb[link['dst_host']]


def	addDelay(config,link,var,handle):	

	avg_us, std_us = distParams[getNetEmID(config,link)]

	avg_ms = round(avg_us/1000,2)
	std_ms = round(std_us/1000,2)

	cmd  = tc_cmd['delay'] + str(var) + ' handle ' + str(handle) + ': netem '
	cmd += 'delay ' + str(avg_ms) + 'ms ' + str(std_ms) + 'ms ' 
	cmd += 'distribution ' + getNetEmID(config,link) + ' '
	cmd += 'loss ' + str(link['loss_rate']) + '%'
	
	return cmd


def	addHost(src_host,links,IPs,config):

	mylinks = []
	for link in links:
		if link['src_host'] == src_host:
			mylinks.append(link)	
	
	cmd  = 'if [ "$1" == "' + abb[src_host] + '" ]\n'
	cmd += 'then\n'

	cmd += '\t' + '# remember name of the setting\n'
	cmd += '\t' + 'export RIOT_NETEM=' + src_host + '\n'

	if not mylinks:
		print  'No link found with source of ' + src_host
		cmd += 'fi\n'
		return cmd

	cmd += '\n'
	cmd += '\t' + '# create a band for each destination\n'
	cmd += '\t' + tc_cmd['band'] + str(max(len(mylinks)+1,3)) + '\n'

	cmd += '\n'
	cmd += '\t' + '# apply delay to each band' + '\n'
	
	for i in range(len(mylinks)):

		cmd += '\t' + '# -- ' + mylinks[i]['dst_host'] + '\n'
		cmd += '\t' + addDelay(config, mylinks[i], (2+i), (10+i)) + '\n'


	cmd += '\n'
	cmd += '\t' + '# filter outgoing traffic to bands' + '\n'

	for i in range(len(mylinks)):

		cmd += '\t' + tc_cmd['filter'] + IPs[mylinks[i]['dst_host']] + '/32 flowid 1:' + str(2+i) + '\n'

	cmd += '\n'
	cmd += '\t' + '# default band'  + '\n'
	cmd += '\t' + tc_cmd['default'] + '\n'
	cmd += 'fi\n'

	return cmd


def	getEthIPs(hosts):
	IPs = {}
	for host in hosts:		
		for interface in host['interfaces']:
			if interface['name'] == 'eth0':
				IPs[host['name']] = interface['IP']
				break
	return	IPs


def	genData(link):

	dist  = getattr(st, link['distribution'])
	loc   = float(link['loc'].split('us')[0]) - minEthDelay
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


def	genDistFile(config, link):
	
	distFN = config + '/dist/' + getNetEmID(config,link) + '.dist'

	data = genData(link)

	distParams[getNetEmID(config,link)] = (np.mean(data), np.std(data))

	with open('temp.dat', 'w') as fh:
		for datum in data:
			fh.write(str(round(datum,3))+'\n')

	os.system(path2converter + ' temp.dat > ' + distFN)
	os.system('rm temp.dat')


def	genEmulationScript(config, links, IPs):

	fn = config + '/' + config + '.sh'

	with open(fn,'w') as fh:

		fh.write('#!/bin/bash'+'\n\n')		

		for host in IPs:
			#print 'Adding host ' + host + ' to the script'
			fh.write(addHost(host,links,IPs,config) + '\n')

	os.system("chmod +x " + fn)


########################################
#### here we go ########################
########################################

if len(sys.argv) != 2:
	print "usage:", "["+sys.argv[0]+"]", "[netConfig]"
	exit(1)

with open(sys.argv[1], 'r') as fh:
	net = json.load(fh)

config = sys.argv[1].split('/')[-1].split('.')[0]
os.system('rm -rf ' + config + '/')
os.system('mkdir '  + config + '/')
os.system('mkdir '  + config + '/dist/')

for link in net['links']:
	genDistFile(config, link)
	#print 'generated ' + getNetEmID(config,link)+'.dist'

genEmulationScript(config, net['links'], getEthIPs(net['hosts']))

########################################
