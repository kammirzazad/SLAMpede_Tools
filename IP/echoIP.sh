#!/bin/bash

if [ "$1" == "b0" ]
then
	echo "169.254.178.91"	
elif [ "$1" == "o0" ]
then
	echo "169.254.38.152"	
elif [ "$1" == "p0" ]
then
	echo "169.254.83.65"	
elif [ "$1" == "b1" ]
then
	echo "169.254.60.250"
elif [ "$1" == "o1" ]
then
	echo "169.254.217.43"
elif [ "$1" == "p1" ]
then
	echo "169.254.73.103"
else
	echo No node named $1
	exit 1
fi
