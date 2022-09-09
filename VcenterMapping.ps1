

$hostnames = @(
    #'prvcsa1',
    #'prvcsa2'#,
    #'prvcsd1',
    'pdvcsa3'
    
)


#$creds = Get-Credential
foreach($hostname in $hostnames){
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false

    Connect-VIServer -Server $hostname #-Credential $creds
    $Hosts = @()
    
    Get-VMHost | ForEach-Object{

    $Hostinfo = New-Object PSObject
        $Hostinfo | Add-Member -MemberType NoteProperty -Name EsxHost -Value $_.Name
        $Hostinfo | Add-Member -MemberType NoteProperty -Name EsxHostVersion -Value $_.Version
         $Hosts += $Hostinfo 

        }
   


    $Vcinfo = New-Object PSObject 

       $Vcinfo  | Add-Member -MemberType NoteProperty -Name Vcenter -Value ($global:DefaultVIServers | Select Name )
       $Vcinfo | Add-Member -MemberType NoteProperty -Name VcenterVersion -Value ($global:DefaultVIServers | Select Version )
       $Vcinfo | Add-Member -MemberType NoteProperty -Name Hosts -Value $Hosts
       

      
       $Vcinfo #| ConvertTo-Json | Out-File -FilePath C:\Temp\ESXScripts\VCmap.json -Append
       
      Disconnect-VIServer -Server * -Force -Confirm:$false
}

