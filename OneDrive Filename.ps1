# test Example
# CheckIllegalCharacters -Location "c:\test"
# RemoveIllegalCharacters -Location "c:\test"
<#

.SYNOPSIS
This script will seek any file name errors that exist files that wouldn't be compatible with syncing in OneDrive.  Also has the ability to correct the file names.

.DESCRIPTION
Removes the following illegal characters from OneDrive Filenames: ~ " # % & * : < > ? / \ { | }.

.EXAMPLE
Import-module "OneDrive Filename.ps1"
CheckIllegalCharacters -Location "c:\test"
RemoveIllegalCharacters -Location "c:\test"



#>

function CheckIllegalCharacters ($Location)
{
    Write-Host Checking files in $Location, please wait...
    #Get all files and folders under the path specified
    $items = Get-ChildItem -Path $Location -Recurse
    foreach ($item in $items)
    {
        #Check if the item is a file or a folder or a Sub Folder
        if ($item.PSIsContainer) { $type = "Folder" }
        else { $type = "File" }
        
        #Report item has been found if verbose mode is selected
        if ($Verbose) { Write-Host Found a $type called $item.FullName }
        
        #Check length if item name is 128 characters or more  
        if ($item.Name.Length -gt 127)
        {
            Write-Host $type $item.Name is 128 characters or over and will need to be truncated -ForegroundColor Red
        }
        else
        {
            $illegalChars = '[&{}~#%]'
            filter Matches($illegalChars)
            {
                $item.Name | Select-String -AllMatches $illegalChars |
                Select-Object -ExpandProperty Matches
                Select-Object -ExpandProperty Values
            }
            
            #Replace illegal characters with legal characters where found
            $newFileName = $item.Name
            Matches $illegalChars | ForEach-Object {
                Write-Host $type $item.FullName has the illegal character $_.Value -ForegroundColor Red
                #These characters may be used on the file system but not SharePoint
                if ($_.Value -match "&") { $newFileName = ($newFileName -replace "&", "and") }
                if ($_.Value -match "{") { $newFileName = ($newFileName -replace "{", "(") }
                if ($_.Value -match "}") { $newFileName = ($newFileName -replace "}", ")") }
                if ($_.Value -match "~") { $newFileName = ($newFileName -replace "~", "-") }
                if ($_.Value -match "#") { $newFileName = ($newFileName -replace "#", "") }
                if ($_.Value -match "%") { $newFileName = ($newFileName -replace "%", "") }
            }
            
            #Check for start, end and double periods
            if ($newFileName.StartsWith(".")) { Write-Host $type $item.FullName starts with a period -ForegroundColor red }
            while ($newFileName.StartsWith(".")) { $newFileName = $newFileName.TrimStart(".") }
            if ($newFileName.EndsWith(".")) { Write-Host $type $item.FullName ends with a period -ForegroundColor Red }
            while ($newFileName.EndsWith("."))   { $newFileName = $newFileName.TrimEnd(".") }
            if ($newFileName.Contains("..")) { Write-Host $type $item.FullName contains double periods -ForegroundColor red }
            while ($newFileName.Contains(".."))  { $newFileName = $newFileName.Replace("..", ".") }
            
            
        }
    }
}


function RemoveIllegalCharacters ($Location)
{
    Write-Host Checking files in $Location, please wait...
    #Get all files and folders under the path specified
    $items = Get-ChildItem -Path $Location -Recurse
    foreach ($item in $items)
    {
        #Check if the item is a file or a folder or a Sub Folder
        if ($item.PSIsContainer) { $type = "Folder" }
        else { $type = "File" }
        
        #Report item has been found if verbose mode is selected
        if ($Verbose) { Write-Host Found a $type called $item.FullName }
        
        #Check length if item name is 128 characters or more  
        if ($item.Name.Length -gt 127)
        {
            Write-Host $type $item.Name is 128 characters or over and will need to be truncated -ForegroundColor Red
        }
        else
        {
            $illegalChars = '[&{}~#%]'
            filter Matches($illegalChars)
            {
                $item.Name | Select-String -AllMatches $illegalChars |
                Select-Object -ExpandProperty Matches
                Select-Object -ExpandProperty Values
            }
            
            #Replace illegal characters with legal characters where found
            $newFileName = $item.Name
            Matches $illegalChars | ForEach-Object {
                Write-Host $type $item.FullName has the illegal character $_.Value -ForegroundColor Red
                #These characters may be used on the file system but not SharePoint
                if ($_.Value -match "&") { $newFileName = ($newFileName -replace "&", "and") }
                if ($_.Value -match "{") { $newFileName = ($newFileName -replace "{", "(") }
                if ($_.Value -match "}") { $newFileName = ($newFileName -replace "}", ")") }
                if ($_.Value -match "~") { $newFileName = ($newFileName -replace "~", "-") }
                if ($_.Value -match "#") { $newFileName = ($newFileName -replace "#", "") }
                if ($_.Value -match "%") { $newFileName = ($newFileName -replace "%", "") }
            }
            
            #Check for start, end and double periods
            if ($newFileName.StartsWith(".")) { Write-Host $type $item.FullName starts with a period -ForegroundColor red }
            while ($newFileName.StartsWith(".")) { $newFileName = $newFileName.TrimStart(".") }
            if ($newFileName.EndsWith(".")) { Write-Host $type $item.FullName ends with a period -ForegroundColor Red }
            while ($newFileName.EndsWith("."))   { $newFileName = $newFileName.TrimEnd(".") }
            if ($newFileName.Contains("..")) { Write-Host $type $item.FullName contains double periods -ForegroundColor red }
            while ($newFileName.Contains(".."))  { $newFileName = $newFileName.Replace("..", ".") }

             #Rename the file and folder names 
            if (($newFileName -ne $item.Name))
            {
                Rename-Item $item.FullName -NewName ($newFileName)
                Write-Host $type $item.Name has been changed to $newFileName -ForegroundColor Blue
            }
            
            
        }
    }
}
