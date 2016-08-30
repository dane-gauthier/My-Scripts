Set-Location '' #CHANGE THIS BEFORE RUNNING SCRIPT ON MAIN LOCATION
#Notes
<#
set owner = icacls FILE/DIRECTORY /setowner *SID /t
disable inheritance = icacls FILE/DIRECTORY /inheritance:d
remove domain users access = icacls FILE/DIRECTORY /remove:g *S-1-5-21-90266726-318319577-1846434929-513 /t
give modify permissions = icacls FILE/DIRECTORY /grant *SID:m /t
#>
#------------------------------------------------------------

$users = gci -Directory | select Name

$count=$users.Count
$i=1

foreach ($user in $users.Name) {
    Write-Output "Processing $i of $count"
    cmd /c "icacls $user /setowner $user /t /c"
    cmd /c "icacls $user /inheritance:d"
    cmd /c "icacls $user /remove:g *S-1-5-21-90266726-318319577-1846434929-513 /t"
    cmd /c "icacls $user /grant $user`:(OI)(CI)(M) /c" 
    $i++
    }