import-module netadapter
function DHCP {

$interfacename = Read-Host 'vEthernet (External Wireless) or vEthernet (External Wired): '
$netadapter = Get-NetAdapter -Name $interfacename

$netadapter | Set-NetIPInterface -Dhcp Enabled
$netadapter | Set-DnsClientServerAddress -ResetServerAddresses

sleep 3
menu
}

function Static {
$interfacename = Read-Host 'Wi-Fi or Ethernet: '
$netadapter = Get-NetAdapter -Name $interfacename
$ipaddress = Read-Host 'IP address: '
$PrefixLength = Read-Host 'Prefix Length: '
$DefaultGateway = Read-Host 'Default Gateway: '
$dnsserver = Read-Host 'DNS Server: '
$dnsserver2 = read-host 'DNS Server 2: '

$netadapter
$netadapter | Set-NetIPInterface -Dhcp Disabled
$netadapter | New-NetIPAddress -AddressFamily IPv4 -IPAddress $ipaddress -PrefixLength $PrefixLength -DefaultGateway $DefaultGateway > null0
Set-DnsClientServerAddress -InterfaceAlias $interfacename -ServerAddresses {$dnsserver, $dnsserver2} > null0

sleep 3
menu
}

function menu{
$stepChoice = read-host '
1 for DHCP
2 for Static 
3 to exit
'
switch($stepChoice)
{
    1{DHCP}
    2{Static}
    3{exit}
}
}

menu