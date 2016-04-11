# ********************************************************************************
#
# Script Name: DangItBobby.ps1
# Version: 1.0.0
# Author: bluesoul <https://bluesoul.me>
# Date: 2016-04-06
# Applies to: Domain Environments
#
# Description: This script searches for a specific, logged on user on all or 
# specific Computers by checking the process "explorer.exe" and its owner. It 
# then enumerates the list and lets you choose a PC to disable the NIC on. Useful
# as a last-resort script to stop a ransomware infection in-progress.
#
# ********************************************************************************

#Set variables
$progress = 0

#Get Admin Credentials
Function Get-Login {
Clear-Host
Write-Host "Please provide admin credentials (for example DOMAIN\admin.user and your password)"
$Global:Credential = Get-Credential
}
Get-Login

#Get Username to search for
Function Get-Username {
	Clear-Host
	$Global:Username = Read-Host "Enter username you want to search for"
	if ($Username -eq $null){
		Write-Host "Username cannot be blank, please re-enter username!"
		Get-Username
	}
	$UserCheck = Get-ADUser $Username
	if ($UserCheck -eq $null){
		Write-Host "Invalid username, please verify this is the logon id for the account!"
		Get-Username
	}
}
Get-Username

#Get Computername Prefix for large environments
Function Get-Prefix {
	Clear-Host
	$Global:Prefix = Read-Host "Enter as much of the computer name (prefix) as you can to shorten the search time or press Enter to scan all Computers"
	
	# Add the * programmatically so it doesn't bark about no * or $.
	$Global:Prefix += "*"
	Clear-Host
}
Get-Prefix

#Start search
$computers = Get-ADComputer -Filter {Enabled -eq 'true' -and SamAccountName -like $Prefix}
$CompCount = $Computers.Count
Write-Host "Searching for $Username on $Prefix on $CompCount Computers`n"

#Create mutable array for catching computers that match.
$Global:HitsX = @()
$Global:Hits = {$HitsX}.Invoke()

#Start main foreach loop, search processes on all computers
foreach ($comp in $computers){
	$Computer = $comp.Name
	$Reply = $null
  	$Reply = test-connection $Computer -count 1 -quiet
  	if($Reply -eq 'True'){
		if($Computer -eq $env:COMPUTERNAME){
			#Get explorer.exe processes without credentials parameter if the query is executed on the localhost
			$proc = gwmi win32_process -ErrorAction SilentlyContinue -computer $Computer -Filter "Name = 'explorer.exe'"
		}
		else{
			#Get explorer.exe processes with credentials for remote hosts
			$proc = gwmi win32_process -ErrorAction SilentlyContinue -Credential $Credential -computer $Computer -Filter "Name = 'explorer.exe'"
		}			
			#If $proc is empty return msg else search collection of processes for username
		if([string]::IsNullOrEmpty($proc)){
			$progress++
			write-host "Failed to check $Computer!"
		}
		else{	
			$progress++			
			ForEach ($p in $proc) {				
				$temp = ($p.GetOwner()).User
				Write-Progress -activity "Working..." -status "Status: $progress of $CompCount Computers checked" -PercentComplete (($progress/$Computers.Count)*100)
				if ($temp -eq $Username){
				write-host "$Username is logged on $Computer"
				$Global:Hits.Add($Computer)
				}
			}
		}	
	}
}
write-host "Search done!"

If ($Hits.Count -gt 1) { 
	Clear-Host
	write-host "Select a PC to Inspect"
	$i = 0
	foreach ($hit in $Hits) {
	write-host "[$i] $hit"	
	$i++
	}
	$selection = Read-Host "Select"
	Get-WMIObject -Class Win32_NetworkAdapterConfiguration -ComputerName $Hits[$selection] -Credential $Credential
	$index = Read-Host "Index value of NIC to disable, Ctrl+C to cancel"
	$wmi = Get-WMIObject -Class Win32_NetworkAdapter -filter "Index LIKE $index" -ComputerName $Hits[$selection] -Credential $Credential
	Write-Host "Processing. You may see a failed RPC call message appear if this is the only NIC with an actual network connection. That indicates the machine wasn't available to return a status message and thus was successful."
	$wmi.disable()
	Write-Host "Disabled!"
}
ElseIf ($Hits.Count -eq 1) {
	$Computer = $Hits[0]
	Get-WMIObject -Class Win32_NetworkAdapterConfiguration -ComputerName $Computer -Credential $Credential
	$index = Read-Host "Index value of NIC to disable on $Computer, Ctrl+C to cancel"
	$wmi = Get-WMIObject -Class Win32_NetworkAdapter -filter "Index LIKE $index" -ComputerName $Hits[0] -Credential $Credential
	Write-Host "Processing. You may see a failed RPC call message appear if this is the only NIC with an actual network connection. That indicates the machine wasn't available to return a status message and thus was successful."
	$wmi.disable()
	Write-Host "Disabled!"
}
Else { Write-Host "Not logged on to any machine searched for." }
Else { Write-Host "Not logged on to any machine searched for." }