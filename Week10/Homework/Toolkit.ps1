# Description: Setting up an incident respone toolkit
# Needed are theses 6 tasks 
#1. Running Processes and the path for each process.
#2. All registered services and the path to the executable controlling the service (you'll need to use WMI).
#3. All TCP network sockets
#4. All user account information (you'll need to use WMI)
#5. All NetworkAdapterConfiguration information.
#6. Use Powershell cmdlets to save 4 other artifacts that would be useful 
#
# Other needs 
#
#+ Create a prompt that asks the user for the location of where to save the results for the commands above.
#
#+ Select a way to use at least one function within your code.
#
#+ Find the Powershell cmdlet that can create a 'FileHash' of the resulting CSV files, create a checksum for
#  each one, and save the results to a file within the results directory.  The file containing checksums should
#  have the filename and the corresponding checksum.


#1. Getting the running processes.
function running_processes (){
    


Get-Process | Select-Object ProcessName, Path, ID | `
Export-Csv -Path "C:\Users\$env:UserName\$location\myprocesses.csv" -NoTypeInformation 

Get-FileHash C:\Users\$env:UserName\$location\myprocesses.csv| Add-Content "$location\hashes.txt"


}

#2. Getting all registarted services and the path to the executable controlling the service
function get_services (){

Get-WmiObject win32_service | select Name, DisplayName, @{Name="Path"; Expression={PathFromServicePathName $_.PathName}} | Format-List |
Export-Csv -Path "C:\Users\$env:UserName\$location\Services.csv" -NoTypeInformation

Get-FileHash C:\Users\$env:UserName\$location\Services.csv| Add-Content "$location\hashes.txt"

}

#3. All TCP network sockets
function TCP_sockets (){

Get-NetTCPConnection | select-object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess |
Export-Csv -Path "C:\Users\$env:UserName\$location\TCPportsListening.csv" -NoTypeInformation

Get-FileHash C:\Users\$env:UserName\$location\TCPportsListening.csv| Add-Content "$location\hashes.txt"

}

#4. All user account information (you'll need to use WMI)
function user_acc (){

Get-WmiObject -Class Win32_Account | Get-Member |

Export-Csv -Path "C:\Users\$env:UserName\$location\User Account Info.csv" -NoTypeInformation

Get-FileHash "C:\Users\$env:UserName\$location\User Account Info.csv"| Add-Content "$location\hashes.txt"

}


#5. All NetworkAdapterConfiguration information.
function network_adapters (){

Get-WmiObject -Class Win32_NetworkAdapterConfiguration |

Export-Csv -Path "C:\Users\$env:UserName\$location\Networkadapters.csv" -NoTypeInformation

Get-FileHash "C:\Users\$env:UserName\$location\Networkadapters.csv"| Add-Content "$location\hashes.txt"

}


#6. Use Powershell cmdlets to save 4 other artifacts that would be useful
#   a. The extra cmdlets will be getting all users
#   b. grabbing the 40 newest logs
#   c. Checking cmd history 
#   d. Check update history
function additional_reqs (){

#a. The extra cmdlets will be getting all users

Get-WMIObject -class Win32_ComputerSystem | select username |
Export-Csv -Path "C:\Users\$env:UserName\$location\Logged in users.csv" -NoTypeInformation

Get-FileHash "C:\Users\$env:UserName\$location\Logged in users.csv"| Add-Content "$location\hashes.txt"

#b. grabbing the 40 newest system logs

Get-EventLog -LogName System -Newest 40 |
Export-Csv -Path "C:\Users\$env:UserName\$location\40 Newest logs.csv" -NoTypeInformation

Get-FileHash "C:\Users\$env:UserName\$location\40 Newest logs.csv"| Add-Content "$location\hashes.txt"

#c. Checking cmd history 
   
Get-History | select Id, CommandLine, ExecutionStatus, StartExecutionTime, EndExecutionTime |

Export-Csv -Path "C:\Users\$env:UserName\$location\CMD line history.csv" -NoTypeInformation

Get-FileHash "C:\Users\$env:UserName\$location\CMD line history.csv"| Add-Content "$location\hashes.txt"

#d. Checking updates 

get-wmiobject -class win32_quickfixengineering |
Export-Csv -Path "C:\Users\$env:UserName\$location\Updates.csv" -NoTypeInformation

Get-FileHash "C:\Users\$env:UserName\$location\Updates.csv"| Add-Content "$location\hashes.txt"

}

# Function to call all other functions as well as ask where files should be saved


function tool_kit (){

# asking for file location 
$filelocation = Read-Host -Prompt "please enter where you would like this data save to." 

$location = "$filelocation"

#creating the file under a user
New-Item -Path "C:\Users\$env:UserName\$location" -ItemType Directory

running_processes

get_services 

TCP_sockets

user_acc

network_adapters

additional_reqs

# Get a hash of the file and add that hash to a txt file
Get-FileHash -Path C:\Users\$env:UserName\$location | Add-Content "$location\hashes.txt"


#Compressing the results file
Compress-Archive -LiteralPath $location -DestinationPath "C:\Users\$env:UserName\Desktop\results.zip"

# Get a hash of the resulting zip file
Get-FileHash "C:\Users\$env:UserName\Desktop\results.zip" | Add-Content "C:\Users\$env:UserName\Desktop\ZipResults_checksum.txt"
}

tool_kit 
