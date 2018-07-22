#!/bin/bash

GENERATOR=./synNetConfig.py
PATH2CONFIG=~/Documents/RIoT_omnetpp/netConfigs

CONFIGS=($(ls $PATH2CONFIG/*.ip.json))

for CONFIG in "${CONFIGS[@]}"
do
	$GENERATOR $CONFIG
done
