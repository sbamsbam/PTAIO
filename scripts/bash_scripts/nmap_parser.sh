awk '/Nmap scan report/ { host=$NF } NF==4 && $2=="open" { print host, $2, $NF }' nmap-output.txt 
