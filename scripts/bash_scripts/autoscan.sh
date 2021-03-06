#!/bin/sh
#AUTOSCAN
cat << "EOF"
    :::     :::    ::: ::::::::::: ::::::::   ::::::::   ::::::::      :::     ::::    ::: 
  :+: :+:   :+:    :+:     :+:    :+:    :+: :+:    :+: :+:    :+:   :+: :+:   :+:+:   :+: 
 +:+   +:+  +:+    +:+     +:+    +:+    +:+ +:+        +:+         +:+   +:+  :+:+:+  +:+ 
+#++:++#++: +#+    +:+     +#+    +#+    +:+ +#++:++#++ +#+        +#++:++#++: +#+ +:+ +#+ 
+#+     +#+ +#+    +#+     +#+    +#+    +#+        +#+ +#+        +#+     +#+ +#+  +#+#+# 
#+#     #+# #+#    #+#     #+#    #+#    #+# #+#    #+# #+#    #+# #+#     #+# #+#   #+#+# 
###     ###  ########      ###     ########   ########   ########  ###     ### ###    #### 
EOF
echo 
echo
START()
{
read -p "Inserisci il nome che vuoi dare al progetto: " PROJECT
read -p "Inserisci la cartella dove vuoi salvare i risultati: " PATH 
if [ ! -d $PATH/$PROJECT ]; then
  /usr/bin/mkdir -p $PATH/$PROJECT;
fi

}

SCAN()
{
read -p  "Inserisci il CIDR della rete che vuoi scansionare: " CIDR

/usr/bin/nmap -n -sn $CIDR -oG - | /usr/bin/awk '/Up$/{print $2}' >> $PATH/$PROJECT/$PROJECT.txt &&
/usr/bin/nmap -A -T5  -iL $PATH/$PROJECT/$PROJECT.txt > NMAPoutput-txt && 
/usr/bin/python3 /root/intelspy/intelspy.py -s 5 -p $PROJECT -w $PATH/$PROJECT $CIDR &&

echo "Scansione eseguita, i file sono stati salvati in $PATH/$PROJECT"
}
START
SCAN
echo
while true ; do
    read -p  "Vuoi scansionare una nuova rete? (S/N) " REPLY
    case $REPLY in
        [Nn]* ) break;;
        
        [Ss]* ) while true; do
        		        read -p  "Vuoi utilizzare lo stesso progetto? (S/N) " REPLY2
        		        case $REPLY2 in
        			        [Ss]* ) SCAN;;
        			        [Nn]* ) START;;
                      * ) echo "Rispondi Si o No";;
                    esac
                done
        #* ) echo "Rispondi Si o No";;
    esac
done
exit
