	
Function Get-GroupMember {

    [cmdletbinding()]

    Param([string]$ADSPath)
 
    [ADSI]$group = $ADSPath
 
    $group.member | foreach {

        [ADSI]$child = "LDAP://$_"

        if ($child.SchemaClassName -eq "group") {

        Get-GroupMember $child.ADSPath

        }

        else {
        
        $child | Select @{ l="Name"; e={ $child.name } } ,@{ l="SLID"; e={ $child.sAMAccountName } }, @{ l="Group"; e={ $group.distinguishedName } } 
        # $child | Select ADSPath,SchemaClassname
        #@{ l="Disabled?"; e={ $child.accountdisabled } }

        }
    }
 
}

$date = date
Write-Host "Report Generated on: $date"

#Get-GroupMember -ADSPath "LDAP://CN=System Operations - System Operators,OU=CIP GROUPS,DC=transmission,DC=disp" | Format-Table -AutoSize 
Get-GroupMember -ADSPath "CN=Tripwire-Reports,OU=RestrictedGroups,DC=transmission,DC=disp" #| Format-Table -AutoSize 
#Get-GroupMember -ADSPath "LDAP://CN=T&S Technology - Operational Technology Center,OU=CIP GROUPS,DC=transmission,DC=disp" | Sort Name | Format-Table -AutoSize

#Read-Host -Prompt "Press Enter to exit"

