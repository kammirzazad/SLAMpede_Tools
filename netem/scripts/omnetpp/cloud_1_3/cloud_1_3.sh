#!/bin/bash

if [ "$1" == "o1" ]
then
	# remember name of the setting
	export RIOT_NETEM=orange1

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 2

	# apply delay to each band
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 340.99ms 37.2ms distribution cloud_1_3_o1_p1 loss 0.0518%

	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.73.103/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

if [ "$1" == "o0" ]
then
	# remember name of the setting
	export RIOT_NETEM=orange0

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 2

	# apply delay to each band
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 311.09ms 37.94ms distribution cloud_1_3_o0_p0 loss 0.0238%

	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.83.65/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

if [ "$1" == "b1" ]
then
	# remember name of the setting
	export RIOT_NETEM=blue1

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 2

	# apply delay to each band
	# -- orange1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 333.13ms 38.72ms distribution cloud_1_3_b1_o1 loss 0.0393%

	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.217.43/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

if [ "$1" == "b0" ]
then
	# remember name of the setting
	export RIOT_NETEM=blue0

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 2

	# apply delay to each band
	# -- orange0
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 300.08ms 37.16ms distribution cloud_1_3_b0_o0 loss 0.0134%

	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.38.152/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

if [ "$1" == "p1" ]
then
	# remember name of the setting
	export RIOT_NETEM=pink1
fi

if [ "$1" == "p0" ]
then
	# remember name of the setting
	export RIOT_NETEM=pink0

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 2

	# apply delay to each band
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 319.15ms 36.55ms distribution cloud_1_3_p0_b1 loss 0.0335%

	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.60.250/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi
