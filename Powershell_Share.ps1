import-module smbaccess
import-module smbwitness

function NewShare {
    $ShareName = Read-Host "Share Name: "   
    $SharePath = Read-Host "Share Path: "
    $UserAccount = <USERNAME>
    new-smbshare -Name $ShareName -Path $SharePath
    Grant-SmbShareAccess -Name $ShareName -AccountName $UserAccount -AccessRight Full
}

function menu {
$stepChoice = read-host "
1. Create New Share
2. Exit
"
}
switch($stepChoice)
{
    1{NewShare}
    2{exit}
}
menu