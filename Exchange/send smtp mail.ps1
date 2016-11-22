$EmailFrom = read-host 'email address to send from'

$EmailTo = read-host 'email address to send to'

$Subject = "test email"

$Body = "test email"

$SMTPServer = read-host 'smtp server address'

$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)

$SMTPClient.EnableSsl = $true

$username = read-host 'username'
$password = read-host 'password'

$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("$username", "$password");

$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)