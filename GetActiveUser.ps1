import-module activedirectory 
$domain = $env:userdnsdomain 
$DaysInactive = 90 
$time = (Get-Date).Adddays(-($DaysInactive))
 
# Get all AD User with lastLogonTimestamp less than our time and set to enable and Output Name and lastLogonTimestamp into CSV
Get-ADUser -Filter {LastLogonTimeStamp -gt $time -and enabled -eq $true} -Properties LastLogonTimeStamp | select-object Name,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}} | export-csv C:\Temp\Active_Users.csv -notypeinformation
