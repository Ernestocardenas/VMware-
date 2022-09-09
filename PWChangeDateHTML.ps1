$hostnames = Get-Content "C:\temp\hostnames.txt"
$info2 = @()

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

$localdata = Invoke-Command -ScriptBlock{
        $hostnames = hostname 
        $info = @()
        $users = (Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount = True AND Disabled = False").Name

        foreach($user in $users){
  
  
          $UserName = ((net user $user | Select-String "User Name").ToString()) -split ("User name") | where{$_}
          $ChangeDate = ((net user $user | Select-String "Password last set").ToString()) -split ("Password last set") | where{$_}
          $ObjectProperties = @{
            UserName = $UserName.Trim()
            'Password Change Date' = $ChangeDate.Trim()
          }

          $info += New-Object psobject -Property $ObjectProperties
    
        }
        
        $info | ConvertTo-Html -Property UserName, 'Password Change Date'  -Fragment  -PreContent "<h2>$hostnames : Local Users Password Change Date</h2>"

    }

    $info2 += $localdata 
$i =0
foreach($vdi in $hostnames){
    $data = Invoke-Command -ComputerName $vdi -ScriptBlock{
        $hostname = hostname 
        $info = @()
        $users = (Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount = True AND Disabled = False").Name

        foreach($user in $users){
  
  
          $UserName = ((net user $user | Select-String "User Name").ToString()) -split ("User name") | where{$_}
          $ChangeDate = ((net user $user | Select-String "Password last set").ToString()) -split ("Password last set") | where{$_}
          $ObjectProperties = @{
            UserName = $UserName.Trim()
            'Password Change Date' = $ChangeDate.Trim()
          }

          $info += New-Object psobject -Property $ObjectProperties
    
        }
        #$info
        $info | ConvertTo-Html -Property UserName, 'Password Change Date'  -Fragment  -PreContent "<h2>$hostname : Local Users Password Change Date</h2>"

    }
    Write-Host "Working on: $vdi"
    Write-Host "Count: $i"
    $i++
    $info2 += $data 
    
    #$data | Where{$_.Username -match "Administrator"}

}

#Generating timestamp
$post =  "<BR><i>Report generated on $((Get-Date).ToString())</i>"

#Output HTML Title 
$DocTitle = "<h1>CIP-007 R5 Password Change Date Evidence: Confidential Use - CEII</h1>"

ConvertTo-Html -Body "$DocTitle  $info2" -Title "CIP-007 R5 Evidence" -Head $header -PostContent $post | Out-File "C:\temp\CIP-007R5-PasswordChangeDate.html" 
#$info2 | Out-File "C:\temp\test1.html"
