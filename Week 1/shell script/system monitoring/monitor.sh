#!/bin/bash

echo "Date"
date

echo "Uptime"
uptime

# Monitor CPU usage
top -b -n1 | grep "Cpu(s)"

# Monitor memory usage
free -m | grep Mem

# Monitor disk usage
df -h | grep /dev/sda1

# Monitor network usage
iftop -n -P

echo "Network Usage"
ip a
