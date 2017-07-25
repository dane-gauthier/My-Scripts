$DomainName = Read-Host 'Enter the domain you are joining'

$cred = New-Object System.Management.Automation.PsCredential("domain\useraccountwithjoinpermissions", (ConvertTo-SecureString "useraccountpassword" -AsPlainText -Force))
Add-Computer -DomainName $DomainName -Credential $cred
Restart-Computer