#!/bin/bash

if [ "$1" == "o1" ]
then
	# remember name of the setting
	export RIOT_NETEM=orange1

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 330.92ms 37.1ms distribution cloud_1_5_o1_b1 loss 3.77%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.60.250/32 flowid 1:2

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
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 309.1ms 36.98ms distribution cloud_1_5_o0_b1 loss 2.51%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.60.250/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

if [ "$1" == "b1" ]
then
	# remember name of the setting
	export RIOT_NETEM=blue1

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 329.13ms 37.05ms distribution cloud_1_5_b1_p1 loss 4.18%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.73.103/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

if [ "$1" == "b0" ]
then
	# remember name of the setting
	export RIOT_NETEM=blue0

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 301.52ms 38.45ms distribution cloud_1_5_b0_p0 loss 1.19%
	# -- orange0
	sudo tc qdisc add dev eth0 parent 1:3 handle 11: netem delay 303.06ms 36.49ms distribution cloud_1_5_b0_o0 loss 1.4%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.83.65/32 flowid 1:2
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.38.152/32 flowid 1:3

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
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- orange1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 319.69ms 37.29ms distribution cloud_1_5_p0_o1 loss 3.03%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.217.43/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

