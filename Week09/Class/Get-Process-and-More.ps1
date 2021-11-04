# Description: Using Get-proccess and Get-service

# Getting procccesses that are running then exporeting them to csv

Get-Process | Select-Object ProcessName, Path, ID | `
Export-Csv -Path "C:\Users\Paiet\Desktop\myprocesses.csv" -NoTypeInformation

# Getting services and exporting to csv

Get-Service | Where { $_.Status -eq "Running" } | `
Export-Csv -Path "C:\Users\Paiet\Desktop\myservices.csv" -NoTypeInformation


# Specifically targetting one process 
#ps | where { $_.ProcessName -eq "Chrome" } | select ProcessName, ID, Path

# use Get-Help to get help and it will take you down the path to help figure out what you want
