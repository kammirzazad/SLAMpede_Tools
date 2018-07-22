#!/bin/bash

# remember name of the setting
export RIOT_NETEM=orange1

if [ "$1" == "o1" ]
then
	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 1


	# apply delay to each band
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 321.39ms 36.5ms distribution cloud_2_3_o1_p0 loss 0.0301%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.83.65/32 flowid 1:1


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
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 311.42ms 36.96ms distribution cloud_2_3_o0_p0 loss 0.0247%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.83.65/32 flowid 1:1


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
	# -- orange1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 331.94ms 38.65ms distribution cloud_2_3_b1_o1 loss 0.0428%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.217.43/32 flowid 1:1


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
	# -- orange0
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 300.7ms 36.95ms distribution cloud_2_3_b0_o0 loss 0.0126%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.38.152/32 flowid 1:1


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
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 320.02ms 37.37ms distribution cloud_2_3_p0_p1 loss 0.0283%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.73.103/32 flowid 1:1


	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

