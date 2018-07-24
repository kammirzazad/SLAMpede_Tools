#!/bin/bash

if [ "$1" == "o1" ]
then
	# remember name of the setting
	export RIOT_NETEM=orange1

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 339.87ms 36.49ms distribution cloud_2_5_o1_p1 loss 5.03%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.73.103/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

if [ "$1" == "o0" ]
then
	# remember name of the setting
	export RIOT_NETEM=orange0

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 310.67ms 38.28ms distribution cloud_2_5_o0_p0 loss 2.37%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.83.65/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

if [ "$1" == "b1" ]
then
	# remember name of the setting
	export RIOT_NETEM=blue1
fi

if [ "$1" == "b0" ]
then
	# remember name of the setting
	export RIOT_NETEM=blue0

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- orange0
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 302.93ms 37.09ms distribution cloud_2_5_b0_o0 loss 1.26%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.38.152/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

if [ "$1" == "p1" ]
then
	# remember name of the setting
	export RIOT_NETEM=pink1

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 330.86ms 36.85ms distribution cloud_2_5_p1_b1 loss 4.11%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.60.250/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

if [ "$1" == "p0" ]
then
	# remember name of the setting
	export RIOT_NETEM=pink0

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 321.82ms 37.46ms distribution cloud_2_5_p0_b1 loss 2.99%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.60.250/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

