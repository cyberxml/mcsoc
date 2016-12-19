#! /bin/bash

test="Read MAIL in ENTWKS from ENTSVR MAIL"
mailserver='entmail.example.net'
maillogin='user@example.net'
mailpasswd='Vagrant!234'
testphrase='Unittest ENTWKS TO ENTSVR'
( python read_email.py ${mailserver} ${maillogin} ${mailpasswd} "${testphrase}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]	EMAIL	ENTWKS	${test}	${0}"
else
        echo -e "[F]	EMAIL	ENTWKS	${test}	${0}"
fi
