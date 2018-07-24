#!/bin/bash

if [ "$1" == "o1" ]
then
	# remember name of the setting
	export RIOT_NETEM=orange1

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 341.67ms 36.96ms distribution cloud_2_4_o1_p1 loss 4.85%

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
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 309.0ms 36.09ms distribution cloud_2_4_o0_p0 loss 2.37%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.83.65/32 flowid 1:2

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
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 321.33ms 38.08ms distribution cloud_2_4_b1_p0 loss 2.81%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.83.65/32 flowid 1:2

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
	# -- orange0
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 303.44ms 37.0ms distribution cloud_2_4_b0_o0 loss 1.12%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.38.152/32 flowid 1:2

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
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 318.65ms 36.42ms distribution cloud_2_4_p0_o1 loss 3.31%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.217.43/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

