#!/bin/bash

cd /proc/sys/net/core/
echo 350000 > wmem_default
echo 500000 > wmem_max
