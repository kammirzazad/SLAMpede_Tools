#!/bin/bash

# remember name of the setting
export RIOT_NETEM=orange1

if [ "$1" == "o1" ]
then
	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 1


	# apply delay to each band
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 330.26ms 36.97ms distribution cloud_4_2_o1_b1 loss 0.0381%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.60.250/32 flowid 1:1


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
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay infms infms distribution cloud_4_2_o0_p0 loss 0.0196%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.83.65/32 flowid 1:1


	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi


# remember name of the setting
export RIOT_NETEM=blue0

if [ "$1" == "b0" ]
then
	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 1


	# apply delay to each band
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 302.71ms 37.47ms distribution cloud_4_2_b0_p0 loss 0.0127%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.83.65/32 flowid 1:1


	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

# remember name of the setting
export RIOT_NETEM=pink1

if [ "$1" == "p1" ]
then
	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 1


	# apply delay to each band
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay infms infms distribution cloud_4_2_p1_b1 loss 0.0426%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.60.250/32 flowid 1:1


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
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 321.0ms 37.62ms distribution cloud_4_2_p0_b1 loss 0.0294%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.60.250/32 flowid 1:1


	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

