get-irmConfiguration
pause
Set-IRMConfiguration -RMSOnlineKeySharingLocation https://sp-rms.na.aadrm.com/TenantManagement/ServicePartner.svc
Import-RMSTrustedPublishingDomain -RMSOnline -name "RMS Online"

$UserEmail = read-host 'enter email address to test with'
test-irmconfiguration -sender $UserEmail

Set-IRMConfiguration -ClientAccessServerEnabled $false
Set-IRMConfiguration -InternalLicensingEnabled $true
