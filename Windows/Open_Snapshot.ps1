#View usable snapshots
vssadmin List Shadows

#get the Shadow copy volume path as follows: \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy138\

$ShadowPath = read-host 'copy and paste the shadow copy volume path in here'

cmd /c "mklink /d C:\LatestShadow $ShadowPath"
