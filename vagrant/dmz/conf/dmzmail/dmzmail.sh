#http://xmodulo.com/mailscanner-clam-antivirus-spamassassin-centos.html

# --------------------------------------------------------------------
# Installing Dependencies
# --------------------------------------------------------------------
# there are packages that do not exist listed here
yum install -y yum-utils gcc cpp perl bzip2 zip unrar make patch automake rpm-build perl-Archive-Zip perl-Filesys-Df perl-OLE-Storage_Lite perl-Sys-Hostname-Long perl-Sys-SigAction perl-Net-CIDR perl-DBI perl-MIME-tools perl-DBD-SQLite binutils glibc-devel perl-Filesys-Df zlib zlib-devel wget mlocate 

# --------------------------------------------------------------------
# Install and Configure ClamAV on CentOS 7
# --------------------------------------------------------------------
# clamav requires epel
# https://linux-audit.com/install-clamav-on-centos-7-using-freshclam/
yum install epel-release

yum install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd

# Configure SELinux for ClamAV
setsebool -P antivirus_can_scan_system 1

# Configuration of Clam daemon
cp /usr/share/clamav/template/clamd.conf /etc/clamd.d/clamd.conf
sed -i ‘/^Example/d’ /etc/clamd.d/clamd.conf

User clamscan
LocalSocket /var/run/clamd.<SERVICE>/clamd.sock

# Enable Freshclam
cp /etc/freshclam.conf /etc/freshclam.conf.bak
sed -i ‘/^Example/d’ /etc/freshclam.conf

# Missing systemd service file
/usr/lib/systemd/system/clam-freshclam.service
##BEGIN
# Run the freshclam as daemon
[Unit]
Description = freshclam scanner
After = network.target
[Service]
Type = forking
ExecStart = /usr/bin/freshclam -d -c 4
Restart = on-failure
PrivateTmp = true
[Install]
WantedBy=multi-user.target 
##END

systemctl enable clam-freshclam.service
systemctl start clam-freshclam.service

# Change service files
mv /usr/lib/systemd/system/clamd@.service /usr/lib/systemd/system/clamd.service
/usr/lib/systemd/system/clamd@scan.service
<< REMOVE @ SIGN >>

# Original instructions included "--nofork=yes", now incorrect
/usr/lib/systemd/system/clamd.service
##BEGIN
[Unit]
Description = clamd scanner daemon
After = syslog.target nss-lookup.target network.target
[Service]
Type = simple
ExecStart = /usr/sbin/clamd -c /etc/clamd.d/clamd.conf 
Restart = on-failure
PrivateTmp = true

[Install]
WantedBy=multi-user.target
##END

# Start all services.
cd /usr/lib/systemd/system
systemctl enable clamd.service
systemctl enable clamd@scan.service
systemctl start clamd.service
systemctl start clamd@scan.service

freshclam -v 

# --------------------------------------------------------------
# Installing SpamAssassin
# --------------------------------------------------------------
yum install spamassassin 
sa-update
service spamassassin start
chkconfig spamassassin on 
ln -s /usr/bin/freshclam /usr/local/bin/freshclam 

# Configuring Postfix
service postfix stop
chkconfig postfix off 

echo "# This line is added ##" >> /etc/postfix/main.cf 
echo "header_checks = regexp:/etc/postfix/header_checks" >> /etc/postfix/main.cf

echo "## This line is added ##" >> /etc/postfix/header_checks
echo "/^Received:/ HOLD" >> /etc/postfix/header_checks

# --------------------------------------------------------------
# Preparing MailScanner
# --------------------------------------------------------------
cd /opt
wget https://s3.amazonaws.com/msv5/release/MailScanner-5.0.3-7.rhel.tar.gz
tar xvzf MailScanner-5.0.3-7.rhel.tar.gz
cd MailScanner-5.0.3-7.rhel.tar.gz
./install.sh

# MANUAL INSTALL STEPS

mkdir /var/spool/MailScanner/spamassassin
chown postfix /var/spool/MailScanner/spamassassin
chown postfix /var/spool/MailScanner/incoming/*

/etc/MailScanner/MailScanner.conf 
##BEGIN
%org-name% = test CentOS Mail Server
%org-long-name% = ORGFULLNAME
%web-site% = ORG WEBSITE

Run As User = postfix
Run As Group = postfix
MTA = postfix

Incoming Queue Dir = /var/spool/postfix/hold
Outgoing Queue Dir = /var/spool/postfix/incoming

Virus Scanners = clamav

## please check /etc/MailScanner/spam.lists.conf for more details ##
Spam List = SBL+XBL

## the directory created earlier ##
SpamAssassin User State Dir = /var/spool/MailScanner/spamassassin
##END


# MANUAL REVIEW
#MailScanner -lint 

service MailScanner start
chkconfig MailScanner on 

# Verifying MailScanner Operation
# tail -f tailf /var/log/maillog 


# maybe upgrade with Amavisd-new
# http://forums.sentora.org/showthread.php?tid=1132
