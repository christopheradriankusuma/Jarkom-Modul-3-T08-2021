route add default gw 192.215.3.1

apt update
apt install apache2 php libapache2-mod-php7.0 zip unzip -y

unzip -o -d /etc apache.zip
unzip -o -d /var www.zip

a2ensite super.franky.t08.com

service apache2 restart