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



if ((Get-WmiObject -class Win32_OperatingSystem).Caption -notmatch 'Server 2012 R2') {
    write-host 'Sorry, incompatible OS'
    exit
}

Get-WindowsFeature AD-Domain-Services
Pause

if ((Get-WindowsFeature AD-Domain-Services).InstallState -eq 'Insatlled') {
    Write-Host 'ADDS is already installed.  Proceeding to domain creation'
    Pause
    ADDeploy
}
else {
    if ((read-host 'Do you want to install the role? (y/n)') -eq 'y') {
        Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
        Pause
        ADDeploy
    }
    else {
        exit
    }
}

