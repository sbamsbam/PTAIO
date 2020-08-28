#!/bin/sh
#This part of the script take a snapshot of every active web server
read -p "Insert target an port you want to scan " target port
nmap -A -p $port --open $target -oG nmap-scan-$target

cat nmap-scan-$target | grep $port | grep -v "Nmap" 

for ip in $(cat nmap-scan-$target | grep $port | grep -v "Nmap"| awk '{print $2}'); do cutycapt --url=$ip --out=$ip.png; done 

# this part of the script examine the scan results through HTML.

echo "<HTML><BODY><BR>" > web.HTML
ls -1 *.png | awk -F : ' {print $1":\n<BR><IMG SRC=\""S1""S2"\" width=600><BR>"}' >> web.html
