#---Variables---
$VBoxManage = 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe'
$VMName = read-host 'Name of new Virtual Machine'

cmd /c "$VBoxManage createvm $VMName"