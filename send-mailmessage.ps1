param(
[string]$to,
[string]$from,
[string]$subject,
[string]$body,
[string]$smtpserver
)

$creds = Get-Credential

Send-MailMessage -From $from -To $to -Subject $subject -Body $body -Credential $creds -SmtpServer $smtpserver -UseSsl