# ---------------------------------------------------------------------
# networking
# ---------------------------------------------------------------------
cp /vagrant/conf/proxy/hosts /etc/hosts
chattr -i /etc/resolv.conf
cp /vagrant/conf/proxy/resolv.conf /etc/resolv.conf
chattr +i /etc/resolv.conf
cp /vagrant/conf/proxy/route-eth1 /etc/sysconfig/network-scripts/route-eth1

#systemctl restart network

yum -y update
yum -y install wget dns-utils net-tools

# ---------------------------------------------------------------------
# squid
# ---------------------------------------------------------------------
yum -y install squid squid-sysvinit libecap

# localized squid config 
cp /etc/squid/squid.conf /etc/squid/squid.conf-orig
cp /vagrant/conf/proxy/squid.conf /etc/squid/squid.conf
cp /vagrant/conf/proxy/squid.service /usr/lib/systemd/system/squid.service

systemctl enable squid
systemctl start squid

# ---------------------------------------------------------------------
# freshclam
# ---------------------------------------------------------------------
# https://www.server-world.info/en/note?os=CentOS_7&p=clamav
yum -y install epel-release
yum -y install clamav clamav-update 
sed -i -e "s/^Example/#Example/" /etc/freshclam.conf 
# run freshclam to update db (need to service this?)

# ---------------------------------------------------------------------
# clam scanner
# ---------------------------------------------------------------------
# https://www.server-world.info/en/note?os=CentOS_7&p=squid&f=5
yum -y install clamav-scanner clamav-scanner-systemd 
cp /vagrant/conf/proxy/scan.conf /etc/clamd.d
cp /vagrant/conf/proxy/clamd.conf /etc/clamd.d

touch /var/log/clamd.scan
chown clamscan /var/log/clamd.scan
restorecon -v /var/log/clamd.scan 
systemctl start clamd@scan
systemctl enable clamd@scan 
systemctl start clamd
systemctl enable clamd

# ---------------------------------------------------------------------
# c-icap
# ---------------------------------------------------------------------
# ICAP web filtering server
mkdir /opt/c-icap
cd /opt/c-icap
ICAPVER=0.4.4
wget http://sourceforge.net/projects/c-icap/files/c-icap/0.4.x/c_icap-${ICAPVER}.tar.gz
wget http://sourceforge.net/projects/c-icap/files/c-icap-modules/0.4.x/c_icap_modules-${ICAPVER}.tar.gz

tar xvzf c_icap-${ICAPVER}.tar.gz
tar xvzf c_icap_modules-${ICAPVER}.tar.gz

cd /opt/c-icap/c_icap-${ICAPVER}
#./configre
#make
#make install
# http://wiki.squid-cache.org/ConfigExamples/ContentAdaptation/C-ICAP
./configure 'CXXFLAGS=-O2 -m64 -pipe' 'CFLAGS=-O2 -m64 -pipe' --without-bdb --prefix=/usr/local
make
make install-strip
mv /usr/local/etc/c-icap.conf /usr/local/etc/c-icap.conf-orig
cp /vagrant/conf/proxy/c-icap.conf /usr/local/etc/c-icap.conf


cd /opt/c-icap/c_icap_mdoules-${ICAPVER}
./configure 'CXXFLAGS=-O2 -m64 -pipe' 'CFLAGS=-O2 -m64 -pipe' --without-bdb --prefix=/usr/local
make
make install

cp /vagrant/conf/proxy/c-icap.service /usr/lib/systemd/system

# ---------------------------------------------------------------------
# squidclamav
# ---------------------------------------------------------------------
THISVER=6.16
cd /opt
wget https://sourceforge.net/projects/squidclamav/files/squidclamav/${THISVER}/squidclamav-${THISVER}.tar.gz
tar xvzf squidclamav-${THISVER}.tar.gz
cd squidclamav-${THISVER}
./configure --with-c-icap
make
make install
ln -s /usr/local/etc/squidclamav.conf /etc/squidclamav.conf 

cp /vagrant/conf/proxy/squidclamav.conf /etc/squidclamav.conf

mkdir /var/run/c-icap
chown squid:squid /var/run/c-icap

system enable c-icap
system start c-icap
