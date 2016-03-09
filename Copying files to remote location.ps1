$computerName = Read-Host 'IP address: '
$username = "administrator"
$password = "thin client password"
$ServerUsername = "administrator"
$ServerPassword = "INSERTPASSWORDHERE"
$ServerShare = Read-host "Location of file: "
$file = Read-Host "Name of file to be copied: "

#------------------------------------------------------------------------
#Creating credential object
$SecurePassword = ConvertTo-SecureString -AsPlainText $password -force
$cred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $Username,$SecurePassword

#Creating credential object for Server
$SecurePassword2 = ConvertTo-SecureString -AsPlainText $ServerPassword -Force
$ServerCredentials = new-object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $ServerUsername,$SecurePassword2

#Create session
$Session = New-PSSession -ComputerName $computerName -Credential $cred

#Command to run
Invoke-Command -Session $Session -ScriptBlock {copy \\$ServerShare\$file -Credential $ServerCredentials -Destination \\$computerName\C$\Users\Public\Desktop\}
Invoke-Command -Session $Session -ScriptBlock {ewfmgr C: -Commit}

#Close session
Remove-PSSession -Session $Session