$SearchBase = <INSERTOUPATH>
$NewPassword = read-host "Enter the new password to set: "
$ChangeAtLogon = Read-Host "Force change password at next logon (y/n): "
#
#
foreach ($i in get-aduser -filter * -searchbase $SearchBase) {
    Set-ADAccountPassword -NewPassword (ConvertTo-SecureString -String $NewPassword -AsPlainText -force) -Identity $i
    Enable-ADAccount -Identity $i
    if ($ChangeAtLogon -eq 'y') {
        set-aduser -Identity $i -ChangePasswordAtLogon $true
        }
    }
