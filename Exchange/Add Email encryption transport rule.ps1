#Activate Azure RMS for tenant
Enable-aadrm
New-TransportRule 'Email Encryption' -SubjectOrBodyContains '[encrypt]','[ecrypt]' -ApplyOME $true -comment 'Rule to enforce email encryption'