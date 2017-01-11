#Removes %20 from filename
Get-ChildItem -recurse | Where-Object {$_.Name -match "%20"} | rename-item -newName {$_.Name -replace '%20',' '}
