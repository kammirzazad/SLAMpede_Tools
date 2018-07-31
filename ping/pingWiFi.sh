#!/bin/bash

COUNT="10"
IP=$(../ip/echoWIP.sh $1)

#ping $IP -q -c $COUNT
ping $IP -c $COUNT
