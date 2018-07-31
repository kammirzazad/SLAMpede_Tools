#!/bin/bash

COUNT="10"
IP=$(../ip/echoIP.sh $1)

ping $IP -q -c $COUNT
