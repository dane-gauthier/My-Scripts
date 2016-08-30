$TargetDateBegin = (get-date)
$TargetDateEnd = (Get-date).AddDays(14)

###################################################################
foreach ($user in (Get-ADGroupMember -Identity "CN of security group")) {
    $UserExpiraryDate = Get-ADUser $user.SamAccountName –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}
    if (($UserExpiraryDate.ExpiryDate -ge $TargetDateBegin) -and ($UserExpiraryDate.ExpiryDate -le $TargetDateEnd)) {
    $DaysTilExpire = ($UserExpiraryDate.ExpiryDate - $TargetDateBegin).Days
$EmailBody = @"
Dear $($user.GivenName),

Your password will expire after $DaysTilExpire days.  You will need to change your password to keep using your account.

Sincerely,
Your IT Department

"@
    }
    
}