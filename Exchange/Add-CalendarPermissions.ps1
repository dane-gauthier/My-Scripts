$identity = read-host 'User account to get settings for'
$user = read-host 'User account to add'
$permissions = read-host 'Permissions to add (Editor,Owner,AvailabilityOnly,Reviewer)'

Add-MailboxFolderPermission -Identity $identity':\Calendar' -user $user -AccessRights $permissions
Get-MailboxFolderPermission -Identity $identity':\Calendar'