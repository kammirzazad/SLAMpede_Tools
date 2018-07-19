#!/bin/bash

IF="eth0"
RANGE="0.272"
AVERAGE="1.65"

ACTION="add"

sudo tc qdisc $ACTION dev $IF root netem limit 2001 delay ${AVERAGE}ms ${RANGE}ms distribution logisticH
