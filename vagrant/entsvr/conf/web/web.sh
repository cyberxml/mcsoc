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

# -----------------------------------------------------------
# Apache
# -----------------------------------------------------------
# https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-centos-7
yum -y install httpd
setsebool -P httpd_unified 1 
cp /vagrant/conf/web/httpd.conf /etc/httpd/conf/httpd.conf
systemctl start httpd.service
systemctl enable httpd.service
ip addr show eth1 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

systemctl start firewalld
firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
systemctl stop firewalld
systemctl disable firewalld

systemctl reload httpd
# -----------------------------------------------------------
# MariaDB / MySQL
# -----------------------------------------------------------
yum -y install mariadb-server mariadb
systemctl enable mariadb.service
systemctl start mariadb
mysql_secure_installation <<EOF

y
vagrant
vagrant
y
y
y
y
EOF

# -----------------------------------------------------------
# PHP
# -----------------------------------------------------------
yum -y install php php-mysql php-gd

cp /vagrant/conf/web/phpinfo.php /var/www/html/phpinfo.php

# -----------------------------------------------------------
# Wordpress
# -----------------------------------------------------------
# https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-on-centos-7

# mysql config
mysql -uroot -pvagrant <<EOF
CREATE DATABASE mcsocwp;
CREATE USER wpvagrant@localhost IDENTIFIED BY 'vagrant';
GRANT ALL PRIVILEGES ON mcsocwp.* TO wpvagrant@localhost IDENTIFIED BY 'vagrant';
FLUSH PRIVILEGES;
exit
EOF

# downlaod and install wordpress
cd /opt
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
rsync -avP /opt/wordpress/ /var/www/html/
mkdir /var/www/html/wp-content/uploads
cp /vagrant/conf/web/wp-config.php /var/www/html
chown -R apache:apache /var/www/html/*
cd /vagrant/conf/web


# for proxy response
cp /vagrant/conf/web/icap.html /var/www/html
chown apache:apache /var/www/html/icap.html

systemctl restart httpd


echo "To initialize Wordpress, navigate to"
echo "http://10.10.8.14/wp-admin"
echo "Site Title: McSOC"
echo "Username: wpvagrant"
echo "Password: vagrant"
echo "Your Email: postmaster@example.net"
echo "Search Engine Visibility: [leave unchecked]"
echo "Press [Install Wordpress]"


echo ""
echo "Verify settings at"
echo "http://10.10.8..14/wp-admin/options-general.php"


mkdir /var/html/www/eicar
mkdir /var/html/www/test
cp /vagrant/conf/web/test* /var/www/html/test
chown -R apache:apache /var/html/www/eicar
chown -R apache:apache /var/html/www/test
