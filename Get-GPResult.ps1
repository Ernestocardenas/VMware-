
$names = Get-Content "C:\temp\bin\hostnames.txt"
 
    
    


foreach($computer in $names){
    Write-Host "Working on: $computer" -ForegroundColor Green
    
  
    $fname = "C:\temp\bin\GPResults\" + $computer + "_GPResult.html"
    gpresult /s $computer /h "$fname" /scope:Computer

    }