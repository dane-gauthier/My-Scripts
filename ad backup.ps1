$Mode = "Full" ## Set to this when promoting to a fully writable DC
#$Mode = "RODC" ## Set to this when promoting to a Read Only DC

$timestamp = Get-Date -Format o | foreach {$_ -replace ":", "."}
$IFMPath = "c:\temp\IFM-$timestamp" ## This is where the IFM media set will be created

write-output "Creating the IFM media set..." `r
write-output "This process can take about 15 minutes" `r

$IFMResult = ntdsutil "activate instance ntds" ifm "create sysvol full $IFMPath" q q q

write-output "Creation of the IFM media set is complete..." `r
write-output "The result of this operation is:" `r
$IFMResult

IF ($IFMResult -like "*IFM media created successfully*")
{ ## OPEN IF IFMResult was successful
write-output "The script successfully created the IFM Media Set and will now copy it to the specified network destination." `r
$Success = "True"
} ## CLOSE IF IFMResult was successful