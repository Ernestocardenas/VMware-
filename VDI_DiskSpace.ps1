Connect-VIServer lfosat3012
$MyCollection = @()
$AllVMs = Get-View -ViewType VirtualMachine | Where {-not $_.Config.Template}
$SortedVMs = $AllVMs | Select *, @{N="NumDisks";E={@($_.Guest.Disk.Length)}} | Sort-Object -Descending NumDisks
ForEach ($VM in $SortedVMs){
$Details = New-object PSObject
$Details | Add-Member -Name Name -Value $VM.name -Membertype NoteProperty
$DiskNum = 0
Foreach ($disk in $VM.Guest.Disk){
$Details | Add-Member -Name "Disk$($DiskNum)path" -MemberType NoteProperty -Value $Disk.DiskPath
$Details | Add-Member -Name "Disk$($DiskNum)Capacity(GB)" -MemberType NoteProperty -Value ([math]::Round($disk.Capacity/ 1GB))
$Details | Add-Member -Name "Disk$($DiskNum)FreeSpace(GB)" -MemberType NoteProperty -Value ([math]::Round($disk.FreeSpace / 1GB))
$DiskNum++
}
$MyCollection += $Details
}
$MyCollection | Out-GridView
# Export-Csv, ConvertTo-Html or ConvertTo-Xml can be used above instead of Out-Gridview