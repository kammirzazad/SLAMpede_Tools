#!/bin/bash

# remember name of the setting
export RIOT_NETEM=orange1

if [ "$1" == "o1" ]
then
	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 1


	# apply delay to each band
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 340.0ms 37.05ms distribution cloud_1_2_o1_p1 loss 0.0483%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.73.103/32 flowid 1:1


	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

# remember name of the setting
export RIOT_NETEM=orange0

if [ "$1" == "o0" ]
then
	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 1


	# apply delay to each band
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 309.18ms 35.95ms distribution cloud_1_2_o0_b1 loss 0.0259%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.60.250/32 flowid 1:1


	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

# remember name of the setting
export RIOT_NETEM=blue1

if [ "$1" == "b1" ]
then
	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 1


	# apply delay to each band
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 331.08ms 37.54ms distribution cloud_1_2_b1_p1 loss 0.0403%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.73.103/32 flowid 1:1


	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

# remember name of the setting
export RIOT_NETEM=blue0

if [ "$1" == "b0" ]
then
	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 2


	# apply delay to each band
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 302.48ms 36.97ms distribution cloud_1_2_b0_p0 loss 0.0137%
	# -- orange0
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 301.91ms 37.03ms distribution cloud_1_2_b0_o0 loss 0.0117%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.83.65/32 flowid 1:1
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.38.152/32 flowid 1:2


	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi


# remember name of the setting
export RIOT_NETEM=pink0

if [ "$1" == "p0" ]
then
	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 1


	# apply delay to each band
	# -- orange1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 319.09ms 36.51ms distribution cloud_1_2_p0_o1 loss 0.0301%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.217.43/32 flowid 1:1


	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

