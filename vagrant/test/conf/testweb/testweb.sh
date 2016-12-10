
cp /vagrant/conf/testweb/hosts /etc/hosts
cp /vagrant/conf/testweb/resolv.conf /etc/resolv.conf
chattr +i /etc/resolv.conf
cp /vagrant/conf/testweb/route-eth1 /etc/sysconfig/network-scripts/route-eth1


# https://sourceforge.net/projects/mutillidae/files/

#Update aptitude repository 
yum -y update 

#Install Apache2/dependencies 
#yum -y install apache2 apache2-utils 
yum -y install httpd

#Modify file /etc/apache2/mods-enabled/dir.conf 
#vi /etc/apache2/mods-enabled/dir.conf 
cp /vagrant/conf/testweb/httpd.conf /etc/httpd/conf/httpd.conf

#Change the following line: 
#<IfModule mod_dir.c> 
#	DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm 
#</IfModule> 
#Change to: 
#<IfModule mod_dir.c> 
#	#DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm 
#	DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm 
#</IfModule> 

#Restart apache2 and verify apache2 is working by visiting http://ip_address or http://localhost 
#service apache2 restart 
systemctl enable httpd
systemctl restart httpd

#firefox http://localhost 
#Install MySQL Server. Be careful to note what password is used for MySQL because Mutillidae must know what is this password. 
#yum -y install mysql-server libapache2-mod-auth-mysql php5-mysql 
yum -y install mariadb-server php-mysql 
# sudo mysql_install_db 
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation
# echo "use mysql; GRANT ALL PRIVILEGES on *.* to 'root'@'%' IDENTIFIED BY 'vagrant' WITH GRANT OPTION;" | mysql -uroot -pvagrant

#Install PHP5 
#yum -y install php5 php5-mysql php-pear php5-gd php5-mcrypt php5-curl 
yum -y install php php-mysql php-pear php-gd php-mbstring 

#Testing PHP5 
#sudo touch /var/www/html/phpinfo.php 
#sudo nano /var/www/html/phpinfo.php 

#Add the following line into /var/www/html/phpinfo.php 
#<?php phpinfo(); ?> 
cp /vagrant/conf/testweb/phpinfo.php /var/www/html/phpinfp.php

# https://cyberpedia.in/how-to-create-a-virtual-lab-for-web-penetration-testing-in-linux
#cd mutillidae/classes/
#ls –lrta
#vi MySQLHandler.php
#chown apache:mysql mutillidae
#chmod 770 mutillidae
#ls –ld mutillidae

#Verify PHP5 
#firefox http://localhost/phpinfo.php 

#Install Mutillidae 
yum -y install git
cd /var/www/html/ 
sudo git clone git://git.code.sf.net/p/mutillidae/git mutillidae 

#Browse to Mutillidae 
firefox http://localhost/mutillidae 

#Click "Reset Database" to set up database


yum -y install wget
mkdir /var/www/html/eicar
cd /var/www/html/eicar
/vagrant/conf/testweb/get-eicar.sh
chown -R apache:apache /var/www/html/eicar

mkdir /var/www/html/test
cp /vagrant/conf/testweb/test.txt* /var/www/html/test
chown -R apache:apache /var/www/html/test

