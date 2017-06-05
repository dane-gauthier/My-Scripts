Get-CASMailbox
$user = read-host 'User to get settings for'
Get-CASMailbox -identity $user
$Setting = read-host '(E)nable or (D)isable ActiveSync'
if ($Setting -eq 'E') {
    Get-CASMailbox -identity $user | Set-CASMailbox -ActiveSyncEnabled $true
}
if ($Setting -eq 'D') {
    Get-CASMailbox -identity $user | Set-CASMailbox -ActiveSyncEnabled $false    
}
