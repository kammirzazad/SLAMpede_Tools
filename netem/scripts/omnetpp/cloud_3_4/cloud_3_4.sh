#!/bin/bash

if [ "$1" == "o1" ]
then
	# remember name of the setting
	export RIOT_NETEM=orange1

	# create a band for each destination
	sudo tc qdisc add dev eth0 root handle 1: prio bands 3

	# apply delay to each band
	# -- pink0
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 321.57ms 36.96ms distribution cloud_3_4_o1_p0 loss 3.05%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.83.65/32 flowid 1:2

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
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 311.58ms 37.27ms distribution cloud_3_4_o0_p0 loss 2.25%

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
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 301.94ms 37.48ms distribution cloud_3_4_b0_o0 loss 1.29%

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
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 328.47ms 36.99ms distribution cloud_3_4_p1_b1 loss 4.11%

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
	sudo tc qdisc add dev eth0 parent 1:2 handle 10: netem delay 320.56ms 37.53ms distribution cloud_3_4_p0_b1 loss 2.99%

	# filter outgoing traffic to bands
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match ip dst 169.254.60.250/32 flowid 1:2

	# default band
	sudo tc filter add dev eth0 protocol ip parent 1:0 prio 1 u32 match u32 0 0 flowid 1:1
fi

