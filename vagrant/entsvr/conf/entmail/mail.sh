#---------------------------------------
# Networking
#---------------------------------------

# /etc/hosts
cp /vagrant/conf/mail/hosts /etc/hosts

# /etc/resolv.conf
chattr -i /etc/resolv.conf
cp /vagrant/conf/mail/resolv.conf /etc/resolv.conf
chattr +i /etc/resolv.conf

# routing
cp /vagrant/conf/mail/route-eth1 /etc/sysconfig/network-scripts

# network interfaces
yum -y install net-tools
yum -y install bind-utils

# selinux
sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
setenforce 0

#---------------------------------------
# check_mk monitor
#---------------------------------------

yum -y install xinetd
rpm -i /vagrant/pkgs/check_mk-agent-1.2.4p3-1.noarch.rpm
rpm -i /vagrant/pkgs/check_mk-agent-logwatch-1.2.4p3-1.noarch.rpm
systemctl enable xinetd
systemctl start xinetd
firewall-cmd --permanent --add-port=6556/tcp

#---------------------------------------
# Samba
#---------------------------------------

yum -y install samba4 samba4-winbind-clients
yum -y install krb5-workstation

cp /vargrant/conf/mail/krb5.conf /etc

echo Vagrant\!234 | net ads join -U administrator
#Using short domain name -- ENT
#Joined 'MAIL' to dns domain 'ent.example.net'
#DNS Update for mail.example.net failed: ERROR_DNS_GSS_ERROR
#DNS update failed: NT_STATUS_UNSUCCESSFUL


systemctl enable winbind
systemctl start winbind

wbinfo -u
wbinfo -g
wbinfo -i ENT\\testad
wbinfo -a ENT\\testad

su - ENT\\testad

#---------------------------------------
# iRedMail
#---------------------------------------
# http://www.linuxtechi.com/install-iredmail-mail-server-on-centos-7-rhel-7/

yum -y install wget
cd /opt
wget https://bitbucket.org/zhb/iredmail/downloads/iRedMail-0.9.5-1.tar.bz2
tar xvjf iRedMail-0.9.5-1.tar.bz2
cd iRedMail-0.9.5-1/
sh iRedMail.sh
# there is a an opt config file

#---------------------------------------
# AD/OpenLDAP authentication
#---------------------------------------
# https://www.howtoforge.com/postfix-dovecot-authentication-against-active-directory-on-centos-5.x

cp /vagrant/conf/mail/ad1-ca.pem /etc/pki/tls/certs/
echo "TLS_CACERT /etc/pki/tls/certs/ad1-ca.pem" >> /opt/openldap/ldap.conf


export LDAPTLS_CACERTDIR=/etc/openldap/certs
ls /etc/openldap/certs/
example.net.ca.cert.pem  example.net.intermediate.cert.pem

ldapwhoami -x -ZZ -H ldaps://dc1.example.net

ldapsearch -h dc1.example.net  -D "CN=testad,CN=Users,DC=ent,DC=example,DC=net"  -b "DC=ent,DC=example,DC=net"  -s sub  -x -ZZ -LLL  "(cn=administrator)" dn sAMAccountName -w Vagrant\!234

ldapsearch -h dc1.example.net  -D "CN=Administrator,CN=Users,DC=ent,DC=example,DC=net"  -b "DC=ent,DC=example,DC=net"  -s sub  -x -ZZ -LLL  "(cn=administrator)" dn sAMAccountName -w Vagrant\!234


ldapsearch -h dc1.example.net  -D "cn=vmail,cn=users,dc=ent,dc=example,dc=net"  -b "DC=ent,DC=example,DC=net"  -x -W -b "DC=ent,DC=example,DC=net" -ZZ


# http://www.iredmail.org/docs/active.directory.html
postconf -e virtual_alias_maps=''
postconf -e sender_bcc_maps=''
postconf -e recipient_bcc_maps=''
postconf -e relay_domains=''
postconf -e relay_recipient_maps=''
postconf -e sender_dependent_relayhost_maps=''

postconf -e smtpd_sasl_local_domain='example.net'
postconf -e virtual_mailbox_domains='example.net'

postconf -e transport_maps='hash:/etc/postfix/transport'

postconf -e smtpd_sender_login_maps='proxy:ldap:/etc/postfix/ad_sender_login_maps.cf'
postconf -e virtual_mailbox_maps='proxy:ldap:/etc/postfix/ad_virtual_mailbox_maps.cf'

postconf -e virtual_alias_maps='proxy:ldap:/etc/postfix/ad_virtual_group_maps.cf'

echo "example.net dovecot" > /etc/postfix/transport

postmap hash:/etc/postfix/transport


    Create file: /etc/postfix/ad_sender_login_maps.cf:

server_host     = dc1.example.net
server_port     = 389
version         = 3
bind            = yes
start_tls       = yes
bind_dn         = cn=vmail,cn=users,dc=ent,dc=example,dc=net
bind_pw         = Vagrant!234
search_base     = cn=users,dc=ent,dc=example,dc=net
scope           = sub
query_filter    = (&(userPrincipalName=%s)(objectClass=person)(!(userAccountControl:1.2.840.113556.1.4.803:=2)))
result_attribute= userPrincipalName
debuglevel      = 0



    Create file: /etc/postfix/ad_virtual_mailbox_maps.cf:

server_host     = dc1.example.net
server_port     = 389
version         = 3
bind            = yes
start_tls       = yes
bind_dn         = cn=vmail,cn=users,dc=ent,dc=example,dc=net
bind_pw         = Vagrant!234
search_base     = cn=users,dc=ent,dc=example,dc=net
scope           = sub
query_filter    = (&(objectclass=person)(userPrincipalName=%s))
result_attribute= userPrincipalName
result_format   = %d/%u/Maildir/
debuglevel      = 0


    Create file: /etc/postfix/ad_virtual_group_maps.cf:

server_host     = dc1.example.net
server_port     = 389
version         = 3
bind            = yes
start_tls       = yes
bind_dn         = cn=vmail,cn=users,dc=ent,dc=example,dc=net
bind_pw         = Vagrant!234
search_base     = cn=users,dc=ent,dc=example,dc=net
scope           = sub
query_filter    = (&(objectClass=group)(mail=%s))
special_result_attribute = member
leaf_result_attribute = mail
result_attribute= userPrincipalName
debuglevel      = 0


Open Postfix config file /etc/postfix/main.cf
Remove setting check_policy_service inet:127.0.0.1:7777

modify Dovecot config file /etc/dovecot/dovecot-ldap.conf like below:

hosts           = dc1.example.net:389
ldap_version    = 3
auth_bind       = yes
tls		= yes
dn              = cn=vmail,cn=users,dc=ent,dc=example,dc=net
dnpass          = Vagrant\!234 
base            = cn=users,dc=ent,dc=example,dc=net
scope           = subtree
deref           = never
user_filter     = (&(userPrincipalName=%u)(objectClass=person)(!(userAccountControl:1.2.840.113556.1.4.803:=2)))
pass_filter     = (&(userPrincipalName=%u)(objectClass=person)(!(userAccountControl:1.2.840.113556.1.4.803:=2)))
pass_attrs      = userPassword=password
default_pass_scheme = CRYPT
user_attrs      = =home=/var/vmail/vmail1/%Ld/%Ln/Maildir/,=mail=maildir:/var/vmail/vmail1/%Ld/%Ln/Maildir/



