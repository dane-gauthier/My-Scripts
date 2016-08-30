#exporting creds to xml file
$path = "C:\Users\$USER\Desktop\cred.xml"
$cred = Get-Credential
$cred | Export-Clixml -Path $path

#importing credentials
$path = "C:\Users\$USER\Desktop\cred.xml"
$cred = Import-Clixml -Path $path
$cred