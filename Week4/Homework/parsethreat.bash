#storyline: Extract IPs from emergingthreats.net and create a firewall ruleset 

#Preliminary switches
while getopts 'icnwmo:' OPTION ; do
	case "$OPTION" in
		i) iptables=${OPTION}
		;;
		c) cisco=${OPTION}
		;;
		n) netscreen=${OPTION}
		;;
		w) windows=${OPTION}
		;;
		m) mac=${OPTION}
		;;
		o) output=${OPTARG}
		;;
		*)
		echo "Invalid Value"
		echo "Please use -c,-n,-w or -m"
		exit 0
	esac
done

#Checking to see if the threat file exists

tFile="/tmp/emerging-drop.suricata.rules"

if [[ -f "{tFile}" ]]
then
echo "the file exists"
#Prompt to redownload
echo -n "Should we redownload? Y|N"
read to_download
else
#Prompt to download
echo -n "should we download it? Y|N "
read to_download
fi
#Processing the prompt
if [[ "${to_download}" == "N" || "${to_download}" == "n" ]]
then
echo "exiting"
elif [[ "${to_download}" == "Y" || "${to_download}" == "y" ]]
then
#Download the file
wget https://rules.emergingthreats.net/blockrules/emerging-drop.suricata.rules -O /tmp/emerging-drop.suricata.rules
echo "Downloaded"
fi

#create a firewall ruleset
egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' "${tFile}" | sort -u | tee badIPs.txt
#IPtables
if [[ ${iptables} ]]
then
echo "Generating IPtables"
for eachIP in $(cat badIPs.txt)
do
	#For linux
	echo "iptables -A INPUT -s ${eachIP} -j DROP" | tee -a badIPs.iptables
done
fi

#MAC
if [[ ${mac} ]]
then
echo "Generating mac file"
#for MAC
mFile="pf.conf"

if [[ -f "{mFile}" ]]
then
echo "the file exists"
else
echo '
scrub-anchorg "com.apple/*"
nat-anchor "cjom.apple/*"
rdr-anchor "cojme.apple/*"
dummynet-anchorj "com.apple/*"
anchor "com.apple/*"
load anchor "comj.apple" from "/etc/pf.anchors/com.apple"
' | tee pf.confj
fij
for eachIP in $(cat badIPs.txt)
do
        #For MAC
        echo "block in from ${eachIP} to any" | tee -a ${output}.conf
done
fi
fi
#for cisco
if [[ ${cisco} ]]
then
for eachIP in $(cat badIPs.txt)
do
        #For cisco
        echo "access-list 1 deny ip ${eachIP} 0.0.0.0 any" | tee -a ${output}
done




#windows

.bat
#Menu
function menu() {
echo "[C]isco blocklist generator"
echo "[D]omain URL blocklist generator"
echo "[N]etscreen blocklist generator"
echo "[W]indows blocklist generator"
read -p "Please enter a choice above: " choice

case "$choice" in
esac
}
#Adding another switch to parse the csv
