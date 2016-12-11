#! /bin/bash

test="Send MAIL from ENTSVR to ENTSVR MAIL with EICAR in message"
mailserver='mail.example.net'
fromaddress='unittest@example.net'
toaddress='user@example.net'
testphrase1='X5O!P%@AP[4\PZX54(P^)7CC)7}'
testphrase2='$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*'
( python send_email.py ${mailserver} ${fromaddress} ${toaddress} "${testphrase1}${testphrase2}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]    EMAIL FILTER	ENTSVR     ${test} ${0}"
else
        echo -e "[F]    EMAIL FILTER	ENTSVR     ${test} ${0}"
fi
