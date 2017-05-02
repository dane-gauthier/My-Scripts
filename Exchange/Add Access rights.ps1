$user = read-host 'User to add access to'
$access = read-host 'User to add to have access'

Get-Mailbox $user | add-mailboxpermission -accessrights FullAccess -AutoMapping $false -user $access