Function global:ADD-PATH()
{
[Cmdletbinding()]
param
( 
[parameter(Mandatory=$True,
ValueFromPipeline=$True,
Position=0)]
[String[]]$AddedFolder
)

# Get the current search path from the environment keys in the registry.

$OldPath=(Get-ItemProperty -Path ‘Registry::HKEY_LOCAL_MACHINESystemCurrentControlSetControlSession ManagerEnvironment’ -Name PATH).Path

# See if a new folder has been supplied.

IF (!$AddedFolder)
{ Return ‘No Folder Supplied. $ENV:PATH Unchanged’}

# See if the new folder exists on the file system.

IF (!(TEST-PATH $AddedFolder))
{ Return ‘Folder Does not Exist, Cannot be added to $ENV:PATH’ }

# See if the new Folder is already in the path.

IF ($ENV:PATH | Select-String -SimpleMatch $AddedFolder)
{ Return ‘Folder already within $ENV:PATH’ }

# Set the New Path

$NewPath=$OldPath+’;’+$AddedFolder

Set-ItemProperty -Path ‘Registry::HKEY_LOCAL_MACHINESystemCurrentControlSetControlSession ManagerEnvironment’ -Name PATH –Value $newPath

# Show our results back to the world

Return $NewPath
}
