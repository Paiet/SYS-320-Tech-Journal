#Description: Use the Get-WMI cmdlet
#Get-WmiObject -Class Win32_service | Select Name, PathName, ProcessID

#Get-WmiObject -List | Where { $_.Name -ilike "Win32_[n-o]*" } | Sort-Object

#Get-WmiObject -Class Win32_Account | Get-Member

#Task: Grab the network adapter information using the WMI class
#Get the IP address Default gateway, and DNS servers
#Bonus: get the DHCP server
#Post code to github 
#Running your code using a screen recorder

# Getting the Network configurations for network adapter Netwtw06
# pulling the IP address Default gateway, and DNS server and DHCP
# also added the Description so that if it was on a different type of machine than normal I would know
Get-WmiObject -Class Win32_NetworkAdapterConfiguration | where {$_.ServiceName -eq "Netwtw06"} `
| Select IPAddress, DefaultIPGateway, DNSServerSearchOrder, DHCPServer, Description
