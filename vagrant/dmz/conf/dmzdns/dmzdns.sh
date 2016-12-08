# ---------------------------------------------------------------------
# networking
# ---------------------------------------------------------------------
cp /vagrant/conf/dmzdns/hosts /etc/hosts
chattr -i /etc/resolv.conf
cp /vagrant/conf/dmzdns/resolv.conf /etc/resolv.conf
chattr +i /etc/resolv.conf
cp /vagrant/conf/dmzdns/route-eth1 /etc/sysconfig/network-scripts/route-eth1

systemctl restart network

yum -y update
yum -y install wget dns-utils net-tools


