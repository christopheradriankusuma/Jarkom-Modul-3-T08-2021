echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install isc-dhcp-server zip unzip -y

unzip -o -d dhcp.zip /etc
unzip -o -d default.zip /etc

service isc-dhcp-server restart