#!/bin/bash



# Storyline: script to create a wireguard server



if [[ -f "$wg0.conf" ]]
then
echo -n "The file already exists, do you want to overwrite it? Y|N"
read to_overwrite

if [[ "${to_overwrite}" == "N" || "${to_overwrite}" == "n" ]]
then
echo "Exiting....."
exit 0

elif [[ "${to_overwrite}" == "Y" || "${to_overwrite}" == "y" ]]
then
echo "creating file..."
fi
fi
# Create private key

p="$(wg_genkey)"



# create public key

pub="$(echo ${p} | wg_pubkey)"



# Set the addresses

address="10.254.132.0/24,172.16.28.0/24"



# Set server Ip addresses

ServerAddress="10.254.132.1/24,172.16.28.1/24"





# Set the listeing port

lport="4282"



# creata the format for the client config file

peerInfo="# ${address} 198.199.97.163:4282 ${pub} 8.8.8.8,1.1.1.1 1280 120 0.0.0.0/0"





echo "${peerInfo}
[Interface]
Address = ${ServerAddress}
# PostUP = /etc/Wireguard/wg-up.bash
# PostDown = /etc/Wireguard/wg-down.bash
ListenPort = ${lport}
PrivateKey = ${p}
" > wg0.conf
