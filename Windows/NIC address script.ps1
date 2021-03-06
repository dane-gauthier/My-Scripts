function DHCP {
    Import-Module netadapter

    $interfacename = Read-Host 'Wi-Fi or Ethernet: '
    $netadapter = Get-NetAdapter -Name $interfacename

    $netadapter | Set-NetIPInterface -Dhcp Enabled
    $netadapter | Set-DnsClientServerAddress -ResetServerAddresses
}

function Static {
    $interfacename = Read-Host 'Wi-Fi or Ethernet: '
    $netadapter = Get-NetAdapter -Name $interfacename
    $ipaddress = Read-Host 'IP address: '
    $PrefixLength = Read-Host 'Prefix Length: '
    $DefaultGateway = Read-Host 'Default Gateway: '
    $dnsserver = Read-Host 'DNS Server: '

    import-module netadapter
    $netadapter
    $netadapter | Set-NetIPInterface -Dhcp Disabled
    $netadapter | New-NetIPAddress -AddressFamily IPv4 -IPAddress $ipaddress -PrefixLength $PrefixLength -DefaultGateway $DefaultGateway
    Set-DnsClientServerAddress -InterfaceAlias $interfacename -ServerAddresses $dnsserver
}

$stepChoice = read-host '1 for DHCP or 2 for Static '
switch($stepChoice)
{
    1{DHCP}
    2{Static}
}