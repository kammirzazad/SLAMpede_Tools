#!/bin/bash

COUNT="10"
IP=$(../IP/echoWIP.sh $1)

#ping $IP -q -c $COUNT
ping $IP -c $COUNT
