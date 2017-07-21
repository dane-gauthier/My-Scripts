$CSVFile = Read-Host 'Path to CSV file'
$Category = read-host 'Category to Group by'

import-csv $CSVFile | Group-Object -Property $Category | ? {$_.count -ge 2} | foreach {$_.group}