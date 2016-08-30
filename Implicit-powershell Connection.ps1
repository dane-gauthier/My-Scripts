$server = Read-Host 'Server Name'

$Session = New-PSSession -ConfigurationName Microsoft.Powershell -ComputerName $server -Credential (Get-Credential) -Authentication Negotiate
Import-PSSession $Session