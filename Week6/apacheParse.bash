#!/bin/bash

# Description: Parses given log file and formats it nicely

# Parse Apache log
# What it would look like "101.236.44.127 - - [24/Oct/2017:04:11:14 -0500] "GET / HTTP/1.1" 200 255 "-" "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36"

# Read in file

#Arguments using the position 

APACHE_LOG="$1"

#Checking if file exists

if [[ ! -f ${APACHE_LOG} ]]
then
	echo "File does not exist"
	exit 1 
fi

# Looking for web scanners

sed -e "s/\[//g" -e "s/\"//g" ${APACHE_LOG} | \
egrep -i "test|shell|echo|passwd|select|phpmyadmin|setup|admin|w00t" | \
awk ' BEGIN { format ="%-15s %-20s %-7s %-6s %-10s %s\n" 
			printf format, "IP", "Date", "Method", "Status", "Size", "URI"
			printf format, "--", "----", "------", "------", "----", "---" } 
# printing the format into tha log fike.txt
{ printf format, $1, $4, $6, $9, $10, $7 } ' | tee -a logfile.txt 
   
egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' logfile.txt | sort -u | tee badIPs.txt

for eachIP in $(cat badIPs.txt)
do

	echo "netsh advfirewall firewall add rule name=\"IP Block\" dir=in interface=any action=block remoteip= ${eachIP} " | tee -a badIPS.windows

done

for eachIP in $(cat badIPs.txt)
do

	echo "iptables -A INPUT -s ${eachIP} -j DROP" | tee -a badIPtable.txt




done
