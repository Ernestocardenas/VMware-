##################################
#                                #  
#   Build-VDI.ps1 instructions   #
#                                #
##################################


# Script will build VMs in the specified vCenter given paramaters from a csv file

Steps: 
	1. Fill in the params.csv file with the desired configuration settings. The required values are as follows: 
		- VCTemplate: name of template used to clone VMs 	
		- VMname: VM name in vCenter and hostname of guest OS machine	
		- VMIP: Primary IP address	
		- VMSubnetMask: Subnet mask for primary NIC	
		- VMDefaultGW: Default gateway for primary NIC	
		- DNSServer1: Primary DNS server for primary NIC	
		- DNSServer2: Secondary DNS server for primary NIC	
		- VMHost: ESXi host where the VM will be built	
		- Datastore: Name of datastore for VM	
		- Portgroup: Port group name for VM	
		- CustSpecName: Name of VM Customization Spec to use for the VM
	2. Change value of variable $VC to the name of the vCenter where you want to build the VM
	3. Save script
	4. Run script
	5. Enter credentials for vCenter when prompted
	6. Sit back and enjoy automation 
	7. You're welcome