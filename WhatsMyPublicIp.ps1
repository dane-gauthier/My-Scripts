$ip = Invoke-WebRequest -URI "http://icanhazip.com"
write-output "Your Public IP address is: $ip"
pause
