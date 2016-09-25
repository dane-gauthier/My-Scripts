Param(
	[string]$Path
	)

$WallpaperCount = (gci -r | ? {$_.PSIsContainer -eq $false -and ($_.Extension -match '.jpg' -or $_.extension -match '.jpeg' -or $_.extension -match '.png' -or $_.extension -match '.bmp' -or $_.extension -match '.jpeg')}).count
write-host "Congratulations, you have $WallpaperCount wallpapers!"
