function ADDeploy {
    Import-Module ADDSDeployment
    $DomainName = read-host 'Name of domain including suffix (contoso.com)'
    $DomainNetBiosName = read-host 'Domain NetBios Name (CONTOSO)'
    Install-ADDSForest -CreateDNSDelegation:$false `
    -DatabasePath "C:\WINDOWS\NTDS" `
    -DomainMode "Win2012R2" `
    -DomainName $DomainName `
    -DomainNetbiosName $DomainNetBiosName `
    -ForestMode "Win2012R2" `
    -InstallDNS:$true `
    -LogPat "C:\Windows\NTDS"
    -NoRebootOnCompletion:$false `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true
}





Get-WindowsFeature AD-Domain-Services

if ((Get-WindowsFeature AD-Domain-Services).InstallState -eq 'Insatlled') {
    Write-Host 'ADDS is already installed.  Proceeding to domain creation'
    ADDeploy
}
else {
    Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
    Pause
    ADDeploy
}

