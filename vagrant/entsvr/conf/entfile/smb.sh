# -----------------------------------------------------------
# network config
# -----------------------------------------------------------
cp /vagrant/conf/web/hosts /etc/hosts
chattr -i /etc/resolv.conf
cp /vagrant/conf/web/resolv.conf /etc/resolv.conf
chattr +i /etc/resolv.conf
cp /vagrant/conf/web/route-eth1 /etc/sysconfig/network-scripts/route-eth1
systemctl restart network

yum -y update
yum -y install wget net-tools bind-utils

# selinux
sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
setenforce 0

#---------------------------------------
# check_mk monitor
#---------------------------------------

yum -y install xinetd
rpm -i check_mk-agent-1.2.4p3-1.noarch.rpm
rpm -i check_mk-agent-logwatch-1.2.4p3-1.noarch.rpm
systemctl enable xinetd
systemctl start xinetd


#---------------------------------------
# AD Member Server
#---------------------------------------
# http://www.hexblot.com/blog/centos-7-active-directory-and-samba
yum install realmd samba samba-common oddjob oddjob-mkhomedir sssd ntpdate ntp

# NTP
systemctl enable ntpd.service
ntpdate dc1.example.net
systemctl start ntpd.service 

# REALM
realm join --user=Administrator@ENT.EXAMPLE.NET ENT.EXAMPLE.NET

#[root@smb smb]# realm list
#ent.example.net
  #type: kerberos
  #realm-name: ENT.EXAMPLE.NET
  #domain-name: ent.example.net
  configured: kerberos-member
  #server-software: active-directory
  #client-software: sssd
  #required-package: oddjob
  #required-package: oddjob-mkhomedir
  #required-package: sssd
  #required-package: adcli
  #required-package: samba-common
  #login-formats: %U@ent.example.net
  #login-policy: allow-realm-logins

# only adcli is not installed
#yum -y install oddjob oddjob-mkhomedir sssd adcli samba-common


# login and home director reconfig
sed -i 's/use_fully_qualified_names = .*/use_fully_qualified_names = False/' /etc/sssd/sssd.conf
sed -i 's#fallback_homedir = .*#fallback_homedir = /home/ENT/\%u #' /etc/sssd/sssd.conf
systemctl restart sssd

#---------------------------------------
# SMB Home File Server
#---------------------------------------
# https://jonathanchang.org/coding/setting-up-samba-home-folder-shares-for-a-centos-7-server/

yum install samba samba-client samba-common
systemctl enable smb
systemctl enable nmb
setsebool -P samba_enable_home_dirs on
systemctl start firewalld
firewall-cmd --permanent --zone=public --add-service=samba
firewall-cmd --reload
systemctl stop firewalld

mkdir /mnt/home
mkdir /mnt/home/ENT
chmod o+rw /mnt/home/ENT

semanage fcontext -a -t samba_share_t "/mnt/home/ENT(/.*)?" 
restorecon -R -v /mnt/home/ENT
setsebool -P samba_enable_home_dirs 1 
