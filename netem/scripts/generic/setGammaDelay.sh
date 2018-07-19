#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Did you forget index?"  
	exit
fi

# tc qdisc list
# sudo tc qdisc add dev enxb827eb1bfdbe root netem delay 97ms

IF="eth0"
#IF=$(../echoIF.sh $1)

NAMES=(gamma00 gamma01 gamma02 gamma10 gamma11 gamma12 gamma20 gamma21 gamma22)
MEANS=(1.75 2.25 2.75 2.25 2.875 3.5 2.75 3.5 4.25)
STDEVS=(1.41 1.77 2.12 1.58 1.98 2.37 1.73 2.17 2.6)

NAME=${NAMES[$1]}
RANGE=${STDEVS[$1]}
AVERAGE=${MEANS[$1]}

echo $NAME $AVERAGE $RANGE

ACTION="add"
#ACTION="change"

sudo tc qdisc $ACTION dev $IF root netem limit 2001 delay ${AVERAGE}ms ${RANGE}ms distribution $NAME
