# Parameters to include trace, resolution of root DNS servers, and run on remote computer
Param(
    #[Parameter(Mandatory=$true)]
    [array]$ComputerName = "$env:COMPUTERNAME",
    [switch]$IncludeTrace,
    [switch]$IncludeRootDNSServers,
    [switch]$RickRoll
)

$nwINFO = Get-WmiObject -ComputerName $ComputerName  Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -ne $null -and $_.Description -notmatch "VMware" -and $_.Description -ne "VirtualBox Host-Only Ethernet Adapter" -AND $_.Description -ne "Npcap Loopback Adapter" }

$nwServerName = $nwINFO.DNSHostName
$nwDescrip = $nwINFO.Description
$nwIPADDR = $nwINFO.IPAddress
$nwSUBNET = $nwINFO.IpSubnet
$nwGateWay = $nwINFO.DefaultIPGateway
$nwMacADD = $nwINFO.MACAddress
$nwDNS = $nwINFO.DNSServerSearchOrder
$nwOS = (get-wmiobject -Class Win32_OperatingSystem).Caption
$nwOSArchitecture = (Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture

#---------------------------------------------------------
#region Main output area
#Get Network Adapter info
Write-Host "
Operating System = $nwOS $nwOSArchitecture
Computername = $nwServerName
Description = $nwDescrip
IP address(es) = $nwIPADDR
Subnet Mask = $nwSUBNET
Default Gateway = $nwGateWay
MAC Address = $nwMacADD
DNS Server(s) = $nwDNS
"
#Public IP Fetch
$ip = Invoke-WebRequest -URI "http://icanhazip.com" -UseBasicParsing
Write-Host "Public IP address : $ip"
echo " "
Write-Host "Now testing pinging Internet-based DNS Servers and resolving several public URL names"
#Test Internet Pings
Test-Connection -ComputerName 8.8.8.8 -count 1 -Source $ComputerName
Test-Connection -ComputerName 8.8.4.4 -count 1 -Source $ComputerName
Test-Connection -ComputerName 4.2.2.1 -count 1 -Source $ComputerName
Test-Connection -ComputerName 4.2.2.2 -count 1 -Source $ComputerName
#Test Internet DNS Ping
Test-Connection -ComputerName google.com -count 1 -Source $ComputerName
Test-Connection -ComputerName facebook.com -count 1 -Source $ComputerName
Test-Connection -ComputerName yahoo.com -count 1 -Source $ComputerName
Test-Connection -ComputerName twitter.com -count 1 -Source $ComputerName
Test-Connection -ComputerName facebook.com -Count 1 -Source $ComputerName
echo ""

if ($IncludeRootDNSServers -eq $True) {
    #Test connection to root DNS servers
    write-host "Now resolving and testing connection to root DNS servers"
    test-connection -ComputerName a.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName b.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName c.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName d.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName e.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName f.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName g.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName h.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName i.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName j.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName k.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName l.root-servers.net -count 1 -Source $ComputerName
    test-connection -ComputerName m.root-servers.net -count 1 -Source $ComputerName
    echo " "
}

if ($IncludeTrace -eq $True) {
    #tracert to google's public address
    tracert google.com
    echo " "
}

if ($RickRoll -eq $true) {
    iex (New-Object Net.WebClient).DownloadString("http://bit.ly/e0Mw9w")
}

pause
#endregion