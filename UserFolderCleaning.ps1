Set-Location 'D:\Profiles'

$names = gci -Directory * | select FullName

$count = $names.Count
$i=1

foreach ($name in $names.FullName) {
    Write-output "Processing $i of $count"
    #Removal of Temp Internet Files
    if (Test-Path -Path "$name\APPDATA.V2\AppData\Local\Microsoft\Windows") {
    New-PSDrive -Name TempInternetFiles -PSProvider FileSystem -Root "$name\APPDATA.V2\AppData\Local\Microsoft\Windows"
    Remove-Item -Path "TempInternetFiles:\Temporary Internet Files\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-PSDrive TempInternetFiles
    }
    #Removal of Temp Files
    if (Test-Path -Path "$name\APPDATA.V2\AppData\Local") {
    New-PSDrive -name TempFiles -PSProvider FileSystem -Root "$name\APPDATA.V2\AppData\Local"
    Remove-Item -Path "TempFiles:\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-PSDrive TempFiles
    }
    #Removal fo Chrome cache
    if (Test-Path -Path "$name\APPDATA.V2\AppData\Local\Google\Chrome\User Data\Default\") {
    New-PSDrive -Name Chrome -PSProvider FileSystem -Root "$name\APPDATA.V2\AppData\Local\Google\Chrome\User Data\Default\"
    Remove-Item -Path "Chrome:\Cache\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "Chrome:\Media Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "Chrome:\Application Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-PSDrive Chrome
    }
    else {Write-Output "Chrome cache folder doesn't exist for $name"}
    #Removal of GotoMeeting files
    if (Test-Path -Path "$name\APPDATA.V2\AppData\Local\Citrix\") {
    New-PSDrive -Name Citrix -PSProvider FileSystem -Root "$name\APPDATA.V2\AppData\Local\Citrix\"
    Remove-Item -Path "Citrix:\GotoMeeting\" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-PSDrive Citrix
    }
    else {Write-Output "Citrix Folder doesn't exist for $name"}
    #Removal of Spotify
    if (Test-Path -Path "$name\APPDATA.V2\AppData\Local\Spotify\") {
    Remove-Item "$name\APPDATA.V2\AppData\Local\Spotify\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-item "$name\APPDATA.V2\AppData\Roaming\Spotify\*" -Recurse -Force -ErrorAction SilentlyContinue
    }
    else {Write-Output "Spotify folder doesn't exist for $name"}
    #Removal of Cookies
    #remove-item "$name\APPDATA.V2\AppData\Roaming\Microsoft\Windows\Cookies\*" -Recurse -Force 
    
    $i++

}