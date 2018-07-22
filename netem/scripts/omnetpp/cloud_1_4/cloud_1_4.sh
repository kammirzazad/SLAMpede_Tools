#!/bin/bash

# remember name of the setting
export RIOT_NETEM=orange1

if [ "$1" == "o1" ]
then
	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 1


	# apply delay to each band
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 341.21ms 36.72ms distribution cloud_1_4_o1_p1 loss 0.049%


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
	sudo tc qdisc add dev eth0 root handle 1: prio bands 2


	# apply delay to each band
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 311.46ms 37.09ms distribution cloud_1_4_o0_b1 loss 0.0226%
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 309.08ms 36.75ms distribution cloud_1_4_o0_p0 loss 0.025%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.60.250/32 flowid 1:1
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.83.65/32 flowid 1:2


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
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 320.14ms 37.36ms distribution cloud_1_4_b1_p0 loss 0.0315%


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
	# -- orange0
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 302.25ms 37.16ms distribution cloud_1_4_b0_o0 loss 0.013%


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
	# -- orange1
	sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem delay infms infms distribution cloud_1_4_p0_o1 loss 0.0353%


	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.217.43/32 flowid 1:1


	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

