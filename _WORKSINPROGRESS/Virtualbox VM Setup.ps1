#---Variables---
$VBoxManage = 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe'
$VMName = read-host 'Name of new Virtual Machine'
$VMType = read-host 'Operating System Type'

#region Main Script
& $VBoxManage "createvm --name $VMName"

#endregion