#Required to load the XAML form and create the PowerShell Variables

./LoadDialog.ps1 -XamlPath 'C:\Forms\MyForm.xaml'

 

#EVENT Handler

$MyButton.add_Click({

$MyLabel.Content = "Hello World"

})

 

#Launch the window

$xamGUI.ShowDialog() | out-null