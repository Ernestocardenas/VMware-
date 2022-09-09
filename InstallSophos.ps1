$names = Get-Content "C:\temp\bin\hostnames.txt"


foreach($computer in $names){

    Write-Host "Working on: $computer" -ForegroundColor Green
    $session = New-PSSession -ComputerName $computer
    Copy-Item -Path 'C:\Temp\bin\DTY978_10.8.9.2.exe' -ToSession $session -Destination 'c:\temp\DTY978_10.8.9.2.exe' -Force
   
    Start-Process 'c:\temp\DTY978_10.8.9.2.exe' -ArgumentList '--quiet' -Wait
    Move-Item -Path 'c:\temp\DTY978_10.8.9.2.exe'    

    }