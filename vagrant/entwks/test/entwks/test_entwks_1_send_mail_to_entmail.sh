#! /bin/bash

test="Send MAIL from ENTWKS to ENTSVR MAIL"
mailserver='entmail.example.net'
fromaddress='unittest@example.net'
toaddress='user@example.net'
testphrase='Unittest ENTWKS TO ENTSVR'
( python send_email.py ${mailserver} ${fromaddress} ${toaddress} "${testphrase}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]	EMAIL	ENTWKS	${test}	${0}"
else
        echo -e "[F]	EMAIL	ENTWKS	${test}	${0}"
fi
