# https://scaron.info/blog/debian-mail-postfix-dovecot.html

#openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -out /etc/ssl/certs/mailcert.pem -keyout /etc/ssl/private/mail.key
#openssl req -nodes -days 3650 -newkey rsa:4096 -keyout /etc/ssl/private/mail.key -out mailcert.csr

# https://www.e-rave.nl/create-a-self-signed-ssl-key-for-postfix
openssl genrsa -des3 -out example.net.key 2048
openssl req -new -key example.net.key -out example.net.csr
openssl x509 -req -days 365 -in example.net.csr -signkey example.net.key -out example.net.crt
openssl rsa -in example.net.key -out example.net.key.nopass
mv example.net.key.nopass example.ent.tld.key
openssl req -new -x509 -extensions v3_ca -keyout cakey.pem -out cacert.pem -days 3650

chmod 600 example.net.key
chmod 600 cakey.pem
mv example.net.key /etc/ssl/private/
mv example.net.crt /etc/ssl/certs/
mv cakey.pem /etc/ssl/private/
mv cacert.pem /etc/ssl/certs/


postconf -e 'smtpd_use_tls = yes'
postconf -e 'smtpd_tls_auth_only = no'
postconf -e 'smtpd_tls_key_file = /etc/ssl/private/example.net.key'
postconf -e 'smtpd_tls_cert_file = /etc/ssl/certs/example.net.crt'
postconf -e 'smtpd_tls_CAfile = /etc/ssl/certs/cacert.pem'
postconf -e 'tls_random_source = dev:/dev/urandom'
postconf -e 'myhostname = dc1.example.net'


apt-get install dovecot-common dovecot-imapd

# /etc/dovecot/conf.d/10-ssl.conf
# SSL/TLS support: yes, no, required. <doc/wiki/SSL.txt>
ssl = required
ssl_cert = </etc/ssl/certs/mailcert.pem
ssl_key = </etc/ssl/private/mail.key


# /etc/dovecot/conf.d/10-master.conf
service auth {
  # Postfix smtp-auth (was commented)
  unix_listener /var/spool/postfix/private/auth {
    mode = 0660
    user = postfix
    group = postfix
  }
}


