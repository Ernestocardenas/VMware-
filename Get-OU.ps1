<# $ComputerNames = @( 'TSOTRANR',
                    'trcl1' )
$info = @()
Get-Date
ForEach($Computer in $ComputerNames){
    $Computer = Get-WmiObject -Namespace 'root\directory\ldap' -Query "Select DS_cn,  DS_distinguishedName from DS_computer where DS_cn = '$Computer'";
    $info += $Computer | Select @{Expression = {$Computer.DS_cn} ; Label='Name'}, DS_distinguishedName 
    }
    $info | Format-Table -AutoSize

    #>

<#

$names = Get-Content "C:\temp\hostnames.txt"

foreach($name in $names){
$hs = $name
    $ADSPath = (([adsisearcher]“CN=$hs”).FindOne()).Path
    $ADSPath
}

#>

$hs = "uANOTRANR"
    $ADSPath = (([adsisearcher]“CN=$hs”).FindOne()).Path
    $ADSPath