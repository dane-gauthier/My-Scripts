param ([string]$TargetComputer)
if ($targetcomputer -eq "")
{
   $TargetComputer = "127.0.0.1" 
}
$ErrorLog = "\\$TargetComputer\C$\Temp\CleaningErrors.txt"

$error.clear()
$error.Capacity = "10000"

try {remove-item \\$TargetComputer\C$\Windows\Temp\* -Recurse -Force -Verbose -ErrorAction continue}
catch {Write-Output $_ | Add-Content $ErrorLog}
try {remove-item \\$TargetComputer\C$\Windows\Logs\CBS\* -Force -Recurse -Verbose -ErrorAction continue}
catch {Write-Output $_ | Add-Content $ErrorLog}
try {remove-item \\$TargetComputer\C$\ProgramData\Microsoft\Windows\WER\ReportQueue\* -Recurse -Force -Verbose -ErrorAction continue}
catch {Write-Output $_ | Add-Content $ErrorLog}
try {remove-item "\\$TargetComputer\C$\Program Files (x86)\N-Able Technologies\PatchManagement\archive\*" -Force -Recurse -Verbose -ErrorAction continue}
catch {Write-Output $_ | Add-Content $ErrorLog}
try {Remove-Item "\\$TargetComputer\C$\Users\*\AppData\Local\Temp\*" -Force -Recurse -Verbose -ErrorAction continue}
catch {Write-Output $_ | Add-Content $ErrorLog}
try {
    stop-service wuauserv
    remove-item "\\$TargetComputer\C$\Windows\SoftwareDistribution\*" -recurse -force -verbose -ErrorAction Continue
    }
catch {Write-Output $_ | add-content $ErrorLog}
start-service wuauserv -Verbose