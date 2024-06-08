#!/bin/bash

# Set thresholds
MAX_CPU_USAGE=80
MAX_DISK_USAGE=90
MAX_MEM_USAGE=70

# Monitor CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Monitor Disk usage
DISK_USAGE=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')

# Monitor Memory usage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Check if any threshold is breached
if [ $(echo "$CPU_USAGE > $MAX_CPU_USAGE" | bc) -ne 0 ]; then
  echo "CPU usage is above threshold: $CPU_USAGE%"
elif [ $(echo "$DISK_USAGE > $MAX_DISK_USAGE" | bc) -ne 0 ]; then
  echo "Disk usage is above threshold: $DISK_USAGE%"
elif [ $(echo "$MEM_USAGE > $MAX_MEM_USAGE" | bc) -ne 0 ]; then
  echo "Memory usage is above threshold: $MEM_USAGE%"
else
  echo "System is running within the set thresholds."
fi
