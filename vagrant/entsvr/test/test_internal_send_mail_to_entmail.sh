#! /bin/bash

test="Send MAIL from ENTSVR to ENTSVR MAIL"
mailserver='mail.example.net'
fromaddress='unittest@example.net'
toaddress='user@example.net'
testphrase='Unittest ENTSVR TO ENTSVR'
( python send_email.py ${mailserver} ${fromaddress} ${toaddress} "${testphrase}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]    EMAIL	ENTSVR     ${test} ${0}"
else
        echo -e "[F]    EMAIL	ENTSVR     ${test} ${0}"
fi
