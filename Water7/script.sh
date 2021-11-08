echo "nameserver 192.215.2.2" > /etc/resolv.conf
echo "nameserver 192.168.122.1" >> /etc/resolv.conf

apt update
apt install squid zip unzip apache2-utils -y

htpasswd -bc /etc/squid/htpasswd luffybelikapalt08 luffy_t08
htpasswd -b /etc/squid/htpasswd zorobelikapalt08 zoro_t08

unzip -o -d /etc squid.zip
service squid restart