Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = 'Form'
$Form.Width = 455
$Form.Height = 309
$Form.KeyPreview = $True
$Form.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
    {$x=$objTextBox.Text;$Form.Close()}})

$label2 = New-Object system.windows.Forms.Label
$label2.Text = 'Do you want to play a game?'
$label2.AutoSize = $true
$label2.Width = 25
$label2.Height = 10
$label2.location = new-object system.drawing.size(140,133)
$label2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($label2)

$YesButton = New-Object system.windows.Forms.Button
$YesButton.Text = 'Yes'
$YesButton.Width = 60
$YesButton.Height = 30
$YesButton.location = new-object system.drawing.size(128,207)
$YesButton.Font = "Microsoft Sans Serif,10"
$YesButton.Add_Click({$x=$objTextBox.Text;$Form.Close()})
$Form.controls.Add($YesButton)

$NoButton = New-Object system.windows.Forms.Button
$NoButton.Text = 'No'
$NoButton.Width = 60
$NoButton.Height = 30
$NoButton.location = new-object system.drawing.size(256,207)
$NoButton.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($NoButton)

$objTextBox = New-Object System.Windows.Forms.TextBox 
$objTextBox.Location = New-Object System.Drawing.Size(10,40) 
$objTextBox.Size = New-Object System.Drawing.Size(260,20) 
$Form.Controls.Add($objTextBox) 

$Form.Add_Shown({$Form.Activate()})
$Form.ShowDialog()

write-host  $x