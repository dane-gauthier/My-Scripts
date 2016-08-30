import-module activedirectory

function ShowAdUsers {
#Show all AD users
Get-ADUser -filter * | select SamAccountName
menu
}
#
function ShowAdComputers {
#Show all AD computers
get-adcomputer -filter * | select name
menu
}
#
function NewAdUser {
#Adding AD User account
$SamAccountName = read-host 'Username: '
$firstname = read-host 'First Name: '
$lastname = read-host 'Last Name: '
$password = read-host -AsSecureString

new-aduser -SamAccountName $SamAccountName -GivenName $firstname -Surname $lastname -DisplayName "$firstname $lastname" -Path 'OU=Users,OU=SLAB,DC=ad,DC=secantlab,DC=com'
Set-ADAccountPassword $SamAccountName -NewPassword $password 
Enable-ADAccount $SamAccountName
menu
}
#
function DeleteAdUser {
$username = read-host 'Username to delete: '
Remove-ADUser $username
menu
}
#
function ChangePassword {
$username = read-host 'Account to reset: '
set-adaccountpassword -Identity $username -Reset
menu
}
#
function UserGroupMembership {
$username = read-host 'Username: '
Get-ADPrincipalGroupMembership $username | select name
menu
}
#
function AddGroupMember {
$username = read-host 'Username: '
$adgroup = read-host 'AD Group: '
Add-ADGroupMember -Identity "$adgroup" -Members $username
menu 
}
#
function menu {
$stepChoice = read-host "
1. Show AD Users
2. Show AD Computers
3. Create new AD User
4. Delete AD User
5. Change User Password
6. Get Users Group Membership
7. Add User to AD Group
0. Exit
"
switch($stepChoice)
{
    1{ShowAdUsers}
    2{ShowAdComputers}
    3{NewAdUser}
    4{DeleteAdUser}
    5{ChangePassword}
    6{UserGroupMembership}
    7{AddGroupMember}
    0{exit}

}
}
menu 