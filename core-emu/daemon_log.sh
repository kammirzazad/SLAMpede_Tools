#!/bin/bash

LOG=/var/log/core-daemon.log

if [ "$1" == "show" ]
then
	cat $LOG
elif [ "$1" == "erase" ]
then
	sudo cp /dev/null $LOG
else
	echo unknown command $1
fi
