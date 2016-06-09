$ip = Invoke-WebRequest -URI "http://icanhazip.com"
write-output $ip.Content