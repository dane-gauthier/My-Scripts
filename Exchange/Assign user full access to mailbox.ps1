$NewUser = read-host 'User account that you want to give permissions to'
$DestinationMailbox = read-host 'User account that you want permissions applied to'

Add-MailboxPermission -Identity $DestinationMailbox -User $NewUser -AccessRight FullAccess -InheritanceType All -Automapping $false 