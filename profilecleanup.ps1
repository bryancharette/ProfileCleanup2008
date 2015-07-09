#Gather all of the user profiles on computer 
$users = Get-WmiObject Win32_UserProfile -filter "LocalPath Like 'C:\\Users\\%'" -ea stop
#Cache the number of users 
$num_users = $users.count 
#Begin iterating through all of the accounts for deletion
For ($account=0;$account -lt $num_users; $account++) 
{
#Remove the local profile
($users[$account]).Delete()
}
#Remove corrupt Registry profile keys
Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*.bak"
#Remove erroneous Enterprise printer mappings
$null = New-PSDrive -Name HKU   -PSProvider Registry -Root Registry::HKEY_USERS
Remove-Item "HKU:\*\Software\VB and VBA Program Settings\Yardi\t\ReportPrinter*"
get-item -path "HKU:\*\Software\VB and VBA Program Settings\Yardi\t" | remove-itemproperty -name "ReportPrinter"
get-item -path "HKU:\*\Software\VB and VBA Program Settings\Yardi\t" | remove-itemproperty -name "ReportPrinterTray"
