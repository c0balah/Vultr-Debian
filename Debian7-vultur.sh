#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

 red='\e[1;31m'
               green='\e[0;32m'
               NC='\e[0m'
			   
               echo "Connecting to rasta-server.net..."
               sleep 1
               
			   echo "Checking Permision..."
               sleep 1
               
			   echo -e "${green}Permission Accepted...${NC}"
               sleep 1
			   
flag=0

if [ $USER != 'root' ]; then
	echo "Anda harus menjalankan ini sebagai root"
	exit
fi

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;

if [[ -e /etc/debian_version ]]; then
	#OS=debian
	RCLOCAL='/etc/rc.local'
else
	echo "Anda tidak menjalankan script ini pada OS Debian"
	exit
fi

vps="VPS";

if [[ $vps = "VPS" ]]; then
	source="https://raw.githubusercontent.com/yusuf-ardiansyah/new"
else
	source="https://raw.githubusercontent.com/yusuf-ardiansyah/new"
fi

# go to root
cd

MYIP=$(wget -qO- ipv4.icanhazip.com);

flag=0
	
#iplist="ip.txt"

wget --quiet -O iplist.txt https://raw.githubusercontent.com/rasta-team/SERVER_IP_REGISTER/master/ip.txt

#if [ -f iplist ]
#then

iplist="iplist.txt"

lines=`cat $iplist`
#echo $lines

for line in $lines; do
#        echo "$line"
        if [ "$line" = "$myip" ];
        then
                flag=1
        fi

done

if [ $flag -eq 0 ]
then
   echo  "Maaf, hanya IP @ Password yang terdaftar sahaja boleh menggunakan script ini!
Hubungi: ABE PANG (+0169872312) Telegram : @myvpn007"

rm -f /root/iplist.txt

rm -f /root/Debian7-vultr.sh
	
	exit 1
fi
echo "
AUTOSCRIPT BY RASTA-TEAM

PLEASE CANCEL ALL PACKAGE POPUP

TAKE NOTE !!!"
clear
echo "START AUTOSCRIPT"
clear

#set time zone malaysia
echo "SET TIMEZONE KUALA LUMPUT GMT +8"
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime;
clear

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0'`;
MYIP2="s/xxxxxxxxx/$MYIP/g";

# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

echo "
REMOVE SPAM PACKAGE

COMPLETE 10%
"
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove postfix*;
apt-get -y --purge remove bind*;
apt-get -y --purge remove dropbear*;


echo "
UPDATE AND UPGRADE PROCESS 

PLEASE WAIT TAKE TIME 1-5 MINUTE
"

#install
apt-get install sudo

# install essential package
apt-get -y install build-essential
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip tar zip unrar rsyslog debsums rkhunter

apt-get update;apt-get -y upgrade;apt-get -y install wget curl
echo "
INSTALLER PROCESS PLEASE WAIT
TAKE TIME 5-10 MINUTE
"
# login setting
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

#text gambar
apt-get install boxes

# install wget and curl
apt-get update
apt-get -y install wget curl
clear


# text warna
cd
rm -rf .bashrc
wget https://raw.githubusercontent.com/rasta-team/Full-Debian7-32bit/master/text_warna/.bashrc
clear

# squid3
apt-get update
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/rasta-team/Full-Debian7-32bit/master/squid.conf"
sed -i "s/ipserver/$myip/g" /etc/squid3/squid.conf
chmod 0640 /etc/squid3/squid.conf
clear

# install webserver
apt-get -y install nginx php5-fpm php5-cli

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update

# Install Web Server
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/rasta-team/MyVPS/master/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by ABE PANG</pre>" > /home/vps/public_html/index.html
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/rasta-team/MyVPS/master/vps.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart
service nginx restart

# install openvpn
apt-get install openvpn -y
wget -O /etc/openvpn/openvpn.tar "https://raw.github.com/yusuf-ardiansyah/debian/master/conf/openvpn-debian.tar"
cd /etc/openvpn/
tar xf openvpn.tar
#wget -O /etc/openvpn/1194.conf "https://raw.github.com/yusuf-ardiansyah/debian/master/conf/1194.conf"
wget -O /etc/openvpn/1194.conf "https://raw.githubusercontent.com/rasta-team/Full-Debian7-32bit/master/1194.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
#wget -O /etc/iptables.conf "https://raw.github.com/yusuf-ardiansyah/debian/master/conf/iptables.conf"
wget -O /etc/iptables.conf "https://raw.githubusercontent.com/rasta-team/Full-Debian7-32bit/master/iptables.conf"
sed -i '$ i\iptables-restore < /etc/iptables.conf' /etc/rc.local

myip2="s/ipserver/$myip/g";
sed -i $myip2 /etc/iptables.conf;

iptables-restore < /etc/iptables.conf
service openvpn restart

# configure openvpn client config
cd /etc/openvpn/
#wget -O /etc/openvpn/1194-client.ovpn "https://raw.github.com/yusuf-ardiansyah/debian/master/conf/1194-client.conf"
wget -O /etc/openvpn/1194-client.ovpn "https://raw.githubusercontent.com/rasta-team/Full-Debian7-32bit/master/1194-client.conf"
usermod -s /bin/false mail
echo "mail:ardy" | chpasswd
useradd -s /bin/false -M ardiansyah
echo "ardiansyah:ardy" | chpasswd
#tar cf client.tar 1194-client.ovpn
cp /etc/openvpn/1194-client.ovpn /home/vps/public_html/
sed -i $myip2 /home/vps/public_html/1194-client.ovpn
sed -i "s/ports/55/" /home/vps/public_html/1194-client.ovpn

# setting port ssh
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart

# Install DROPBEAR
cd
apt-get install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service ssh restart
service dropbear restart

# Install Vnstat
apt-get -y install vnstat
vnstat -u -i eth0
sudo chown -R vnstat:vnstat /var/lib/vnstat
service vnstat restart

# Install Vnstat GUI
cd /home/vps/public_html/
wget http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
cd

# Setting Vnstat
vnstat -u -i eth0
chown -R vnstat:vnstat /var/lib/vnstat
service vnstat restart

# install fail2ban
apt-get -y install fail2ban
service fail2ban restart

#installing webmin
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib" >> /etc/apt/sources.list
apt-get update
apt-get -y install webmin

#disable webmin https
sed -i "s/ssl=1/ssl=0/g" /etc/webmin/miniserv.conf
/etc/init.d/webmin restart
service vnstat restart

apt-get -y --force-yes -f install libxml-parser-perl

# install badvpn
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/rasta-team/MyVPS/master/badvpn-udpgw"
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

#bonus block torrent
wget https://raw.githubusercontent.com/zero9911/script/master/script/torrent.sh
chmod +x  torrent.sh
./torrent.sh

#Blockir Torrent
iptables -A OUTPUT -p tcp --dport 6881:6889 -j DROP
iptables -A OUTPUT -p udp --dport 1024:65534 -j DROP
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP

# auto reboot 24jam
cd
echo "0 */12 * * * root /usr/bin/reboot" > /etc/cron.d/reboot
echo "*/50 * * * * root service dropbear restart" > /etc/cron.d/dropbear
echo "*/50 * * * * root service ssh restart" >> /etc/cron.d/dropbear
#echo "* * * * * root sleep 10; ./userlimit.sh 2" > /etc/cron.d/userlimit2
#echo "* * * * * root sleep 20; ./userlimit.sh 2" > /etc/cron.d/userlimit4
#echo "* * * * * root sleep 30; ./userlimit.sh 2" > /etc/cron.d/userlimit6
#echo "* * * * * root sleep 40; ./userlimit.sh 2" > /etc/cron.d/userlimit8
#echo "* * * * * root sleep 50; ./userlimit.sh 2" > /etc/cron.d/userlimit11
echo "0 1 * * * root ./userexpired.sh" > /etc/cron.d/userexpired
echo "*/2 * * * * root ./clearcache.sh" > /etc/cron.d/clearcache

# auto kill dropbear
#wget "https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/menu/userlimit.sh"
#mv ./userlimit /usr/bin/userlimit.sh
#chmod +x /usr/bin/userlimit.sh
#echo " /etc/security/limits.conf" > /etc/security/limits.conf

# auto kill openssh
#wget "https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/menu/userlimitssh.sh"
#mv ./userlimitssh.sh /usr/bin/userlimitssh.sh
#chmod +x /usr/bin/userlimitssh.sh

# cranjob
#sudo apt-get install cron
#wget https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/clearcache/crontab
#mv crontab /etc/
#chmod 644 /etc/crontab

# tool 
cd
wget -O userlimit.sh "https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/menu/userlimit.sh"
wget -O userexpired.sh "https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/menu/userexpired.sh"
#wget -O autokill.sh "https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/menu/autokill.sh"
wget -O userlimitssh.sh "https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/menu/userlimitssh.sh"
echo "@reboot root /root/userexpired.sh" >> /etc/cron.d/userexpired
#echo "@reboot root /root/userlimit.sh" > /etc/cron.d/userlimit
#echo "@reboot root /root/userlimitssh.sh" > /etc/cron.d/userlimitssh
#echo "@reboot root /root/autokill.sh" > /etc/cron.d/autokill
#sed -i '$ i\screen -AmdS check /root/autokill.sh' /etc/rc.local
chmod +x userexpired.sh
chmod 755 userlimit.sh
#chmod +x autokill.sh
chmod +x userlimitssh.sh

# clear cache
wget -O clearcache.sh "https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/clearcache/clearcache.sh"
#echo "@reboot root /root/clearcache.sh" > /etc/cron.d/clearcache
chmod 755 /root/clearcache.sh

# userlimit
#cd
#wget "https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/conf/limits.conf"
#mv limits.conf /etc/security/limits.conf
#chmod 644 /etc/security/limits.conf

# buka port 80
#iptables -I INPUT -p tcp --dport 80 -j ACCEPT


# speedtest
cd
apt-get install python
wget -O speedtest.py "https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/menu/speedtest.py"
chmod +x speedtest.py

# Install Menu vultr
cd
wget "https://raw.githubusercontent.com/rasta-team/Vultr-Debian/master/menu"
mv ./menu /usr/local/bin/menu
chmod +x /usr/local/bin/menu

# shc file
cd
apt-get install make
cd
wget https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/shc-3.8.7.tgz
tar xvfz shc-3.8.7.tgz

# swap ram
dd if=/dev/zero of=/swapfile bs=1024 count=1024k
# buat swap
mkswap /swapfile
# jalan swapfile
swapon /swapfile
#auto star saat reboot
wget https://raw.githubusercontent.com/yusuf-ardiansyah/vultur/master/ram/fstab
mv ./fstab /etc/fstab
chmod 644 /etc/fstab
sysctl vm.swappiness=20
#permission swapfile
chown root:root /swapfile 
chmod 0600 /swapfile

cd
# disable exim
service exim4 stop
sysv-rc-conf exim4 off

rm -rf /etc/cron.weekly/
rm -rf /etc/cron.hourly/
rm -rf /etc/cron.monthly/
rm -rf /etc/cron.daily/
echo "UPDATE AND INSTALL COMPLETE COMPLETE 99% BE PATIENT"

cd shc-3.8.7
make
./shc -f /usr/local/bin/menu
cd
mv /usr/local/bin/menu.x /usr/local/bin/menu
chmod +x /usr/local/bin/menu
cd

clear
service cron restart
service openvpn restart
service squid3 restart
service ssh restart
service webmin restart
service dropbear restart
service nginx start


#clear
echo "========================================"  
echo "Service Autoscript by RASTA-TEAM" 
echo "----------------------------------------"
echo ""  | tee -a log-install.txt
echo "Webmin   : http://$myip:10000/"
echo "Squid3   : 8080, 3128"
echo "OpenSSH  : 22"
echo "Dropbear : 443"
echo "OpenVPN  : TCP Port 55 (client config : http://$myip:81/1194-client.ovpn)"
echo "Timezone : Asia/Kuala_Lumpur"
echo "Fail2Ban : [on]"
echo "Power By : RASTA-TEAM"
echo "Phone    : +60169872312"
echo ""
echo "Auto kill Multy Login Maximal Login 2"
echo "Auto Install Virtual Ram 1 gb"
echo "----------------------------------------"
echo "LOG INSTALL  --> /root/log-install.txt"
echo "----------------------------------------"
echo " CREATED BY RASTA-TEAM - VPS - SCRIPT INSTALLER PREMIUM"
echo "========================================"  | tee -a log-install.txt
echo "      SILAH REBOOT VPS ANDA !"
echo "========================================"  | tee -a log-install.txt
cat /dev/null > ~/.bash_history && history -c
