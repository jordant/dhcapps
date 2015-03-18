#!/bin/bash
EASY_RSA="/etc/openvpn/easy-rsa"
CLIENT_KEY_DIR="/home/dhc-user/openvpn-client-keys"
cd $EASY_RSA
source ./vars
./clean-all
$EASY_RSA/pkitool --initca
$EASY_RSA/pkitool --server openvpn
./build-dh

echo "creating client key"
$EASY_RSA/pkitool client

cp $EASY_RSA/keys/openvpn.key $EASY_RSA/keys/openvpn.crt $EASY_RSA/keys/dh1024.pem $EASY_RSA/keys/ca.crt /etc/openvpn/

IP_CIDR=`ip -o -f inet addr show eth0 | awk '/scope global/ {print $4}'`
IP_NETMASK=`ipcalc -n -b $IP_CIDR |egrep ^Netmask: |awk '{print $2}'`
IP_NETWORK=`ipcalc -n -b $IP_CIDR |egrep ^Network: |awk '{print $2}' | awk -F \/ '{print $1}'`

echo "push \"route $IP_NETWORK $IP_NETMASK\" " >> /etc/openvpn/server.conf

mkdir -p $CLIENT_KEY_DIR 
cp $EASY_RSA/keys/client.crt $EASY_RSA/keys/client.key /etc/openvpn/ca.crt $CLIENT_KEY_DIR
chown -R dhc-user.dhc-user $CLIENT_KEY_DIR

/etc/init.d/openvpn restart && touch /etc/openvpn/.ready
