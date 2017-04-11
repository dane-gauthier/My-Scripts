Param (
    [string]$URL
)

$list = ((iwr -uri $URL).images).src
$listcount = ((iwr -uri $URL).images).count

$i = 1
foreach ($picture in ($list -replace '//','')) {
    write-host "Downloading $i of $listcount"
    $filename = $picture -replace 'i.imgur.com/',''
    iwr -uri $picture -OutFile $filename
    $i++
}

