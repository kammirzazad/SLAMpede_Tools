#!/bin/bash

sudo systemctl start systemd-timesyncd
sudo timedatectl set-ntp 1
