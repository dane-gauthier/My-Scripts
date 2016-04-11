$SearchBase = <INSERTOUPATH>
$NewPassword = read-host "Enter the new password to set: "
#
#
foreach ($i in get-aduser -filter * -searchbase $SearchBase) {
    Set-ADAccountPassword -NewPassword (ConvertTo-SecureString -String $NewPassword -AsPlainText -force) -Identity $i
    Enable-ADAccount -Identity $i
    }
