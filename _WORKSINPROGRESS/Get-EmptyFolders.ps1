$BaseDir = read-host "Base Directory to scan"

$a = gci $BaseDir -r | ? {$_.PSIsContainer -eq $True} | ? {$_.GetFiles().Count -eq 0} | select FullName
Write-Output $a.FullName

$Removal = read-host "Do you want to remove the empty folders? (Press y to continue)"

if ($Removal -eq "y") {
	$a | remove-item
	}
