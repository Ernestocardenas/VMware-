Set-PowerCLIConfiguration -DefaultVIServerMode Multiple -Scope Session -Confirm:$false
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false

#$localpath = Split-Path -Parent $MyInvocation.MyCommand.Path
#$Servers =Get-Content -Path ($localpath + '\hostList.txt')
#$credential = Get-Credential
$Servers = @(
                'lfosat855',
                'dytsat855',
                'lfosat655',
                'dytsat655'
                )
Connect-VIServer -Server $Servers #-Credential $credential -WarningAction SilentlyContinue  

Get-VM | Select @{Expression = {$_.Uid.Split('@')[1].Split(':')[0]} ; Label='Vcenter'},Name, @{Expression ={$_.VMHost.Parent}; Label='Cluster' },  @{Expression={($_ | Get-NetworkAdapter).NetworkName};Label='Vlan'},  @{Expression ={Get-VMHost -VM $_}; Label='Host' } | Select-Object Name, Vcenter, Host, Cluster, Vlan | Export-Csv   'C:\Temp\ESXScripts\VMinfo.csv' -Append -NoTypeInformation

Disconnect-VIServer -Server * -Force