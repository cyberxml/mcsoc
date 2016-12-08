# ---------------------------------------------------------------------
# networking
# ---------------------------------------------------------------------
cp /vagrant/conf/proxy/hosts /etc/hosts
chattr -i /etc/resolv.conf
cp /vagrant/conf/proxy/resolv.conf /etc/resolv.conf
chattr +i /etc/resolv.conf
cp /vagrant/conf/proxy/route-eth1 /etc/sysconfig/network-scripts/route-eth1

systemctl restart network

yum -y update
yum -y install wget bind-utils net-tools

# ---------------------------------------------------------------------
# apache + mod security
# ---------------------------------------------------------------------
# http://linuxpitstop.com/install-and-setup-owasp-on-centos-linux/


yum -y install httpd mod_ssl mod_security mod_security_crs mod_proxy_html
#yum -y install httpd mod_ssl mod_proxy_html
#yum -y install mod_security mod_security_crs

#cp /usr/share/doc/httpd-2.4.6/reverse-proxy.conf  /etc/httpd/conf.d/reverse-proxy.conf
cp /vagrant/conf/dmzweb/reverse-proxy.conf /etc/httpd/conf.d/reverse-proxy.conf
#cp /vagrant/conf/dmzweb/httpd.conf /etc/httpd/conf/httpd.conf

systemctl enable httpd
systemctl start httpd
