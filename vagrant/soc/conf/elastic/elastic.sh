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
ifdown eth1
ifup eth1

# update
yum -y update

# network interfaces
yum -y install net-tools bind-utils wget

# ELK prereq
yum -y install openjdk-


# ELK Version
ELKVER='5.4.0'

#---------------------------------------
# Elastic
#---------------------------------------
cd /opt
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELKVER}.rpm
rpm -ivh elasticsearch-${ELKVER}.rpm
cd /vagrant/conf/elastic
systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl start elasticsearch.service

#---------------------------------------
# Kibana
#---------------------------------------
cd /opt
wget https://artifacts.elastic.co/downloads/kibana/kibana-${ELKVER}-x86_64.rpm
rpm -ivh kibana-${ELKVER}-x86_64.rpm
cd /vagrant/conf/elastic

#---------------------------------------
# Logstash
#---------------------------------------
cd /opt
https://artifacts.elastic.co/downloads/logstash/logstash-${ELKVER}.rpm
rpm -ivh logstash-${ELKVER}.rpm
cd /vagrant/conf/elastic

# gen cert
cp openssl.cnf /etc/pki/tls/openssl.cnf
#cd /etc/pki/tls
#openssl req -config /etc/pki/tls/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt
cp logstash-forwarder.crt /etc/pki/tls/certs/logstash-forwarder.crt
cp logstash-forwarder.key /etc/pki/tls/private/logstash-forwarder.key

# define logstash service configs
cp 02-beats-input.conf /etc/logstash/conf.d
cp 10-syslog-filter.conf /etc/logstash/conf.d
cp 30-elasticsearch-output.conf /etc/logstash/conf.d

# enable service
systemctl daemon-reload
systemctl enable logstash.service
systemctl start logstash.service


#---------------------------------------
# Beats (for client installs)
#---------------------------------------
#cd /opt
#wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${ELKVER}-x86_64.rpm
#wget https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-${ELKVER}-x86_64.rpm
#wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-${ELKVER}-x86_64.rpm
#wget https://artifacts.elastic.co/downloads/beats/heartbeat/heartbeat-${ELKVER}-x86_64.rpm

#wget https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-${ELKVER}-windows-x86_64.zip


