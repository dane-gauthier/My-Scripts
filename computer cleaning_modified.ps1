param ([string]$TargetComputer)
if ($targetcomputer -eq "")
{
   $TargetComputer = "127.0.0.1" 
}
$ErrorLog = "C:\Temp\ScriptErrors.txt"

Remove-Variable temp,cbs,reportqueue,patchmanagement,usertemp

try {
$temp = gci "\\$TargetComputer\C$\Windows\Temp\*" -Recurse
$count = $temp.Count 
$i=1
foreach ($file in $temp) {
    write-output "Deleting $i of $count in Temp Folder"
    remove-item $file -Force -Recurse -Verbose -ErrorAction Stop
    $i++
}

$CBS = gci \\$TargetComputer\C$\Windows\Logs\CBS\* -Recurse
$count = $CBS.Count 
$i=1
foreach ($file in $CBS) {
    write-output "Deleting $i of $count in CBS Folder"
    remove-item $file -Force -Recurse -Verbose -ErrorAction Stop
    $i++
}

$ReportQueue = gci \\$TargetComputer\C$\ProgramData\Microsoft\Windows\WER\ReportQueue\* -Recurse
$count = $ReportQueue.Count 
$i=1
foreach ($file in $ReportQueue) { 
    write-output "Deleting $i of $count in ReportQueue"
    remove-item $file -Force -Recurse -Verbose -ErrorAction Stop
    $i++
}

$PatchManagement = gci "\\$TargetComputer\C$\Program Files (x86)\N-Able Technologies\PatchManagement\archive\*"
$count = $PatchManagement.Count 
$i=1
foreach ($file in $PatchManagement) {
    Write-Output "Deleting $i in $count in PatchManagement folder"
    Remove-Item $file -Force -Recurse -Verbose -ErrorAction Stop
    $i++
}

$UserTemp = gci "\\$TargetComputer\C$\Users\*\AppData\Local\Temp\* -recurse"
$count = $UserTemp.Count 
$i=1
foreach ($file in $UserTemp) {
    Write-Output "Deleting $i in $count in User Temp Folder"
    Remove-Item $file -Force -recurse -verbose -erroraction Stop
    $i++
}
}
catch {
    Write-Output $_ | Add-Content -Path C:\Temp\asdf.txt
}