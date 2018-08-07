#!/bin/bash

cd /proc/sys/net/core/
echo 250000 > wmem_default
echo 500000 > wmem_max
