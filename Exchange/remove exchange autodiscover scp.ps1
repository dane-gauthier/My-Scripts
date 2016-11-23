$ServerName = read-host 'name of exchange server'
Set-ClientAccessServer -Identity $ServerName -AutoDiscoverServiceInternalUri $null
