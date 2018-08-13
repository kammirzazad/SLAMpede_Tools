#!/bin/bash

cd /proc/sys/net/ipv4/

echo -e '4096\t350000\t4194304' > tcp_wmem
echo -e '4096\t350000\t6291456' > tcp_rmem
