#!/bin/bash

sudo systemctl stop systemd-timesyncd
sudo timedatectl set-ntp 0
