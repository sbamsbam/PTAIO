#!/bin/bash

while IFS= read -r line;
do
hostname=$( nslookup $line | awk '{print$4}' | sed 's/.$//')
echo $line $hostname
done < "$1"
