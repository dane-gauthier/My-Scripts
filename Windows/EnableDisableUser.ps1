$user = read-host 'local user account name'

$choice = read-host '(e)nable or (d)isable account?'

if ($choice -eq "e") 
{
    $objUser = [ADSI]"WinNT://localhost/$user"
    $objUser.userflags = 512
    $objUser.setinfo()
    write-host "User $user has been enabled"
}

if ($choice -eq "d")
{
    $objUser = [ADSI]"WinNT://localhost/$user"
    $objUser.userflags = 2
    $objUser.setinfo()
    write-host "User $user has been disabled"
}