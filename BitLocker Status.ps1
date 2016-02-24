$HardDisks = gwmi win32_diskdrive | ?{$_.interfacetype -ne "USB"} | %{gwmi -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID=`"$($_.DeviceID.replace('\','\\'))`"} WHERE AssocClass = Win32_DiskDriveToDiskPartition"} |  %{gwmi -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID=`"$($_.DeviceID)`"} WHERE AssocClass = Win32_LogicalDiskToPartition"} | %{$_.deviceid}
Write-Output $HardDisks > C:\Temp\test.txt 
$Output = foreach ($i in Get-Content C:\Temp\test.txt)
            {manage-bde -status $i} 
write-output $Output > C:\Temp\BDEoutput.txt