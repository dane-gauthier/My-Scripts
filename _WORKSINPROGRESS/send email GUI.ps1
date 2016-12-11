Add-Type -AssemblyName System.Windows.Forms

#------GUI Building------
$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Helpdesk Email"
$Form.TopMost = $true
$Form.Width = 544
$Form.Height = 472
$Form.StartPosition = "CenterScreen"

$label2 = New-Object system.windows.Forms.Label
$label2.Text = "Helpdesk Email"
$label2.AutoSize = $true
$label2.Width = 25
$label2.Height = 10
$label2.location = new-object system.drawing.point(44,22)
$label2.Font = "Microsoft Sans Serif,20,style=Bold"
$Form.controls.Add($label2)

$SendButton = New-Object system.windows.Forms.Button
$SendButton.Text = "Send"
$SendButton.Width = 60
$SendButton.Height = 30
$SendButton.location = new-object system.drawing.point(307,380)
$SendButton.Font = "Microsoft Sans Serif,12,style=Bold"
$SendButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$Form.AcceptButton = $SendButton
$Form.controls.Add($SendButton)

$ToField = New-Object system.windows.Forms.Label
$ToField.Text = "To:"
$ToField.AutoSize = $true
$ToField.Width = 25
$ToField.Height = 10
$ToField.location = new-object system.drawing.point(44,97)
$ToField.Font = "Microsoft Sans Serif,10"
#$Form.controls.Add($ToField)

$UserCheckBox = New-Object system.windows.Forms.CheckBox
$UserCheckBox.Text = "Andrew Garza"
$UserCheckBox.AutoSize = $true
$UserCheckBox.Width = 95
$UserCheckBox.Height = 20
$UserCheckBox.location = new-object system.drawing.point(78,97)
$UserCheckBox.Font = "Microsoft Sans Serif,10"
#$Form.controls.Add($UserCheckBox)

$SubjectBox = New-Object system.windows.Forms.TextBox
$SubjectBox.Width = 291
$SubjectBox.Height = 20
$SubjectBox.location = new-object system.drawing.point(84,165)
$SubjectBox.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($SubjectBox)

$SubjectLabel = New-Object system.windows.Forms.Label
$SubjectLabel.Text = "Subject:"
$SubjectLabel.AutoSize = $true
$SubjectLabel.Width = 25
$SubjectLabel.Height = 10
$SubjectLabel.location = new-object system.drawing.point(30,164)
$SubjectLabel.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($SubjectLabel)

$DescriptionLabel = New-Object system.windows.Forms.Label
$DescriptionLabel.Text = "Description:"
$DescriptionLabel.AutoSize = $true
$DescriptionLabel.Width = 25
$DescriptionLabel.Height = 10
$DescriptionLabel.location = new-object system.drawing.point(32,209)
$DescriptionLabel.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($DescriptionLabel)

$DescriptionBox = New-Object system.windows.Forms.TextBox
$DescriptionBox.Width = 259
$DescriptionBox.Height = 20
$DescriptionBox.location = new-object system.drawing.point(116,209)
$DescriptionBox.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($DescriptionBox)

$Form.Topmost = $True

$result = [void]$Form.ShowDialog()

#---------Main Script-----------
#----Variables----
$from = 'SENDER'
$to = 'RECEIVER'
$smtpserver = 'SMTPSERVER'
$subject = $SubjectBox.text
$body = $DescriptionBox.text

$Username = 'EMAILACCOUNTADDRESS'
$Password = 'EMAILACCOUNTPASSWORD'

$SecurePassword = ConvertTo-SecureString -AsPlainText $password -force
$creds = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $Username,$SecurePassword

#----End Variables----

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    Send-MailMessage -From $from -To $to -Subject $subject -Body $body -Credential $creds -SmtpServer $smtpserver -UseSsl
}
