# Jarkom-Modul-3-T08-2021

Laporan Resmi Praktikum Jarkom Modul 3

Disusun oleh :
* Clarissa Fatimah (05311940000012)
* Alessandro Tionardo (05311940000018)
* Christoper Adrian Kusuma (05311940000022)

---

## 1. Luffy bersama Zoro berencana membuat peta tersebut dengan kriteria EniesLobby sebagai DNS Server, Jipangu sebagai DHCP Server, Water7 sebagai Proxy Server (1), Susun topologi sesuai dengan permintaan soal shift, dan mengatur konfigurasi jaringan pada setiap node.
![Soal 1-1](images/1.1.png)

### Solusi
Pada EniesLobby lalukan install :
```
apt-get install bind9 -y
```
Lalu dengan *nano /etc/bind/named.conf.local*, tambahkan 
```
zone "super.franky.t08.com" {
        type master;
        file "/etc/bind/web/super.franky.t08.com";
};

zone "jualbelikapal.t08.com" {
        type master;
        file "/etc/bind/proxy/jualbelikapal.t08.com";
};
```
![Soal 1-2](images/1.2.png)
<br>

lalu membuat folder web pada `/etc/bind/` dengan
`mkdir /etc/bind/web`
lalu copykan file db.local pada path `/etc/bind` ke dalam folder web 
`cp /etc/bind/db.local /etc/bind/web/super.franky.t08.com`
Kemudan konfigurasi file <b>super.franky.t08.com</b>
<br>
![Soal 1-3](images/1.3.png)
<br>

Pada Jipangu lakukan install : 
```
apt-get install isc-dhcp-server
```
Lalu melakukan konfigurasi dengan `nano /etc/default/isc-dhcp-server`
Pada bagian INTERFACES isikan `eth0
INTERFACES="eth0"`
![Soal 1-4](images/1.4.png)
<br>

Pada Water7 melakukan install :
```
apt-get install squid
```
Buat konfigurasi Squid baru Pada file `/etc/squid/squid.conf
http_port 5000
visible_hostname jualbelikapal.t08.com`
<br>
![Soal 1-5](images/1.5.png)

## 2. dan Foosha sebagai DHCP Relay (2). Luffy dan Zoro menyusun peta tersebut dengan hati-hati dan teliti.
pada foosha lakukan install :
```
apt-get install isc-dhcp-relay
```
lalu dengan `nano /etc/default/isc-dhcp-relay`
![Soal 2-1](images/2.1.png)
menambahkan `SERVERS=”192.215.2.4"` dalam DHCP relay forward
menambahkan `INTERFACES=”eth1 eth3”` dalam interface DHCP relay request

## 3. Semua client yang ada HARUS menggunakan konfigurasi IP dari DHCP Server. Client yang melalui Switch1 mendapatkan range IP dari [prefix IP].1.20 - [prefix IP].1.99 dan [prefix IP].1.150 - [prefix IP].1.169
Edit file konfigurasi `/etc/dhcp/dhcpd.conf pada subnet 192.215.1.0` dengan menambahkan range 
```
range 192.215.1.20 192.215.1.99;
range 192.215.1.150 192.215.1.169;
```
![Soal 3-1](images/3.1.png)

## 4. Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.30 - [prefix IP].3.50
Edit file konfigurasi `/etc/dhcp/dhcpd.conf pada subnet 192.215.3.0` dengan menambahkan range 
```
range 192.215.3.30 192.215.3.50;

```
![Soal 4-1](images/4.1.png)

## 5. Client mendapatkan DNS dari EniesLobby dan client dapat terhubung dengan internet melalui DNS tersebut.

Melakukan edit file konfigurasi `/etc/dhcp/dhcpd.conf(subnet 192.215.1.0 dan 192.215.3.0) ` pada `option domain-name-servers` sesuai dengan <b>IP EniesLobby</b>
![Soal 5-1](images/5.1.png)

## 6. Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch1 selama 6 menit sedangkan pada client yang melalui Switch3 selama 12 menit. Dengan waktu maksimal yang dialokasikan untuk peminjaman alamat IP selama 120 menit.
Melakukan edit file konfigurasi `/etc/dhcp/dhcpd.conf(subnet 192.215.1.0 dan 192.215.3.0) `pada <b>default-lease-time</b> dan <b>max-lease-time</b>
```
subnet 192.215.1.0
```
![Soal 6-1](images/6.1.png)

```
subnet 192.215.3.0
```
![Soal 6-2](images/6.2.png)



## 7. Luffy dan Zoro berencana menjadikan Skypie sebagai server untuk jual beli kapal yang dimilikinya dengan alamat IP yang tetap dengan IP [prefix IP].3.69 .

### Solusi
Pertama-tama melakukan konfigurasi isc-dhcp-server pada *Jipangu* dengan membuka dan edit file dengan perintah.

```nano /etc/dhcp/dhcpd.conf```

Lalu menambahkan konfigurasi berikut.

![Soal 7-1](images/7_1.png)

Lalu restart service “isc-dhcp server” pada *Jipangu*. Selanjutnya pada *Skypie* tambahkan konfigurasi seperti dibawah ini dimana hwaddress ether ini untuk mencegah bergantinya hwaddress saat project GNS3 dimatikan atau diexport.

![Soal 7-2](images/7_2.png)

Lalu lakukan restart node *Skypie*.dan periksa ip skypie dengan `ip a`.

![Soal 7-3](images/7_3.png)



## 8. Loguetown digunakan sebagai client Proxy agar transaksi jual beli dapat terjamin keamanannya, juga untuk mencegah kebocoran data transaksi.Pada Loguetown, proxy harus bisa diakses dengan nama `jualbelikapal.yyy.com` dengan port yang digunakan adalah 5000.

### Solusi
Pada *Water7* melakukan konfigurasi server proxy pada `/etc/squid/squid.conf` dengan memasukan script :

![Soal 8-1](images/8_1.png)

Lalu melakukan `service squid restart`. Selanjutnya pada Loguetown melakukan settingan proxy pada client. Pertama-tama dengan melakukan script berikut : 

![Soal 8-2](images/8_2.png)

Untuk memeriksa apakah konfigurasi proxy pada client berhasil, silakan lakukan perintah `env | grep -i proxy`. Apabila berhasil, maka environment kita telah berhasil menggunakan proxy.

![Soal 8-3](images/8_3.png)



## 9. Agar transaksi jual beli lebih aman dan pengguna website ada dua orang, proxy dipasang autentikasi user proxy dengan enkripsi MD5 dengan dua username, yaitu `luffybelikapalyyy` dengan password `luffy_yyy` dan `zorobelikapalyyy` dengan password `zoro_yyy` 


### Solusi

Buat user dan password baru

`htpasswd -bc /etc/squid/htpasswd luffybelikapalt08`

dengan password 

`luffy_t08`

Buat user dan password baru

`htpasswd -b /etc/squid/htpasswd zorobelikapalt08`

dengan password 

`zoro_t08`


![Soal 9-1](images/9_1.png)

Dapat di cek pada `/etc/squid/htpasswd`

![Soal 9-2](images/9_2.png)

Lalu melakukan config pada `/etc/squid/squid.conf` dengan menambahkan line seperti berikut : 

![Soal 9-3](images/9_3.png)

Lalu melakukan `service squid restart`. Dapat terlihat saat melakukan koneksi dibutuhkan autentikasi dari user

![Soal 9-4](images/9_4.png)


## 10. Transaksi jual beli tidak dilakukan setiap hari, oleh karena itu akses internet dibatasi hanya dapat diakses setiap hari Senin-Kamis pukul 07.00-11.00 dan setiap hari Selasa-Jum’at pukul 17.00-03.00 keesokan harinya (sampai Sabtu pukul 03.00).

### Solusi

Buat file baru bernama `acl.conf` di direktori `/etc/squid`. Lalu isi file tersebut dengan line dibawah ini.

![Soal 10_1](images/10_1.png)

Lalu melakukan config pada `/etc/squid/squid.conf` dengan menambahkan line seperti berikut : 

![Soal 10_2](images/10_2.png)

Lalu melakukan `service squid restart`

## 11. Agar transaksi bisa lebih fokus berjalan, maka dilakukan redirect website agar mudah mengingat website transaksi jual beli kapal. Setiap mengakses `google.com`, akan diredirect menuju `super.franky.yyy.com` dengan website yang sama pada soal shift modul 2. Web server `super.franky.yyy.com` berada pada node Skypie.


### Solusi
Pertama-tama melakukan config pada `/etc/squid/squid.conf` dengan menambahkan line seperti berikut :

![Soal 11_1](images/11_1.png)

Lalu melakukan `service squid restart`. Selanjutnya mencoba membuka `google.com` dengan lynx pada *Loguetown*.

![Soal 11_2](images/11_2.png)

Dapat telihat bahwa website `google.com` akan langsung di redirect ke `super.franky.t08.com`.

## 12. Saatnya berlayar! Luffy dan Zoro akhirnya memutuskan untuk berlayar untuk mencari harta karun di `super.franky.yyy.com`. Tugas pencarian dibagi menjadi dua misi, Luffy bertugas untuk mendapatkan gambar (.png, .jpg), sedangkan Zoro mendapatkan sisanya. Karena Luffy orangnya sangat teliti untuk mencari harta karun, ketika ia berhasil mendapatkan gambar, ia mendapatkan gambar dan melihatnya dengan kecepatan 10 kbps.

### Solusi
Pertama-tama kita membuat sebuah file baru pada `/etc/squid` yaitu `acl-bandiwth.conf`. Dengan isi file seperti dibawah ini.

![Soal 12_1](images/12_1.png)

Selanjutnya kita menambah beberapa konfigurasi pada `/etc/squid/squid.conf`. Dapat dilihat beberapa konfigurasi dibawah ini yang berupa.

![Soal 12_2](images/12_2.png)

Selanjutnya kita dapat melakukan test pada *loguetown* dan *tottoland* yang dimana kita bagi kedua delay pools. *Loguetown* untuk luffy dan *tottoland* untuk zoro. Dapat dilihat dibawah ini saat kita melakukan test pada area *loguetown*.

![Soal 12_3](images/12_3.png)

## 13. Sedangkan, Zoro yang sangat bersemangat untuk mencari harta karun, sehingga kecepatan kapal Zoro tidak dibatasi ketika sudah mendapatkan harta yang diinginkannya.

### Solusi
Dengan Konfigurasi pada soal no.12, dapat kita lihat pada delay pools, zoro tidak memiliki pembatasan bandwith sehingga download speednya berjalan dengan normal, berikut merupakan hasil yang didapatkan saat melakukan speedtest pada *tottoland*

![Soal 13_1](images/13_1.png)

<hr>

## Kendala

- Tidak Ada
