#requires -Version 2

function Get-Software
{
    param
    (
        [string]
        $DisplayName='*', 

        [string]
        $UninstallString='*',

        [string[]]
        $ComputerName 
    )

    [scriptblock]$code = 
    {

        param
        (
        [string]
        $DisplayName='*', 

        [string]
        $UninstallString='*'

        )
      $keys = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*', 
       'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    
      Get-ItemProperty -Path $keys | 
      Where-Object { $_.DisplayName } |
      Select-Object -Property DisplayName, DisplayVersion, UninstallString |
      Where-Object { $_.DisplayName -like $DisplayName } |
      Where-Object { $_.UninstallString -like $UninstallString }

    }
    if ($PSBoundParameters.ContainsKey('ComputerName'))
    {
    Invoke-Command -ScriptBlock $code -ComputerName $ComputerName -ArgumentList $DisplayName, $UninstallString
    }
    else
    {
        & $code -DisplayName $DisplayName -UninstallString $UninstallString
    }
}
function prompt 
{
  1..5 | ForEach-Object -Process {
    $frequency = Get-Random -Minimum 500 -Maximum 6000 
    $duration = Get-Random -Minimum 200 -Maximum 300 
    [Console]::Beep($frequency, $duration) 
  } 
}