Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false
Set-PowerCLIConfiguration -DefaultVIServerMode Multiple -Scope Session -Confirm:$false

$Servers = @(
                'lfosat755'
                
                
                )
Connect-VIServer -Server $Servers -User 'wxf0xeg' -Password '12654hgH4'

Get-VM  | Select Name,
                                                @{N="OS";E={$_.Guest.OSFullName}}, 
                                                @{Expression ={$_.VMHost.Parent}; Label='Cluster' }, 
                                                @{Expression ={(Get-Cluster $_.VMHost.Parent).ExtensionData.Summary.NumCPuCores }; Label='ClusterCPU' }, 
                                                @{Expression = {$_.Uid.Split('@')[1].Split(':')[0]} ; Label='Vcenter'} # | Export-Csv -Path C:\Temp\ESXScripts\carusinfo.csv -Append -NoTypeInformation

Disconnect-VIServer -Server * -Force
 # |  Where { $_.Guest.OSFullName -match "08" }                                              
                                                
                                                
                                                 #| Out-File C:\Temp\ESXScripts\carusinfo.txt 
#Get-VM | Where { $_.Guest.OSFullName -match "08" } | %{$_.VMHost.Parent.ExtensionData | Get-Member |Format-Table}
<#$sblkGetVMHostCpuInfo = {
    Get-Cluster | %{
        $oCluster = $_
        ## get the GenericMeasureInfo for the desired properties for this cluster's hosts
        $mioCpuInfo = Get-View -ViewType HostSystem -Property Hardware.CpuInfo -SearchRoot $oCluster.Id | Select @{n="NumCpuSockets"; e={$_.Hardware.CpuInfo.NumCpuPackages}}, @{n="NumCpuCores"; e={$_.Hardware.CpuInfo.NumCpuCores}}, @{n="NumCpuThreads"; e={$_.Hardware.CpuInfo.NumCpuThreads}} | Measure-Object -Sum NumCpuSockets,NumCpuCores,NumCpuThreads
        ## return an object with info about VMHosts' CPU characteristics
        New-Object -Type PSObject -Property @{
            ClusterName = $oCluster.Name
            NumVMHosts = if ($mioCpuInfo) {$mioCpuInfo[0].Count} else {0}
            NumCpuSockets = ($mioCpuInfo | ?{$_.Property -eq "NumCpuSockets"}).Sum
            NumCpuCores = ($mioCpuInfo | ?{$_.Property -eq "NumCpuCores"}).Sum
            NumCpuThreads = ($mioCpuInfo | ?{$_.Property -eq "NumCpuThreads"}).Sum
        } ## end new-object
    } ## end foreach-object
} ## end scriptblock

& $sblkGetVMHostCpuInfo | ft -a ClusterName,NumVMHosts,NumCpuSockets,NumCpuCores,NumCpuThreads #>
