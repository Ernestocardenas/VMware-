## Broker name
$HVServer = "dytsat3808"

## Domain of broker
$domain = "transmission.disp"
#$domain = "ps.psdmz"

## Pool being used as template
$templatePool = "VTOP547"

## Domain groups to add to pool
#$DAgroup = "Transmission\Domain Admins"
#$SAgroup = "Transmission\sa_VDI Admins"
#$OAgroup = "Transmission\System Operations - System Operators"
$DAgroup = "PS\Domain Admins"
$SAgroup = "PS\sa_VDI Admins"

#$creds = Get-Credential
$password = ConvertTo-SecureString '12654hgH' -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ('wxf0xeg', $password)

Connect-HVServer -Server $HVServer -Domain $domain -Credential $creds

$localpath = Split-Path -Parent $MyInvocation.MyCommand.Path
$params = Import-Csv "$localpath\EntList.csv"


$pools = Get-HVPool

foreach($pool in $pools){
    
    Set-HVPool -PoolName $pool.Base.Name -Spec "C:\Temp\vtop500.json" -Confirm:$false
    
    }

#Get-HVPool -PoolName "VTOP500" | Get-HVPoolSpec -FilePath "C:\Temp\vtop500.json"
#Set-HVPool -PoolName "VTOP500" -Spec "C:\Temp\vtop500.json" -Confirm:$false
#Set-HVPool -Pool $a -Key "desktopSettings.logoffSettings.automaticLogoffPolicy" -Value "AFTER" -
#Set-HVPool -Pool $a -Key "desktopSettings.logoffSettings.automaticLogoffMinutes" -Value 5

#Set-HVPool -Pool $a -Key "desktopSettings.logoffSettings.automaticLogoffMinutes" -Value 5
#$a.DesktopSettings.LogoffSettings.AutomaticLogoffPolicy | Get-Member | Format-Table
#$a.DesktopSettings.LogoffSettings | Get-Member | Format-Table
<#
foreach ($param in $params) {
    #$entName = $param.entName
    Write-Host "Working on: $param.Vmname" -ForegroundColor Green
   
    Get-HVPool -PoolName $templatePool | New-HVPool -PoolName $param.Vmname -PoolDisplayName $param.Vmname -VM $param.Vmname
   # New-HVEntitlement -User $DAgroup -Type Group -ResourceName $param.Vmname -Confirm:$false
   # New-HVEntitlement -User $SAgroup -Type Group -ResourceName $param.Vmname -Confirm:$false
    #New-HVEntitlement -User $OAgroup -Type Group -ResourceName $param.Vmname -Confirm:$false
   # New-HVEntitlement -User $entName -Type User -ResourceName $param.Vmname -Confirm:$false
    
    #Get-HVPool -PoolName $templatePool | New-HVPool -PoolName $param.Vmname -PoolDisplayName $param.Vmname -VM $param.Vmname
   # New-HVEntitlement -User $DAgroup -Type Group -ResourceName $param.Vmname -Confirm:$false
    #New-HVEntitlement -User $SAgroup -Type Group -ResourceName $param.Vmname -Confirm:$false
    #New-HVEntitlement -User $OAgroup -Type Group -ResourceName $param.Vmname -Confirm:$false
   # New-HVEntitlement -User $entName -Type User -ResourceName $param.Vmname -Confirm:$false

}
#>

<#
foreach ($param in $params) {
Write-Host "Working on: $param.Vmname" -ForegroundColor Green
$entName = $param.entName
    New-HVEntitlement -User $DAgroup -Type Group -ResourceName $param.Vmname -Confirm:$false
    New-HVEntitlement -User $SAgroup -Type Group -ResourceName $param.Vmname -Confirm:$false
    #New-HVEntitlement -User $OAgroup -Type Group -ResourceName $param.Vmname -Confirm:$false
    #New-HVEntitlement -User $entName -Type User -ResourceName $param.Vmname -Confirm:$false
   }
   #>

Disconnect-HVServer -Server * -Force -Confirm:$false

#>