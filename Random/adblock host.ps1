#Requires -RunAsAdministrator
(Invoke-WebRequest -Uri http://winhelp2002.mvps.org/hosts.txt).Content > C:\windows\system32\drivers\etc\HOSTS