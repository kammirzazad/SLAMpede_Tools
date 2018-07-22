#!/bin/bash

# tc qdisc list
# sudo tc qdisc add dev enxb827eb1bfdbe root netem delay 97ms

IF="eth0"
RANGE="1"
AVERAGE="10"

ACTION="add"
#ACTION="change"

sudo tc qdisc $ACTION dev $IF root netem limit 2001 delay ${AVERAGE}ms ${RANGE}ms distribution normal
