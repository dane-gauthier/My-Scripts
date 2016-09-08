<#
Things to check for:
1. Network interface address
2. Ping to 8.8.8.8,8.8.4.4,4.2.2.1,4.2.2.2
3. Ping google.com
#>

$nwINFO = Get-WmiObject -ComputerName $ENV:computername Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -ne $null -AND $_.Description -ne "VirtualBox Host-Only Ethernet Adapter" }

$nwServerName = $nwINFO.DNSHostName
$nwDescrip = $nwINFO.Description
$nwIPADDR = $nwINFO.IPAddress
$nwSUBNET = $nwINFO.IpSubnet
$nwGateWay = $nwINFO.DefaultIPGateway
$nwMacADD = $nwINFO.MACAddress
$nwDNS = $nwINFO.DNSServerSearchOrder

#---------------------------------------------------------
#region Main output area
#Get Network Adapter info
Write-Host
Write-Host "
Computername = $nwServerName
Description = $nwDescrip
IP address(es) = $nwIPADDR
Subnet Mask = $nwSUBNET
Default Gateway = $nwGateWay
MAC Address = $nwMacADD
DNS Server(s) = $nwDNS
"

Write-Host "Now testing pinging Internet-based DNS Servers and resolving several public URL names"
#Test Internet Pings
Test-Connection -ComputerName 8.8.8.8 -count 1
Test-Connection -ComputerName 8.8.4.4 -count 1
Test-Connection -ComputerName 4.2.2.1 -count 1
Test-Connection -ComputerName 4.2.2.2 -count 1
#Test Internet DNS Ping
Test-Connection -ComputerName google.com -count 1
Test-Connection -ComputerName facebook.com -count 1
Test-Connection -ComputerName yahoo.com -count 1
Test-Connection -ComputerName twitter.com -count 1
echo " "
#Public IP Fetch
$ip = Invoke-WebRequest -URI "http://icanhazip.com"
Write-Host "Public IP address : $ip"


exit
#endregion