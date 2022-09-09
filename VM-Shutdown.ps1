########### VM Shutdown Script ###########
##This script will shutdown all VMs in a given vCenter

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false


##command to prompt user to enter credentials 
$creds = Get-Credential

##vCenter name of which to shutdown all VMs 
$vCenter = ""

Connect-VIServer -Server $vCenter -Credential $creds

##this will work for all VMs with VMware tools installed
Get-VM | where {$_.PowerState -eq "PoweredOn"} | Shutdown-VMGuest

##uncomment the line below and comment the line above after to check if there are any VMs still powered on since they do not have VMware tools installed
#Get-VM | where {$_.PowerState -eq "PoweredOn"} 

##uncomment the line below if there are VMs still powered on to shut them down
#Get-VM | where {$_.PowerState -eq "PoweredOn"} | Stop-VM

Disconnect-VIServer -Server * -Force -Confirm:$false
