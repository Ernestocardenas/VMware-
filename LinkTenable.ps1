$names = Get-Content "C:\temp\bin\hostnames.txt"
 

foreach($computer in $names){
    Write-Host "Working on: $computer" -ForegroundColor Green
   Invoke-Command -ComputerName $computer -ScriptBlock { net stop "Tenable Nessus Agent" }
   Invoke-Command -ComputerName $computer -ScriptBlock {Remove-ItemProperty -Path 'HKLM:\Software\Tenable' -Name 'TAG'}
   Invoke-Command -ComputerName $computer -ScriptBlock {net start "Tenable Nessus Agent" }
   Invoke-Command -ComputerName $computer -ScriptBlock { C:\Progra~1\Tenable\Nessus~1\nessuscli.exe agent link --key=68dc41b5b312af946d85f18886c5d70c43cd599e760cba998f11e4a3d989fee3 --port=8834 --host=10.90.65.191 --groups:SupportVDI}


    }