#!/bin/sh

read -p "Insert the domain or the site you want to enumerate: " target
mkdir $target
cd $target
wget $target
sldomain= echo $target  | awk -F[/.] '{print $2}'
tldomain= echo $target  | awk -F[/.] '{print $3}'
grep "href=" index.html | grep "\.$sldomain" | grep -v "www\.$sldomain\.$tldomain" | awk -F "http://" '{print $2}' | cut -d "/" -f 1 > list.txt

for url in $(cat list.txt); do host $url; done > ip_domain.txt 
for url in $(cat ip_domain.txt); do host $url; done | grep "has address" | cut -d " " -f 4 | sort -u > unique_ip.txt
