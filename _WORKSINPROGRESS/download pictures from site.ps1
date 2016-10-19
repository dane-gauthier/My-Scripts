$website = read-host "Url of site images to download"

foreach ($i in ((wget $website).images).src) {
    $randomNumber = Get-Random
    Invoke-WebRequest $i -OutFile "$randomNumber.jpg"
}
