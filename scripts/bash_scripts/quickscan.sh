#!/bin/bash


function showUsage {
echo "$( basename ${0} ) - display script parameters values."
echo "Usage: quickscan.sh -t TARGET  -o OUTPUTFILE.TXT"
echo "Both parameters are required."
echo "The first parameter is the target ip address, CIDR or hostname."
echo "The second parameter must be the output file name."
exit 1
}

while getopts t:o: option
do
case "${option}"
in
t) TARGET=${OPTARG};;
o) OUTPUTFILE=${OPTARG};;
esac
done


if [[ ${#} -lt 1 || -z ${1} || -z ${2} ]]; then echo "Usage quickscan.sh -t TARGET -o OUTPUTFILE"; fi
exit 1
#if [[ ${TARGET} ! = ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then showUsage; fi


 extractPorts allPorts
nmap -p- --open -T5 -v -n ${TARGET} -oG ${OUTPUTFILE}
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

extractPorts ${OUTPUTFILE}

sudo nmap -p ${ports} -sC -sV ${TARGET} -oA ${OUTPUTFILE} 
