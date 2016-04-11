$SearchBase = <INSERTOUPATH>
#
#
foreach ($i in get-aduser -filter * -searchbase $SearchBase) {
    Set-ADAccountPassword -NewPassword (ConvertTo-SecureString -String "rl1018" -AsPlainText -force) -Identity $i
    Enable-ADAccount -Identity $i
    }