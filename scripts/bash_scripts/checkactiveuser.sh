#!/bin/bash

#launch againg passwd file
echo "insert passwd file path"
read passwd_path
cat $passwd_path | grep "home" | awk '{print $1 " with directory --> "   $6}'  FS=':'
