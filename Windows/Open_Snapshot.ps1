#View usable snapshots
vssadmin List Shadows

#get the Shadow copy volume path as follows: \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy138\

$ShadowPath = read-host 'copy and paste the shadow copy volume path in here'

cmd /c "mklink /d C:\LatestShadow $ShadowPath"
<#
#Setting permissions on LatestShadow folder
$user = $Env:USERNAME 
$acl = Get-acl C:\LatestShadow
$acl.SetAccessRuleProtection($true, $false)
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$user","FullControl", "ContainerInherit", "ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)

Set-Acl C:\LatestShadow\ $acl
#>