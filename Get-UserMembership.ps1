
(New-Object System.DirectoryServices.DirectorySearcher("(&(objectCategory=User)(samAccountName=$("rxf02qg")))")).FindOne().GetDirectoryEntry().memberOf
#$a = 
#(New-Object System.DirectoryServices.DirectorySearcher("(&(objectCategory=User)(name=$("Michael Cottingham")))")).FindOne().GetDirectoryEntry().sAMAccountName 
#(New-Object System.DirectoryServices.DirectorySearcher("(&(objectCategory=User)(name=$("William Fernandez")))")).FindOne().GetDirectoryEntry()
#$a.properties.GetDirectoryEntry().memberOf
#$a = ([adsisearcher]“CN=Corp Admin”).FindAll()
#([adsisearcher]“CN=Tripwire-Reports”).FindOne().Properties.member
#(([adsisearcher]“CN=8xa0lhx”).FindOne()).Path


#10.90.167.164
#FindOne().Properties #.GetDirectoryEntry().memberOf

#Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |   Select-Object DisplayName, InstallDate | Format-Table –AutoSize


