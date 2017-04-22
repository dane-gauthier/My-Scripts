$cred = New-Object System.Management.Automation.PsCredential("domain\useraccountwithjoinpermissions", (ConvertTo-SecureString "useraccountpassword" -AsPlainText -Force))
Add-Computer -DomainName "your.domain.here" -Credential $cred
Restart-Computer