#! /bin/bash
cd /vagrant/test/entmail/staged

test="Read MAIL in ENTSVR from TEST MAIL"
mailserver='entmail.example.net'
maillogin='user@example.net'
mailpasswd='Vagrant!234'
testphrase='Unittest TEST TO ENTSVR'
( python read_email.py ${mailserver} ${maillogin} ${mailpasswd} "${testphrase}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]	EMAIL	ENTSVR	${test}	${0}"
else
        echo -e "[F]	EMAIL	ENTSVR	${test}	${0}"
fi
