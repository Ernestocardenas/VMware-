Set-PowerCLIConfiguration -DefaultVIServerMode Multiple -Scope Session -Confirm:$false
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false

$localpath = Split-Path -Parent $MyInvocation.MyCommand.Path
$Servers =Get-Content -Path ($localpath + '\hostList.txt')
#$credential = Get-Credential
Connect-VIServer -Server $Servers #-Credential $credential -WarningAction SilentlyContinue  

Get-VM | Where-Object{$_.Name -match 'sdt'}| Select @{Expression = {$_.Uid.Split('@')[1].Split(':')[0]} ; Label='Vcenter'},Name, @{Expression ={$_.VMHost.Parent}; Label='Cluster' } | Select-Object Vcenter, Name, Cluster | Export-Csv  -Append 'C:\Temp\ESXScripts\655_SDTinfo.csv' -NoTypeInformation

Disconnect-VIServer -Server * -Force
