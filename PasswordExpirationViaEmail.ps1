##############Variables#################            
$verbose = $true            
$notificationstartday = 14            
$sendermailaddress = "no-reply@contoso.com"            
$SMTPserver = "mail.contoso.com"            
$DN = "DC=contoso,DC=local"            
########################################            
            
##############Function##################            
function PreparePasswordPolicyMail ($ComplexityEnabled,$MaxPasswordAge,$MinPasswordAge,$MinPasswordLength,$PasswordHistoryCount)            
{            
    $verbosemailBody = "Below is a summary of the applied Password Policy settings:`r`n`r`n"            
    $verbosemailBody += "Complexity Enabled = " + $ComplexityEnabled + "`r`n`r`n"            
    $verbosemailBody += "Maximum Password Age = " + $MaxPasswordAge + "`r`n`r`n"            
    $verbosemailBody += "Minimum Password Age = " + $MinPasswordAge + "`r`n`r`n"            
    $verbosemailBody += "Minimum Password Length = " + $MinPasswordLength + "`r`n`r`n"            
    $verbosemailBody += "Remembered Password History = " + $PasswordHistoryCount + "`r`n`r`n"            
    return $verbosemailBody            
}            
            
function SendMail ($SMTPserver,$sendermailaddress,$usermailaddress,$mailBody)            
{            
    $smtpServer = $SMTPserver            
    $msg = new-object Net.Mail.MailMessage            
    $smtp = new-object Net.Mail.SmtpClient($smtpServer)            
    $msg.From = $sendermailaddress            
    $msg.To.Add($usermailaddress)            
    $msg.Subject = "Your password is about to expire"            
    $msg.Body = $mailBody            
    $smtp.Send($msg)            
}            
########################################            
            
##############Main######################            
$domainPolicy = Get-ADDefaultDomainPasswordPolicy            
$passwordexpirydefaultdomainpolicy = $domainPolicy.MaxPasswordAge.Days -ne 0            
            
if($passwordexpirydefaultdomainpolicy)            
{            
    $defaultdomainpolicyMaxPasswordAge = $domainPolicy.MaxPasswordAge.Days            
    if($verbose)            
    {            
        $defaultdomainpolicyverbosemailBody = PreparePasswordPolicyMail $PSOpolicy.ComplexityEnabled $PSOpolicy.MaxPasswordAge.Days $PSOpolicy.MinPasswordAge.Days $PSOpolicy.MinPasswordLength $PSOpolicy.PasswordHistoryCount            
    }            
}            
            
foreach ($user in (Get-ADUser -SearchBase $DN -Filter * -properties mail))            
{            
    $samaccountname = $user.samaccountname            
    $PSO= Get-ADUserResultantPasswordPolicy -Identity $samaccountname            
    if ($PSO -ne $null)            
    {                         
        $PSOpolicy = Get-ADUserResultantPasswordPolicy -Identity $samaccountname            
        $PSOMaxPasswordAge = $PSOpolicy.MaxPasswordAge.days            
        $pwdlastset = [datetime]::FromFileTime((Get-ADUser -LDAPFilter "(&(samaccountname=$samaccountname))" -properties pwdLastSet).pwdLastSet)            
        $expirydate = ($pwdlastset).AddDays($PSOMaxPasswordAge)            
        $delta = ($expirydate - (Get-Date)).Days            
        $comparionresults = (($expirydate - (Get-Date)).Days -le $notificationstartday) -AND ($delta -ge 1)            
        if ($comparionresults)            
        {            
            $mailBody = "Dear " + $user.GivenName + ",`r`n`r`n"            
            $mailBody += "Your password will expire after " + $delta + " days. You will need to change your password to keep using it.`r`n`r`n"            
            if ($verbose)            
            {            
                $mailBody += PreparePasswordPolicyMail $PSOpolicy.ComplexityEnabled $PSOpolicy.MaxPasswordAge.Days $PSOpolicy.MinPasswordAge.Days $PSOpolicy.MinPasswordLength $PSOpolicy.PasswordHistoryCount            
            }            
            $mailBody += "`r`n`r`nYour IT Department"            
            $usermailaddress = $user.mail            
            SendMail $SMTPserver $sendermailaddress $usermailaddress $mailBody            
        }            
    }            
    else            
    {            
        if($passwordexpirydefaultdomainpolicy)            
        {            
            $pwdlastset = [datetime]::FromFileTime((Get-ADUser -LDAPFilter "(&(samaccountname=$samaccountname))" -properties pwdLastSet).pwdLastSet)            
            $expirydate = ($pwdlastset).AddDays($defaultdomainpolicyMaxPasswordAge)            
            $delta = ($expirydate - (Get-Date)).Days            
            $comparionresults = (($expirydate - (Get-Date)).Days -le $notificationstartday) -AND ($delta -ge 1)            
            if ($comparionresults)            
            {            
                $mailBody = "Dear " + $user.GivenName + ",`r`n`r`n"            
                $delta = ($expirydate - (Get-Date)).Days            
                $mailBody += "Your password will expire after " + $delta + " days. You will need to change your password to keep using it.`r`n`r`n"            
                if ($verbose)            
                {            
                    $mailBody += $defaultdomainpolicyverbosemailBody            
                }            
                $mailBody += "`r`n`r`nYour IT Department"            
                $usermailaddress = $user.mail            
                SendMail $SMTPserver $sendermailaddress $usermailaddress $mailBody            
            }            
            
        }            
    }            
}