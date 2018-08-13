# SLAMpede Tools

<p align="justify">
Applications/scripts in this repository target cluster of development boards in SLAM Lab at UT Austin named SLAMpede (named after [stampede](https://www.tacc.utexas.edu/systems/stampede)). This cluster consists of six Raspberry Pi 3 that run Linux-based Raspbian "Stretch" operating system and are connected to each other via Ethernet and Wi-Fi. Picture below shows the cluster with the nodes (blue0,orange0,pink0) and Ethernet switch at the bottom, (blue1,orange1,pink1) at the middle and AP on the top shelf.
</p>  

<div align="center">
  <img src="https://raw.githubusercontent.com/kammirzazad/SLAMpede_Tools/master/SLAMpede.jpeg" width="640px" />
  <p>Picture of SLAMpede</p>
</div>

Directories of this repository include:

## dvfs
Scripts for disabling on-demand governor and setting frequency to maximum   

## ip
For retriving IP addresses associated with Ethernet and Wi-Fi interfaces of cluster

## netem
Scripts for emulating specific network delays/losses. "netem/tables" includes code from [iproute2](http://www.linuxfoundation.org/collaborate/workgroups/networking/iproute2) package for generating distribution tables used by netEm.

## ntp
For disabling/enabling Network Time Protocol  (make sure to randomize system time afterwards)

## owping
An attempt to profile one-way delay between hosts, highly depends on the accuracy of the time synchronization scheme

## ping
Scripts for pinging hosts from each other over Ethernet of Wi-Fi

## realtime
To allow real-time tasks to use 100% of CPU time (default value is 95%)

## sockmem
To increase size of send buffers. (necessary for Wi-Fi sockets due to potential traffic congestion)

## wifi_test
To profile latency of sending various sizes of UDP packets over Wi-Fi
