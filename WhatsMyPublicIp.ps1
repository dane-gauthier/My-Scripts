<#
Things to check for:
1. Network interface address
2. Ping to 8.8.8.8,8.8.4.4,4.2.2.1,4.2.2.2
3. Ping google.com
#>

$ip = Invoke-WebRequest -URI "http://icanhazip.com"
write-output "Your Public IP address is: $ip"
pause
