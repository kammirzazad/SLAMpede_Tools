#!/bin/bash

IP=$(../ip/echoWIP.sh $1)

sudo ping $IP -q -i 0.001 -c 30000
