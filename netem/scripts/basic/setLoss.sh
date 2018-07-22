#!/bin/sh

IF="lo"
LOSS="0.1"

tc qdisc change dev $IF root netem loss ${LOSS}%
