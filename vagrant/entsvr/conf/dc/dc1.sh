#---------------------------------------
# Networking
#---------------------------------------

# /etc/hosts
cp /vagrant/conf/dc/hosts /etc/hosts

# /etc/resolv.conf 
chattr -i /etc/resolv.conf
cp /vagrant/conf/dc/resolv.conf /etc/resolv.conf
chattr +i /etc/resolv.conf

# routing
cp /vagrant/conf/dc/route-eth1 /etc/sysconfig/network-scripts

# network interfaces
yum -y install net-tools bind-utils wget


#---------------------------------------
# check_mk network monitor agent
#---------------------------------------
yum -y install xinetd
rpm -i /vagrant/pkgs/check_mk-agent-1.2.4p3-1.noarch.rpm
rpm -i /vagrant/pkgs/check_mk-agent-logwatch-1.2.4p3-1.noarch.rpm
systemctl enable xinetd
systemctl start xinetd

#---------------------------------------
# Bind DNS
#---------------------------------------
# https://www.unixmen.com/setting-dns-server-centos-7/
yum install -y bind bind-utils

cp /vagrant/conf/dc/named.conf /etc/named.conf
cp /vagrant/conf/dc/bind/forward.example.net /var/named/
cp /vagrant/conf/dc/bind/reverse.example.net /var/named/

firewall-cmd --permanent --add-port=53/tcp
firewall-cmd --permanent --add-port=53/udp

chgrp named -R /var/named
chown -v root:named /etc/named.conf
restorecon -rv /var/named
restorecon /etc/named.conf

systemctl enable samba
systemctl start samba

host -t A dc1.example.net

#---------------------------------------
# Samba4
#---------------------------------------
# https://thingsdomakesense.wordpress.com/2016/10/28/installing-samba-4-5-1-ad-dc-on-centos-7-1511/
# https://wiki.samba.org/index.php/BIND9_DLZ_DNS_Back_End

service firewalld stop
systemctl disable firewalld

sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
setenforce 0

echo "PATH=${PATH}:/usr/local/samba/bin:/usr/local/samba/sbin" > /etc/profile.d/samba-path.sh
PATH=${PATH}:/usr/local/samba/bin:/usr/local/samba/sbin

sed -i 's#Defaults    secure_path =.*#Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/samba/bin:/usr/local/samba/sbin#' /etc/sudoers


yum install -y perl gcc attr libacl-devel libblkid-devel \
    gnutls-devel readline-devel python-devel gdb pkgconfig \
    krb5-workstation zlib-devel setroubleshoot-server libaio-devel \
    setroubleshoot-plugins policycoreutils-python \
    libsemanage-python perl-ExtUtils-MakeMaker perl-Parse-Yapp \
    perl-Test-Base popt-devel libxml2-devel libattr-devel \
    keyutils-libs-devel cups-devel bind-utils libxslt \
    docbook-style-xsl openldap-devel autoconf python-crypto pam-devel

yum install -y wget

cd /opt
wget https://download.samba.org/pub/samba/stable/samba-4.4.7.tar.gz
tar xvzf samba-4.4.7.tar.gz
cd samba-4.4.7
./configure --enable-debug --enable-selftest --with-ads --with-systemd --with-winbind --enable-gnutls
make
make install

samba-tool domain provision --host-name=dc1 --realm=ENT.EXAMPLE.NET --domain=ENT --server-role='dc' --adminpass=Vagrant\!234 --dns-backend=BIND9_DLZ --function-level=2008_R2 --use-rfc2307 --option="interfaces=eth1 lo" --option="bind interfaces only=yes" --use-xattrs=yes

chmod 640 /usr/local/samba/private/dns.keytab
chown root:named /usr/local/samba/private/dns.keytab

echo "include \"/usr/local/samba/private/named.conf\";" >> /etc/named.conf
systemctl restart named

samba_upgradedns --dns-backend=BIND9_DLZ
host -t SRV _ldap._tcp.ent.example.net.
host -t SRV _kerberos._udp.ent.example.net.

# configure for login
cp /vagrant/conf/dc/nsswitch.conf /etc/nsswitch.conf
cp /vagrant/conf/dc/samba.service /etc/systemd/system/samba.service

ln -s  /usr/local/samba/lib/libnss_winbind.so.2  /lib64/libnss_winbind.so
ln  -s /lib64/libnss_winbind.so  /lib64/libnss_winbind.so.2
ln -s /usr/lib64/libgnutls.so.28 /usr/lib64/libgnutls.so.26

systemctl enable samba
systemctl start samba


echo Vagrant\!234 | kinit administrator@ENT.EXAMPLE.NET


samba-tool user list
samba-tool group list

samba-tool user add testad
# for email server queries
samba-tool user add vmail
samba-tool user add user
samba-tool group add testgroup


# troubleshotting
# erros
#  samba_dnsupdate --verbose --all-names 
# no errors
#  samba_dnsupdate --verbose --all-names --use-file=/usr/local/samba/private/dns.keytab
# dns_tkey_negotiategss: TKEY is unacceptable 
# appears to prevent dns updates when machine joins


cp key-dc1.pem /usr/local/samba/private/tls
cp cert-dc1.pem /usr/local/samba/private/tls
chmod 660 /usr/local/samba/private/tls/key-dc1.pem

#echo "tls enabled  = yes" >> /usr/local/samba/etc/smb.conf
#echo "tls keyfile  = tls/key-dc1.pem" >> /usr/local/samba/etc/smb.conf
#echo "tls certfile = tls/cert-dc1t.pem" >> /usr/local/samba/etc/smb.conf
#echo "tls cafile   = " >> /usr/local/samba/etc/smb.conf

openssl verify /usr/local/samba/private/tls/cert-dc1.pem

samba-tool dns query localhost ent.example.net @ ALL -U administrator --password Vagrant\!234
samba-tool dns add dc1 ent.example.net mail A 10.10.0.13 -U administrator --password Vagrant\!234




#---------------------------------------
# iRedmail
#---------------------------------------

yum -y install wget
cd /opt
wget https://bitbucket.org/zhb/iredmail/downloads/iRedMail-0.9.5-1.tar.bz2
tar xvjf iRedMail-0.9.5-1.tar.bz2

cd iRedMail-0.9.5-1/
#sh iRedMail.sh
# /opt/iRedMail-0.9.5-1/config
# Public key for altermime-0.3.10-10.el7.x86_64.rpm is not installed


