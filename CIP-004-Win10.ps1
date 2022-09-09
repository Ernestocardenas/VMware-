#$info = @()
$hostnames = Get-Content "C:\temp\hostnames.txt"
#$hostname = "xNORTHSP2"
$header = @"
<style>

    h1 {

        font-family: Arial, Helvetica, sans-serif;
        font-size: 28px;
        

    } 

    h2 {

        font-family: Arial, Helvetica, sans-serif;
        font-size: 16px;
        text-transform: uppercase;


    }
    
     table {
		font-size: 12px;
		border: 1px solid black;
		font-family: Arial, Helvetica, sans-serif;
        
	} 
	
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
        
	}
	
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}

    tbody tr:nth-child(even) {
        background: #f0f0f2;
        
    }

  

        #CreationDate {

        font-family: Arial, Helvetica, sans-serif;
        color: #ff3300;
        font-size: 12px;

    }
    
</style>

"@
$i =0
foreach($vdi in $hostnames){
$info = @()
Write-Output "Working on $vdi"
    $localusers = Invoke-Command -ComputerName $vdi -ScriptBlock{
        Function Check-Enabled ($Username) 
        {

        -not ((Get-WmiObject Win32_UserAccount -filter "LocalAccount=True")| Where {$_.Name -eq $Username}).Disabled

        }


       # Write-Output "`nLocal users and their group membership"
       $hostname = hostname

        ([ADSI]"WinNT://$env:COMPUTERNAME").Children | ?{$_.SchemaClassName -eq 'user'} | %{
                            $groups = $_.Groups() | %{$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)}
                            $_ | Select  @{n='UserName';e={$_.Name}}, @{n='Enabled';e={Check-Enabled $_.Name}},  @{n='Groups';e={$groups -join ';'}}} | ConvertTo-Html -Property Username, Enabled, Groups  -Fragment  -PreContent "<h2>$hostname : Local users and their group membership</h2>"
    }

    $localgroups = Invoke-Command -ComputerName $vdi -ScriptBlock{
        $GroupInfo=@()
        $hostname = hostname
        $groups = (Get-WMIObject  -Class Win32_Group -Filter "LocalAccount=True").Name

        foreach ($group in $groups)
        {
            $members = net localgroup $group | where {$_ -AND $_ -notmatch "command completed successfully"} | select -skip 4
    
            $obj = New-Object PSObject

                    $obj | Add-Member -MemberType NoteProperty -Name "Local Group" -Value $group
                    $obj | Add-Member -MemberType NoteProperty -Name "Local Group Members" -Value ($members -join ",")
                $GroupInfo += $obj

         }
         $GroupInfo | ConvertTo-Html -Property 'Local Group', 'Local Group Members'  -Fragment  -PreContent "<h2>$hostname : Local groups and their members</h2>"
     }
     $info += $localusers 
     $info += $localgroups
#}




#Generating timestamp
$post =  "<BR><i>Report generated on $((Get-Date).ToString())</i>"

#Output HTML Title 
$DocTitle = "<h1>Windows 10 VDI CIP-004 Evidence: Confidential Use - CEII</h1>"



ConvertTo-Html -Body "$DocTitle  $info" -Title "CIP-004 Evidence" -Head $header -PostContent $post | Out-File "C:\temp\CIP004\CIP-004-$vdi.html" 
$i ++
Write-Output "Count: $i"}




