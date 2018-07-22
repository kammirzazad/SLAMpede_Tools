#!/bin/bash

if [ "$1" == "o1" ]
then
	# remember name of the setting
	export RIOT_NETEM=orange1

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 2

	# apply delay to each band
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 340.98ms 37.21ms distribution cloud_5_1_o1_p1 loss 0.0518%

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
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 311.27ms 38.09ms distribution cloud_5_1_o0_p1 loss 0.0211%

	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.73.103/32 flowid 1:2

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
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 333.17ms 38.72ms distribution cloud_5_1_b1_p1 loss 0.0367%

	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.73.103/32 flowid 1:2

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
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 300.24ms 37.26ms distribution cloud_5_1_b0_p1 loss 0.0093%

	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.73.103/32 flowid 1:2

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
	# -- pink1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 319.12ms 36.55ms distribution cloud_5_1_p0_p1 loss 0.0308%

	# filter outgoing traffic to bands
	sudo tc qdisc add dev eth0 root handle 1: prio bands 169.254.73.103/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi
