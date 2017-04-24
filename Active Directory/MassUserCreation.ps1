import-csv -Path .\users.csv -Delimiter ',' | new-aduser -SamAccountName $SamAccountName -GivenName $GivenName -SurName $SurName -Name $Name -DisplayName $DisplayName -Enabled $false 
