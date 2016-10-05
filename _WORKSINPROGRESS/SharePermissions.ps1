$ShareName = (Get-SmbShare).name
$SharePath = (Get-SmbShare).Path

foreach ($name in $SharePath) {
    $ShareAccess = Get-SmbShareAccess -Name $ShareName

    $SMBName = $ShareAccess.Name
    $SMBAccountName = $ShareAccess.AccountName
    $SMBRights = $ShareAccess.AccessRight

    #Outputs
    Write-host "
    Name = $SMBName
    Account Name = $SMBAccountName
    Rights = $SMBRights
    "
    }