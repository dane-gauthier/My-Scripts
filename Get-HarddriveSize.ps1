function Get-HardDriveSize
{
  <#
  param
  (
    $ComputerName,

    $Credential
  )
  #>

  # get calculated properties:
  $prop1 = @{
    Name = 'DriveLetter'
    Expression = { $_.DeviceID }
  }

  $prop2 = @{
    Name = 'Free(GB)'
    Expression = { [Math]::Round(($_.FreeSpace / 1GB),1) }
  }

  $prop3 = @{
    Name = 'Size(GB)'
    Expression = { [Math]::Round(($_.Size / 1GB),1) }
  }

  $prop4 = @{
    Name = 'Percent'
    Expression = { [Math]::Round(($_.Freespace * 100 / $_.Size),1) }
  }

  # get all hard drives
  Get-WmiObject -ClassName Win32_LogicalDisk @PSBoundParameters -Filter "DriveType=3" | 
  Select-Object -Property $prop1, $prop2, $prop3, $prop4

}
Get-HardDriveSize