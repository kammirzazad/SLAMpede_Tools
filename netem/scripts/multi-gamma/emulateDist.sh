#!/bin/bash
# reference : https://gist.github.com/arr2036/6598137

#set -x
declare -A DISTMATRIX

# b0's destination delays
DISTMATRIX[0,1]="8"
DISTMATRIX[0,2]="0"
DISTMATRIX[0,3]="7"
DISTMATRIX[0,4]="1"
DISTMATRIX[0,5]="2"

# o0's destination delays
DISTMATRIX[1,0]="4"
DISTMATRIX[1,2]="4"
DISTMATRIX[1,3]="6"
DISTMATRIX[1,4]="0"
DISTMATRIX[1,5]="3"

# p0's destination delays
DISTMATRIX[2,0]="0"
DISTMATRIX[2,1]="3"
DISTMATRIX[2,3]="6"
DISTMATRIX[2,4]="1"
DISTMATRIX[2,5]="7"

# b1's destination delays
DISTMATRIX[3,0]="5"
DISTMATRIX[3,1]="0"
DISTMATRIX[3,2]="5"
DISTMATRIX[3,4]="4"
DISTMATRIX[3,5]="8"

# o1's destination delays
DISTMATRIX[4,0]="5"
DISTMATRIX[4,1]="5"
DISTMATRIX[4,2]="7"
DISTMATRIX[4,3]="7"
DISTMATRIX[4,5]="5"

# p1's destination delays
DISTMATRIX[5,0]="1"
DISTMATRIX[5,1]="8"
DISTMATRIX[5,2]="3"
DISTMATRIX[5,3]="4"
DISTMATRIX[5,4]="8"


if [ "$#" -ne 1 ]; then
	echo "Did you forget node's name (b0/b1/o0/o1/p0/p1)?"  
	exit
fi

declare -A INDICE
NODES=("b0" "o0" "p0" "b1" "o1" "p1")
NAMES=(gamma00 gamma01 gamma02 gamma10 gamma11 gamma12 gamma20 gamma21 gamma22)
MEANS=(1.75 2.25 2.75 2.25 2.875 3.5 2.75 3.5 4.25)
STDEVS=(1.41 1.77 2.12 1.58 1.98 2.37 1.73 2.17 2.6)
INDICE=( ["b0"]=0 ["o0"]=1 ["p0"]=2 ["b1"]=3 ["o1"]=4 ["p1"]=5 )
MYINDEX=${INDICE[$1]}

# here we go
sudo tc qdisc add dev eth0 root handle 1: prio bands 6

VAR=2
HANDLE=10

for NODE in "${NODES[@]}"
do
	if [ "$1" == $NODE ]
	then	
		continue
	fi

        INDEX=${INDICE[$NODE]}
	DISTINDEX=${DISTMATRIX[$MYINDEX,$INDEX]}

	NAME=${NAMES[$DISTINDEX]}
	MEAN=${MEANS[$DISTINDEX]}
	STDEV=${STDEVS[$DISTINDEX]}

	#echo $NODE"'s IP is "$dstip" "$NAME" "$MEAN" "$STDEV
	
	sudo tc qdisc add dev eth0 parent 1:$VAR handle $HANDLE: netem delay ${MEAN}ms ${STDEV}ms distribution $NAME #loss 2%

	VAR=$((VAR+1))
	HANDLE=$((HANDLE+1))	
done

VAR=2

for NODE in "${NODES[@]}"
do
	if [ "$1" == $NODE ]
	then
		continue
	fi	
	
	IP=$(../../../ip/echoIP.sh $NODE)
	
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst $IP/32 flowid 1:$VAR	

	VAR=$((VAR+1))
done

sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
