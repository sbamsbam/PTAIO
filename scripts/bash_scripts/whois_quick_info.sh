#!/bin/bash

while IFS= read -r line;
do
hostname=$( whois $line | egrep 'country|descr' )
echo $line\n$hostname\n
done < "$1"
