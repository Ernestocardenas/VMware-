$names = Get-Content "C:\temp\bin\hostnames.txt"


foreach($computer in $names){

    Write-Host "Working on: $computer" -ForegroundColor Green
    
    Invoke-Command -ComputerName $computer -ScriptBlock {Set-Acl -Path 'C:\IBM\WinCollect\bin\WinCollectSvc.exe' -AclObject (Get-Acl -Path 'C:\Eterra\Distribution\FileUpdaterClient\IDMS_FileUpdaterClient.exe')}
   

    }