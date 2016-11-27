# https://jamielinux.com/docs/openssl-certificate-authority/create-the-intermediate-pair.html

# https://jamielinux.com/docs/openssl-certificate-authority/create-the-root-pair.html

cd /root/ca
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

# customize the openssl-root.cnf
#wget https://jamielinux.com/docs/openssl-certificate-authority/_downloads/root-config.txt
#mv root-config.txt openssl-root.cnf

openssl genrsa -aes256 -out private/ca.key.pem 4096
chmod 444 certs/ca.cert.pem
openssl x509 -noout -text -in certs/ca.cert.pem

openssl req -config openssl-root.cnf \
      -key private/ca.key.pem \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out certs/ca.cert.pem
chmod 444 certs/ca.cert.pem

mkdir /root/ca/intermediate
cd /root/ca/intermediate
mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

echo 1000 > /root/ca/intermediate/crlnumber

# wget https://jamielinux.com/docs/openssl-certificate-authority/_downloads/intermediate-config.txt
# mv intermediate-config.txt openssl-intermediate.cnf

cd /root/ca
openssl genrsa -aes256 -out intermediate/private/intermediate.key.pem 4096

cd /root/ca
openssl req -config intermediate/openssl-intermediate.cnf -new -sha256 \
      -key intermediate/private/intermediate.key.pem \
      -out intermediate/csr/intermediate.csr.pem

cd /root/ca
openssl ca -config openssl-root.cnf -extensions v3_intermediate_ca \
      -days 3650 -notext -md sha256 \
      -in intermediate/csr/intermediate.csr.pem \
      -out intermediate/certs/intermediate.cert.pem

chmod 444 intermediate/certs/intermediate.cert.pem

openssl x509 -noout -text -in intermediate/certs/intermediate.cert.pem

# Our certificate chain file must include the root certificate
# because no client application knows about it yet.
# A better option, particularly if you’re administrating an intranet,
# is to install your root certificate on every client that needs to connect.
# In that case, the chain file need only contain your intermediate certificate.

# cat intermediate/certs/intermediate.cert.pem \
#      certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem
cat intermediate/certs/intermediate.cert.pem > intermediate/certs/ca-chain.cert.pem
chmod 444 intermediate/certs/ca-chain.cert.pem

cd /root/ca
openssl genrsa -aes256 -out intermediate/private/dc1.example.net.key.pem 2048
chmod 400 intermediate/private/dc1.example.net.key.pem

cd /root/ca
openssl req -config intermediate/openssl-intermediate.cnf \
      -key intermediate/private/dc1.example.net.key.pem \
      -new -sha256 -out intermediate/csr/dc1.example.net.csr.pem

cd /root/ca
openssl ca -config intermediate/openssl-intermediate.cnf \
      -extensions server_cert -days 3750 -notext -md sha256 \
      -in intermediate/csr/dc1.example.net.csr.pem \
      -out intermediate/certs/dc2.example.net.cert.pem

chmod 444 intermediate/certs/dc1.example.net.cert.pem

# verify the samba install
openssl s_client -showcerts -connect dc1.example.net:636 -CAfile /usr/local/samba/private/tls/example.net.ca-chain.full.cert.pem


# ldapsearch
ldapsearch -D "cn=administrator" -w secret -p 389 -h dc1.ent.example.net -b "dc=ent,dc=example,dc=net" -s sub -x -ZZ "(objectclass=*)"

