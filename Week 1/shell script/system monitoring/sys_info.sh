#!/bin/bash

echo "OS Type"
uname -o

echo "OS Name and version"
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME'

echo "Architecture"
uname -m

echo "Kernel Release"
uname -r

echo "Hostname"
hostname

echo "Private IP"
hostname -i

echo "Public IP"
curl -s ipecho.net/plain

echo "Nameservers"
cat /etc/resolv.conf | sed '1 d'

echo "Logged In users"
whoami

echo "Check RAM and SWAP Usages"
free -h

echo "Check Disk Usages"
df -h

echo "Uptime"

uptime | awk '{print $1,$2,$3}'
uptime | awk '{print $3,$4}' | cut -f1 -d,

echo "Load Average"
uptime | awk '{print $6,$7,$8,$9,$10}'
top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}'