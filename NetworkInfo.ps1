<#
Things to check for:
1. Network interface address
2. Ping to 8.8.8.8,8.8.4.4,4.2.2.1,4.2.2.2
3. Ping google.com and other websites
#>


# Whether or not to include a traceroute
Param(
[switch]$IncludeTrace
)

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
Write-Host "
Computername = $nwServerName
Description = $nwDescrip
IP address(es) = $nwIPADDR
Subnet Mask = $nwSUBNET
Default Gateway = $nwGateWay
MAC Address = $nwMacADD
DNS Server(s) = $nwDNS
"
#Public IP Fetch
$ip = Invoke-WebRequest -URI "http://icanhazip.com"
Write-Host "Public IP address : $ip"
echo " "
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
#Test connection to root DNS servers
write-host "Now resolving and testing connection to root DNS servers"
test-connection -ComputerName a.root-servers.net -count 1
test-connection -ComputerName b.root-servers.net -count 1
test-connection -ComputerName c.root-servers.net -count 1
test-connection -ComputerName d.root-servers.net -count 1
test-connection -ComputerName e.root-servers.net -count 1
test-connection -ComputerName f.root-servers.net -count 1
test-connection -ComputerName g.root-servers.net -count 1
test-connection -ComputerName h.root-servers.net -count 1
test-connection -ComputerName i.root-servers.net -count 1
test-connection -ComputerName j.root-servers.net -count 1
test-connection -ComputerName k.root-servers.net -count 1
test-connection -ComputerName l.root-servers.net -count 1
test-connection -ComputerName m.root-servers.net -count 1
echo " "

if ($IncludeTrace -eq $True) {
    #tracert to google's public address
    tracert google.com
    echo " "
}

pause
#endregion
