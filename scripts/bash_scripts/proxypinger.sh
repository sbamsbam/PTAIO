#!/bin/sh

: ${1?"Usage: $0 ip subnet to scan. eg '192.168.1.'"}

subnet=$1
for addr in `seq 0 1 255 `; do
#   ( echo $subnet$addr)
( proxychains4 -f /etc/proxychains.conf ping -c 3 -t 5 $subnet$addr > /dev/null && echo $subnet$addr is Alive ) &
done 
