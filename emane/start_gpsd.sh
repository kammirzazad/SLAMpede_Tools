#!/bin/bash

echo starting gpsd for nem $1

gpsd -G -n -b $(cat /var/run/gps.pty)
