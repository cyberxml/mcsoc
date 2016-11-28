# https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-centos-7
yum -y install httpd
systemctl start httpd.service
systemctl enable httpd.service
ip addr show eth1 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

yum -y install mariadb-server mariadb
systemctl start mariadb
mysql_secure_installation

systemctl enable mariadb.service
yum -y install php php-mysql
systemctl restart httpd.service

#yum -y install php-*

cp /vagrant/conf/web/info.php /var/www/html/info.php

systemctl start firewalld
firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
systemctl stop firewalld

# https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-on-centos-7
mysql -u root -p
CREATE DATABASE mcsocwp;
CREATE USER wpvagrant@localhost IDENTIFIED BY 'vagrant';
GRANT ALL PRIVILEGES ON mcsocwp.* TO wpvagrant@localhost IDENTIFIED BY 'vagrant';
FLUSH PRIVILEGES;
exit

yum -y install php-gd
service httpd restart

yum -y install wget
cd /opt
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
rsync -avP /opt/wordpress/ /var/www/html/
mkdir /var/www/html/wp-content/uploads
cp /vagrant/conf/web/wp-config.php /var/www/html
chown -R apache:apache /var/www/html/*


setsebool -P httpd_unified 1 
systemctl reload httpd




