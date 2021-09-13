#!/bin/bash

#storyline create peer vpn config file

# Peer name

echo - n "what is the Peer's name?"

read the_client



# FileName variable

pFile="${the_client}-wg0.conf"



#if then else

if [[ -f "${pFile}" ]]

then



#prompt if we need to overwrite

echo "the file ${pFile} exists."

echo -n "Do you want to overwrite it? [y|N]"

read to_overwrite



if [[ "$to_overwrite}" == "N" || "${to_overwrite}" == "n" ]]

then

echo "Exit..."

exit 0



elif [[ "${to_overwrite}" == "y" ]]

then

echo "creating the wireguard Config file..."



# invalid value

else

echo "Invalid Value"

exit 1



fi

fi



#Generate private key

p="$(wg genkey)"



#Generate public key

clientPub="$(echo ${p} | wg pubkey)"


#Generate preshared key

pre="$(wg genpsk)"


# Endpoint

end="$(head -1 wg0.conf | awk ' { print $3 } ' ) "



#server public key

pub="$(head -1 wg0.conf | awk ' { print $4 } ' ) "




#dns

dns="$(head -1 wg0.conf | awk ' { print $5 } ' ) "



#MTU

mtu="$(head -1 wg0.conf | awk ' { print $6 } ' ) "



#KeepAlive

keep="$(head -1 wg0.conf | awk ' { print $7 } ' ) "



#listenPort

lport="$(shuf -n1 -i 40000-50000)"



# Defualt routs for VPN

routes="$(head -1 wg0.conf | awk ' { print $8 } ' ) "



# create the client config file



echo "[Interface]
Address = 10.254.132.100/24
DNS = ${dns}
ListenPort = ${lport}
MTU = ${mtu}
PrivateKey = ${p}
[peer]
AllowedIPs = ${routes}
PeersistentKeppAlive = ${keep}
preshared key = ${pre}
Public key = ${pub}
Endpoint = ${end}
" > ${pFile}

#append Peer Config to server config

echo "
# begin
[Peer]
Publickey = ${clientPub}
PreSharedKey = ${pre}
AllowedIPs = 10.254.132.100/32
# end
" | tee -a wg0.conf
