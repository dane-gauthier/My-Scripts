#Requires -RunAsAdministrator

#Variables
$FirewallStatus = read-host 'Disable firewall? (y/n)'
$RDPStatus = read-host 'Enable RDP? (y/n)'
$ComputerName = read-host 'New Computer Name? (y/n)'
$NetAddressChange = read-host 'Set Static IP? (y/n)'

#Main Script
if ($FirewallStatus -eq 'y') {
    Set-NetFirewallProfile -profile domain,private,public -Enabled False
}
if ($RDPStatus -eq 'y') {
    set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
    set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1 
}
if ($ComputerName -eq 'y') {
    $NewName = read-host 'Enter the new computer name'
    Rename-Computer -NewName "$NewName"
}
if ($NetAddressChange -eq 'y') {
    import-module netIndex
    Get-netIndex
    $netIndex = read-host 'Enter Adapter Index #'
    $NewIP = read-host 'New IP Address'
    $NewPrefix = read-host 'New prefix length'
    $NewGateway = read-host 'New default gateway'
    get-netIndex -ifIndex $netIndex | New-NetIPAddress -AddressFamily IPv4 -IPAddress $NewIP -PrefixLength $NewPrefix -type Unicast -DefaultGateway $NewGateway
    [array]$DNSServers = read-host 'Enter dns servers separated with a comma'
    Set-DnsClientServerAddress -InterfaceIndex $netIndex -ServerAddresses $DNSServers
}