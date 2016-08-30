<#
.SYNOPSIS
Pulls computer info from local or remote comptuers
.EXAMPLE
computer_info.ps1 -computerName localhost
.EXAMPLE
computer_info -comp one,two,three
.EXAMPLE
get-content names.txt | computer_info
.PARAMETER computername

write-debug used for debug
use -debug during program

out-gridview to bring output to GUI interface

#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$True)]
    [string[]]$computername,
    [string]$errorLogPath = 'C:\oops.txt'
)
PROCESS {
    foreach ($computer in $computername) {
        Write-Verbose "About to query $computer"
        try {
            $everything_ok = $true
            $os = Get-WmiObject -class win32_operatingsystem -computername $computer -ErrorVariable MyErr -ErrorAction Stop
        } catch {
            $everything_ok = $false
            Write-Verbose "$computer failed.  Logging to $errorLogPath"
            Write-Verbose "Error was $MyErr"
            $computer | out-file $errorLogPath -Append
        }
        if ($everything_ok) {
            $bios = Get-WmiObject -Class win32_bios -ComputerName $computer
            $cs = Get-WmiObject -Class win32_computersystem -ComputerName $computer
            $props = @{'ComputerName'=$computer;
                   'OSVersion'=$os.version;
                   'SPVersion'=$os.servicepackmajorversion;
                   'BIOSSerial'=$bios.serialnumber;
                   'Model'=$cs.model;
                   'Manufacturer'=$cs.manufacturer}
            $obj = New-Object -TypeName PSObject -Property $props
            write-output $obj
        }
    }
}