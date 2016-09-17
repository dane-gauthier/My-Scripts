Param(
	[string]$Path
	)

#$path = 'D:\Pictures\Random Desktop Photos\Official Wallpaper location'
$WallpaperCount = (gci -r | ? {$_.PSIsContainer -eq $false -and ($_.Extension -match '.jpg' -or $_.extension -match '.jpeg' -or $_.extension -match '.png' -or $_.extension -match '.bmp')}).count
write-host "Congratulations, you have $WallpaperCount wallpapers!"
