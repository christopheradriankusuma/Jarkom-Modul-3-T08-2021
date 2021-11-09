echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install isc-dhcp-server zip unzip -y

unzip -o -d /etc dhcp.zip
unzip -o -d /etc default.zip

service isc-dhcp-server restart