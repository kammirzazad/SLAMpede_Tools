#!/bin/bash

sudo tc qdisc del dev eth0 root handle 1: prio
