#!/bin/bash

if [ "$1" == "o1" ]
then
	# remember name of the setting
	export RIOT_NETEM=orange1
fi

if [ "$1" == "o0" ]
then
	# remember name of the setting
	export RIOT_NETEM=orange0

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 309.84ms 37.87ms distribution cloud_4_3_o0_b1 loss 0.0196%

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
	# -- orange1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 330.48ms 35.91ms distribution cloud_4_3_b1_o1 loss 0.0382%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.217.43/32 flowid 1:2

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
	# -- blue1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 302.27ms 37.27ms distribution cloud_4_3_b0_b1 loss 0.0112%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.60.250/32 flowid 1:2

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
	# -- orange1
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 340.07ms 36.72ms distribution cloud_4_3_p1_o1 loss 0.0476%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.217.43/32 flowid 1:2

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
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 320.45ms 37.76ms distribution cloud_4_3_p0_b1 loss 0.0333%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.60.250/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

