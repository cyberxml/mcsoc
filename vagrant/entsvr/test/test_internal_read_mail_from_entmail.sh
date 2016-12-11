#! /bin/bash

test="Read MAIL in ENTSVR from ENTSVR MAIL"
mailserver='mail.example.net'
maillogin='user@example.net'
mailpasswd='Vagrant!234'
testphrase='Unittest ENTSVR TO ENTSVR'
( python read_email.py ${mailserver} ${maillogin} ${mailpasswd} "${testphrase}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]    EMAIL	ENTSVR     ${test} ${0}"
else
        echo -e "[F]    EMAIL	ENTSVR     ${test} ${0}"
fi
