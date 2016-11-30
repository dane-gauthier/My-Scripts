$obj = gwmi -namespace "Root/CIMV2/TerminalServices" Win32_TerminalServiceSetting

$value = read-host 'Value = 2 for Per device, Value = 4 for Per User'

$obj.ChangeMode($value)

$obj.SetSpecifiedLicenseServerList("$env:COMPUTERNAME")

$obj.GetSpecifiedLicenseServerList()