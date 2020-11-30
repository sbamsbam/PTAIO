#!/bin/bash

while IFS= read -r line;
do
ip=$(dig +short $line | tail -n1) 
echo $line $ip
done < "$1"

