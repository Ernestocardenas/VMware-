###################################
#                                 #  
#  Entitlements.ps1 instructions  #
#                                 #
###################################


# Script create VDI pools for VDIs and add entitlements given paramaters from a csv file

Steps: 
	1. Fill in the EntList.csv file with the desired configuration settings. The required values are as follows: 
		- Vmname:  	
		- entName: 
	2. Open the script and edit the following variable values:
		- $HVServer: Name of the broker to connect to
		- $domain: Domain of the broker
		- $templatePool: name of manually created pool that is to be used as a template
		- $DAgroup: Domain Admins group (i.e. ps.psdmz\Domain Admins)
		- SAgroup: VDI Admins group (i.e. ps.psdmz\sa_VDI Admins)
	3. Save script
	4. Run script
	5. Enter credentials for VDI broker when prompted
	6. Sit back and enjoy automation 
	7. You're welcome
