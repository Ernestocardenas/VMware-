hostname
date 

Function Check-Enabled ($Username) 
{

-not ((Get-WmiObject Win32_UserAccount -filter "LocalAccount=True")| Where {$_.Name -eq $Username}).Disabled

}


Write-Output "`nLocal users and their group membership"

([ADSI]"WinNT://$env:COMPUTERNAME").Children | ?{$_.SchemaClassName -eq 'user'} | %{
                    $groups = $_.Groups() | %{$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)}
                    $_ | Select  @{n='UserName';e={$_.Name}}, @{n='Enabled';e={Check-Enabled $_.Name}},  @{n='Groups';e={$groups -join ';'}}} | Format-Table -AutoSize


 $groups = (Get-WMIObject  -Class Win32_Group -Filter "LocalAccount=True").Name

$info=@()

foreach ($group in $groups)
{
    $members = net localgroup $group | where {$_ -AND $_ -notmatch "command completed successfully"} | select -skip 4
    
    $obj = New-Object PSObject

            $obj | Add-Member -MemberType NoteProperty -Name "Local Group" -Value $group
            $obj | Add-Member -MemberType NoteProperty -Name "Local Group Members" -Value ($members -join ",")
        $info += $obj

 }

 Write-Output "Local groups and their members"

 $info | Format-Table -AutoSize -Wrap

 Read-Host -Prompt "Press Enter to exit" 

