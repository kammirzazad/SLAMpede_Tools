#!/usr/bin/python

import	os
import	sys

def	createEELGenerator(scenario):
	with open('eelgenerator.xml','w') as fh:
		fh.write('<?xml version="1.0" encoding="UTF-8"?>')
		fh.write('\n')
		fh.write('<!DOCTYPE eventgenerator SYSTEM "file:///usr/share/emane/dtd/eventgenerator.dtd">')
		fh.write('\n')
		fh.write('<eventgenerator library="eelgenerator">')
		fh.write('\n')
		fh.write('<param name="inputfile" value="' + scenario + '" />')
		fh.write('\n')
		fh.write('<paramlist name="loader">')
		fh.write('\n')
		fh.write('\t<item value="commeffect:eelloadercommeffect:delta"/>')
		fh.write('\n')
		fh.write('\t<item value="location,velocity,orientation:eelloaderlocation:delta"/>')
		fh.write('\n')
		fh.write('\t<item value="pathloss:eelloaderpathloss:delta"/>')
		fh.write('\n')
		fh.write('\t<item value="antennaprofile:eelloaderantennaprofile:delta"/>')
		fh.write('\n')
		fh.write('</paramlist>')
		fh.write('\n')
		fh.write('</eventgenerator>')
		fh.write('\n')


def	createEventService(eventdevice):
	with open('eventservice.xml','w') as fh:
		fh.write('<?xml version="1.0" encoding="UTF-8"?>')
		fh.write('\n')
		fh.write('<!DOCTYPE eventservice SYSTEM "file:///usr/share/emane/dtd/eventservice.dtd">')
		fh.write('\n')
		fh.write('<eventservice>')
		fh.write('\n')
		fh.write('<param name="eventservicegroup" value="224.1.2.8:45703"/>')
		fh.write('\n')
		fh.write('<param name="eventservicedevice" value="' + eventdevice + '"/>')
		fh.write('\n')
		fh.write('<generator name="EEL Generator" definition="eelgenerator.xml"/>')
		fh.write('\n')
		fh.write('</eventservice>')
		fh.write('\n')


def	getEventDevice(ctrlNetIdx):
	fn = '/tmp/ifconfig.txt'
	os.system('ifconfig > ' + fn)

	with open(fn,'r') as fh:
		for line in fh:
			if 'ctrl'+str(ctrlNetIdx) in line:
				return line.split(':')[0]

	print 'cannot find control network', ctrlNetIdx
	exit(1)

def	launchEventService():
	os.system('emaneeventservice eventservice.xml -l 4')


if __name__ == "__main__":

	if len(sys.argv) != 2:
		print 'usage:',sys.argv[0],'[scenario]'
		exit(1)

	ctrlNetIdx = 0
	scenario = sys.argv[1]
	eventDev = getEventDevice(ctrlNetIdx)

	print '[INFO] scenario:', scenario
	print '[INFO] control device:', eventDev
	print '[INFO] control network index:', ctrlNetIdx

	createEventService(eventDev)
	createEELGenerator(scenario)
	launchEventService()
