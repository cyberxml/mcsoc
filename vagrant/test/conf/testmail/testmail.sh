# ---------------------------------------------------------------------
# networking
# ---------------------------------------------------------------------
cp /vagrant/conf/testmail/hosts /etc/hosts
chattr -i /etc/resolv.conf
cp /vagrant/conf/testmail/resolv.conf /etc/resolv.conf
chattr +i /etc/resolv.conf
cp /vagrant/conf/testmail/route-eth1 /etc/sysconfig/network-scripts/route-eth1

systemctl restart network

yum -y update
yum -y install wget dns-utils net-tools


