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
read -p "Inserisci la cartella dove vuoi salvare i risultati " PATH
if [ ! -d $PATH ]; then
  /usr/bin/mkdir -p $PATH;
fi
read -p "Inserisci il nome che vuoi dare al progetto: " PROJECT
read -p "Inserisci il CIDR della rete che vuoi scansionare: " CIDR

/usr/bin/nmap -n -sn $CIDR -oG - | /usr/bin/awk '/Up$/{print $2}' > $PATH/$PROJECT.txt &&

/usr/bin/python3 /AutoRecon/src/autorecon/autorecon.py -t $CIDR -o $PATH/$PROJECT.txt 

