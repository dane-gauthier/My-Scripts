$identity = read-host 'User account to get settings for'

Get-MailboxFolderPermission -Identity $identity':\Calendar'