Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false

$localpath = Split-Path -Parent $MyInvocation.MyCommand.Path
$params = Import-Csv "$localpath\params.csv"
#$creds = Get-Credential

## vCenter where the VM is to be built
$VC = "lfosat3003.transmission.disp"
#$VC = "lfosat3012.ps.psdmz"


Connect-VIServer -Server $VC -User "administrator@vsphere.local" -Password "W3rt0p@dm1n52"

foreach ($param in $params) {
    
    ## Configure VM network settings

    $CustSpec = Get-OSCustomizationSpec -Name $param.CustSpecName

    $IP = @{OScustomizationNicMapping = Get-OSCustomizationNicMapping -OSCustomizationSpec $CustSpec }
    $IP.IPMode = "UseStaticIP"
    $IP.IPAddress = $param.VMIP
    $IP.SubnetMask = $param.VMSubnetMask
    $IP.DefaultGateway = $param.VMDefaultGW
    $IP.dns = $param.DNSServer1, $param.DNSServer2
 
    Set-OSCustomizationNicMapping @IP
 
    ## Deploy VM
 
    $NewVM = New-VM -Name $param.VMname -Template $param.VCTemplate `
        -VMHost $param.VMHost `
        -Datastore $param.Datastore `
        -OSCustomizationSpec $CustSpec `
        -ErrorAction Stop 

    Get-VM $param.VMname | Get-NetworkAdapter | Set-NetworkAdapter -Portgroup $param.Portgroup -confirm:$false | Out-Null
     Get-VM $param.VMname | Get-NetworkAdapter | Set-NetworkAdapter -StartConnected:$true -confirm:$false | Out-Null
 
    ## Power UP VM 

    Start-VM $param.VMname

}
Disconnect-VIServer -Server * -Force -Confirm:$false
