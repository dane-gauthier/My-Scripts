$GroupA = read-host "Group to copy user list from:"
$GroupB = read-host "Group to copy users to:"
foreach ($user in (get-adgroupmember -identity $GroupA | select samaccountname)) {add-adgroupmember -identity $GroupB -Members $user}