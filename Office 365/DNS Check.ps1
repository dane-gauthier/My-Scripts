<#
Records needed:
MX
@ - domain-TLD.mail.protection.outlook.com
CNAME
autodiscover - autodiscover.outlook.com
sip - sipdir.online.lync.com
lyncdiscover - webdir.online.lync.com
msoid - clientconfig.microsoftonline-p.net
enterpriseregistration - enterpriseregistration.windows.net
enterpriseenrollment - enterpriseenrollment.manage.microsoft.com
SRV
_sip._tls.domain.TLD - port 443|weight 1|priority 100| target sipdir.online.lync.com
_sipfederationtls._tcp.doamin.TLD - port 5061|weight 1|priority 100| target sipfed.online.lync.com
#>

$domainName = Read-Host 'Domain Name'

Write-Host 'Now checking MX record'
nslookup -querytype=mx $domainName 4.2.2.1
echo ''
Write-Host 'Now Checking CNAME records'
nslookup -querytype=cname autodiscover.$domainName
echo ''
nslookup -querytype=cname sip.$domainName
echo ''
nslookup -querytype=cname lyncdiscover.$domainName
echo ''
nslookup -querytype=cname msoid.$domainName
echo ''
nslookup -querytype=cname enterpriseregistration.$domainName
echo ''
nslookup -querytype=cname enterpriseenrollment.$domainName
echo ''

Write-Host 'Now Checking SRV Records'
nslookup -querytype=srv _sip._tls.$domainName
echo ''
nslookup -querytype=srv _sipfederationtls._tcp.$domainName