#!/bin/bash

IF="eth0"
RANGE="0.227"
AVERAGE="6"

ACTION="add"

sudo tc qdisc $ACTION dev $IF root netem limit 2001 delay ${AVERAGE}ms ${RANGE}ms distribution logisticL
