Add-PSSnapin Vmware.VimAutomation.Core
#----------------------------------------------------
#Connect to vcenter server  
connect-viserver <VCENTER SERVER> 
#Import vm name from csv file  
Import-Csv C:\users\<USERNAME>\servers.csv |  
foreach {  
    $strNewVMName = $_.name  
      
    #Update VMtools without reboot  
    Get-VM $strNewVMName | Update-Tools –NoReboot  
   write-host "Updated $strNewVMName ------ "  
       
    $report += $strNewVMName  
} 