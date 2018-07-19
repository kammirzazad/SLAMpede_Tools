#!/bin/bash

if [ "$1" == "b0" ]
then
	echo "192.168.4.14"
elif [ "$1" == "o0" ]
then
	echo "192.168.4.15"	
elif [ "$1" == "p0" ]
then
	echo "192.168.4.16"	
elif [ "$1" == "b1" ]
then
	echo "192.168.4.9"
elif [ "$1" == "o1" ]
then
	echo "192.168.4.8"
elif [ "$1" == "p1" ]
then
	echo "192.168.4.4"
else
	echo No node named $1
	exit 1	
fi
