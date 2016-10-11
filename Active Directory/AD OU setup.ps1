import-module ActiveDirectory

$domainName = (read-host 'Name of domain, without ending suffix (.local, .com, etc...)').ToUpper()
$domainSuffix = read-host 'Suffix of Full domain (ex. .com, .local, .tld, etc..)'

New-ADObject -type OrganizationalUnit -name $domainName -path "dc=$domainName,dc=$domainSuffix"
New-ADObject -type OrganizationalUnit -name 'Workstations' -path "OU=$domainName,dc=$domainName,dc=$domainSuffix"
New-ADObject -type OrganizationalUnit -name 'Users' -path "OU=$domainName,dc=$domainName,dc=$domainSuffix"
New-ADObject -type OrganizationalUnit -name 'Security Groups' -path "OU=$domainName,dc=$domainName,dc=$domainSuffix"
New-ADObject -type OrganizationalUnit -name 'Member Servers' -path "OU=$domainName,dc=$domainName,dc=$domainSuffix"
New-ADObject -type OrganizationalUnit -name 'Admin Accounts' -path "OU=$domainName,dc=$domainName,dc=$domainSuffix"
New-ADObject -type OrganizationalUnit -name 'Service Accounts' -path "OU=$domainName,dc=$domainName,dc=$domainSuffix"
New-ADObject -type OrganizationalUnit -name 'Distribution Groups' -path "OU=$domainName,dc=$domainName,dc=$domainSuffix"

<#Security Groups
New-ADgroup -GroupCategory security -GroupScope Global -Name $name -Path "OU=Security Groups,OU=$domainName,DC=$domainName,DC=$domainSuffix"
#>

#Users Folder Groups
New-ADObject -type OrganizationalUnit -name 'Disabled Users' -Path "OU=$domainName,dc=$domainName,dc=$domainSuffix"
