@echo off
for /L %i in (1,1,255) do @ping -n 1 -w 200 192.168.1.%i > null && echo 192.168.1%i is up.
