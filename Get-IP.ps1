
$hostnames = Get-Content "C:\Temp\GetIP\hostnames.txt"

$info =@()


foreach($device in $hostnames){
    
    try{

        $IP = [System.Net.Dns]::GetHostAddresses("$device").IPAddressToString

        $obj = New-Object PSObject
      
            $obj | Add-Member -MemberType NoteProperty -Name "Hostname" -Value $device
            $obj | Add-Member -MemberType NoteProperty -Name "IP" -Value $IP

        $info += $obj
        }
    catch{
        $obj = New-Object PSObject
      
            $obj | Add-Member -MemberType NoteProperty -Name "Hostname" -Value $device
            $obj | Add-Member -MemberType NoteProperty -Name "IP" -Value ""

        $info += $obj
        }

}

$info | Select * | Export-Csv "C:\Temp\GetIP\655Ips.csv" -NoTypeInformation