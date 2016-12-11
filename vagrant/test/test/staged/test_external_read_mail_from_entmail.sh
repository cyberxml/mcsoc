#! /bin/bash
cd /vagrant/test/staged

test="Read MAIL in TEST from ENTSVR MAIL"
mailserver='testmail.pub.test'
maillogin='postmaster@pub.test'
mailpasswd='Vagrant!234'
testphrase='Unittest ENTSVR TO TEST'
( python read_email.py ${mailserver} ${maillogin} ${mailpasswd} "${testphrase}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]    EMAIL	ENTSVR     ${test} ${0}"
else
        echo -e "[F]    EMAIL	ENTSVR     ${test} ${0}"
fi
