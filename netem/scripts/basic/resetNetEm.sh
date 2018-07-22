#!/bin/bash

#IF=$(../echoIF.sh $1)
IF="eth0"

sudo tc qdisc del dev $IF root netem
sudo tc -s qdisc
