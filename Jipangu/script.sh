echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install isc-dhcp-server -y