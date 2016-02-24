$NewDomain = read-host "new domain to whitelist"

$list = (Get-ContentFilterConfig).BypassedSenderDomains
$list.add(“$NewDomain”)
Set-ContentFilterConfig -BypassedSenderDomains $list