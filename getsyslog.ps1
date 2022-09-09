Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

#$hosts = Get-Content 'C:\Temp\ESXScripts\hostList.txt'

$Servers = Get-Content 'C:\Temp\ESXScripts\hostList.txt' # 'lfoesxt504'
$user = 'root'
$pw = "W3r3sx@dm1n51"

[System.Array] $Sysloginfo = ""

foreach($server in $Servers){
    Connect-VIServer -Server $Server  -user $user -password $pw

    $sysLogServer = Get-VMHostSysLogServer -VMHost $server
    #$sysLogServer
    $info = New-Object PSObject 
   ## Name = $server
    #Host = $sysLogServer.Host
    #Port = $sysLogServer.Port
   $info | Add-Member -MemberType NoteProperty -Name Name -Value $server
   $info | Add-Member -MemberType NoteProperty -Name Host -Value $sysLogServer.Host
   $info | Add-Member -MemberType NoteProperty -Name Port -Value $sysLogServer.Port

  
  $Sysloginfo +=$info |Select-Object Name, @{Expression={$_.Host -join ';'}; label = 'ESXhost'}, @{Expression={$_.Port -join ';'} ;label = 'Port'} #| Export-Csv  "C:\Temp\ESXScripts\Sysloginf.csv" -NoTypeInformation 
     #$Sysloginfo
 }
 $Sysloginfo | Where-Object {$_} |Select-Object Name, ESXhost, Port | Export-Csv "C:\Temp\ESXScripts\Sysloginf.csv" -Append -NoTypeInformation 
  Disconnect-VIServer -Server * -Force