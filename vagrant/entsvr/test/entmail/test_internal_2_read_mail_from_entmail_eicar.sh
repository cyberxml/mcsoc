#! /bin/bash

test="Block MAIL in ENTSVR from ENTSVR MAIL wih EICAR text"
mailserver='entmail.example.net'
maillogin='user@example.net'
mailpasswd='Vagrant!234'
testphrase1='X5O!P%@AP[4\PZX54(P^)7CC)7}'
testphrase2='$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*'
( python read_email.py ${mailserver} ${maillogin} ${mailpasswd} "${testphrase1}${testphrase2}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[F]	EMAIL FILTER	ENTSVR     ${test}	${0}"
else
        echo -e "[P]	EMAIL FILTER	ENTSVR     ${test}	${0}"
fi
