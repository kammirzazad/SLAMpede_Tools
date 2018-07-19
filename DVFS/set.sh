#!/bin/bash

cd /sys/devices/system/cpu/cpufreq/policy0/

echo userspace > scaling_governor
echo 1200000 > scaling_setspeed

