$today = date
$users = (Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount = True AND Disabled = False").Name
$hostname = hostname 


Write-Output "Local user information on: $hostname"
foreach($user in $users){
  
  net user $user | Select-String "User Name" 
  net user $user | Select-String "Password last set" 
  Write-Output "####################################################################"
    
}

Write-Output "Report collected on: $today"
 Read-Host -Prompt "Press Enter to exit"

