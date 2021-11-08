echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install bind9 zip unzip -y

unzip -o -d /etc bind.zip
service bind9 restart