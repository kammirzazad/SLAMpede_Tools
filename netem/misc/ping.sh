#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Did you forget node's name (b0/b1/o0/o1/p0/p1)?"
	exit
fi


IP=$(../../IP/echoIP.sh $1)

sudo ping $IP -i 0.02 -c 1000 > $1".ping"
