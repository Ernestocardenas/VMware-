$names = Get-Content "C:\temp\bin\hostnames.txt"

foreach($computer in $names){
    
    Invoke-Command -ComputerName $computer -ScriptBlock{
        Get-ChildItem -Path "C:\Temp\" -Recurse |  Remove-Item -Recurse -Force -Confirm:$false
        }
}