#!/bin/bash

COUNT="10"
IP=$(../IP/echoIP.sh $1)

ping $IP -q -c $COUNT
