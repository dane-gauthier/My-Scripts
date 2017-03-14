$SearchBase = read-host 'OU path to users'
$UseDefaultPassword = read-host 'Do you want to use the default password of Password1? (y/n)'
if ($UseDefaultPassword -eq 'y') {
    $NewPassword = 'Password1'
}
else {
    $NewPassword = read-host "Enter the new password to set"
}
$ChangeAtLogon = Read-Host "Force change password at next logon (y/n)"
#
#
foreach ($i in get-aduser -filter * -searchbase $SearchBase) {
    Set-ADAccountPassword -NewPassword (ConvertTo-SecureString -String $NewPassword -AsPlainText -force) -Identity $i
    Enable-ADAccount -Identity $i
    if ($ChangeAtLogon -eq 'y') {
        set-aduser -Identity $i -ChangePasswordAtLogon $true
        }
    }
