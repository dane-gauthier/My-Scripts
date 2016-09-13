# Permanently add C:\Program Files\Git\usr\bin to machine Path variable
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Git\usr\bin", "Machine")

# Generate the key and put into the your user profile .ssh directory
ssh-keygen -t rsa -b 4096 -C "your@email.com" -f $env:USERPROFILE\.ssh\id_rsa

# Copy the public key. Be sure to copy the .pub for the public key
Get-Content $env:USERPROFILE\.ssh\id_rsa.pub | clip

