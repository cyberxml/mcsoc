

cp /vagrant/conf/wks101/hosts /etc/hosts
cp /vagrant/conf/wks101/resolv.conf /etc/resolv.conf

# this requires interaction
apt-get remove resolv.conf

apt-get install realmd sssd sssd-tools libpam-sss libnss-sss

apt-get install samba-libs samba-common-bin

apt-get install krb5-user adcli packagekit


cp /vagrant/conf/ws/sssd.conf /etc/sssd
cp /vagrant/conf/ws/common-session /etc/pam.d

realm join -U Administrator ENT.EXAMPLE.NET
realm permit -all


cp /vagrant/conf/ws/mdm.conf /etc/mdm/mdm.conf
