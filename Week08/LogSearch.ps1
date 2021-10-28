 # Description : Review the Security event Log

 # List all the available windows event logs

 Get-EventLog -List

 # Create a prompt to allow a user to selec the log view

 $readLog = Read-Host -Prompt "Please select a log to review from the list above"
 
 
 # Create a prompt that allows the user to specify a keyword or phrase to search on
$readPhrase = Read-Host -Prompt "Please select a keyword or phrase to search on"

 # Print the resuslts of the logs

 Get-EventLog -LogName $readLog -Newest 40 | where {$_.Message -ilike "*$readPhrase*" } | Export-Csv -NoTypeInformation `
 -Path "C:\Users\Daedalus\Desktop\securityLogs.csv" 

 # Task: Create a prompt that allows user to specify a Keywork or phrase to search on.
 # Find a string from your event logs to search on 
 # solution bellow and that is pumped in as a variable in the print results statement above
