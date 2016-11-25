Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form = New-Object system.Windows.Forms.Form
$Form.Text = 'What to echo'
$Form.Size = New-Object System.Drawing.Size(300,200)
$Form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$Form.AcceptButton = $OKButton
$Form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$Form.CancelButton = $CancelButton
$Form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Size(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = "Type something and press ENTER:"
$Form.Controls.Add($label)

$objTextbox = New-Object system.Windows.forms.TextBox
$objTextBox.Location = New-Object System.Drawing.Size(10,40)
$objTextBox.Size = New-Object System.Drawing.Size(260,20)
$Form.Controls.Add($objTextBox)

 $Form.Topmost = $True

$Form.Add_Shown({$objTextBox.Select()})
$result = $Form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $ping = $objTextBox.Text
    ping $ping
}
