#! /bin/bash

test="Read MAIL in TEST from TEST MAIL"
mailserver='testmail.pub.test'
maillogin='postmaster@pub.test'
mailpasswd='Vagrant!234'
testphrase='Unittest TEST TO TEST'
( python read_email.py ${mailserver} ${maillogin} ${mailpasswd} "${testphrase}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]	EMAIL	ENTSVR     ${test}	${0}"
else
        echo -e "[F]	EMAIL	ENTSVR     ${test}	${0}"
fi
