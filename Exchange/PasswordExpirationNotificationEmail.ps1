############VARIABLES#####################################
$TargetDateBegin = (get-date)
$TargetDateEnd = (Get-date).AddDays(14)
$MailServer = <ADDRESS OF MAILSERVER>
$FromAddress = <ADDRESS FOR FROM> 
$SecurityGroup = <SECURITY GROUP TO COMPARE;use full CN name>

############MAIN SCRIPT###################################
foreach ($user in (Get-ADGroupMember -Identity $SecurityGroup)) {
    $UserEmailAddress = (get-aduser $user -properties mail).mail
    $UserExpiraryDate = Get-ADUser $user.SamAccountName –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}
    $EmailBody = $null
    if (($UserExpiraryDate.ExpiryDate -ge $TargetDateBegin) -and ($UserExpiraryDate.ExpiryDate -le $TargetDateEnd)) {
    $DaysTilExpire = ($UserExpiraryDate.ExpiryDate - $TargetDateBegin).Days
$EmailBody = 
@"
Dear $($user.GivenName),

Your password will expire after $DaysTilExpire days.  You will need to change your password to keep using your account.

In order to change your password, you can follow the following steps:
1. Click the Start button at the bottom-left portion of your screen and click Windows Security, which will be the 4th option from the top in the right column.
                      -OR-
   Pressing CTRL+ALT+END key combination on your keyboard.
2. Click "Change a Password..."
3. Type your old password in the second box, then type in a new password in the third and fourth box.
4. Once finished, click the Blue Arrow button to finish changing your password.

If you have any issues, please feel free to contact Support and we can assist with the process. 

Sincerely,
Your IT Department


"@
    if ($EmailBody -ne $null) {
        Send-MailMessage -from $FromAddress -To $UserEmailAddress -Subject 'Password Expiration Notification' -Body $EmailBody -SmtpServer $MailServer
        }
    }
    
}