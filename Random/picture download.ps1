$URL = read-host 'url to search'

$list = ((iwr -uri $URL).images).src

foreach ($i in ($list -replace '//','')) {
    $filename = $i -replace 'i.imgur.com/',''
    iwr -uri $i -OutFile $filename
}

