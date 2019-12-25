#!/bin/bash

echo starting gpsd for nem $1

gpsd -G -n -b $(cat persist/$1/var/run/gps.pty)
