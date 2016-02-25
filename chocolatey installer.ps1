Set-ExecutionPolicy -ExecutionPolicy Bypass
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))