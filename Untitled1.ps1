
#Import-Module VMware.VimAutomation.Core
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

$Server = 'dytsat855'
Connect-VIServer -Server $Server
#$sysLogServer = Get-VMHostSysLogServer  -VMHost lfoesxt501
#$sysLogServer

#| Get-Member




#Add-PSSnapin VMware.VimAutomation.Core
#$vcenter = Read-Host 'Please Enter the vCenter Server IP address'

#connect-viserver -server $Server -user $user -password "12654hgH"
Get-View -ViewType VirtualMachine | %{
New-Object PSObject -Property @{
Name = $_.Name
Host = (Get-View $_.Summary.Runtime.Host).Name
Vcenter = $Server

}
}  | Export-Csv  "C:\Temp\ESXScripts\VM-report3.csv" -NoTypeInformation -UseCulture
Disconnect-VIServer -Server $Server
<#############################################################################################
    Connect-VIServer -Server $Server  -user $user -password $pw

    $sysLogServer = Get-VMHostSysLogServer -VMHost $server
    #$sysLogServer
    $info = New-Object PSObject -Property @{
   ## Name = $server
    #Host = $sysLogServer.Host
    #Port = $sysLogServer.Port
   $info | Add-Member -InputObject $object -MemberType NoteProperty -Name ServerName -Value $hostname
    
     }
   $Sysloginfo += $info
   $Sysloginfo 
     #>