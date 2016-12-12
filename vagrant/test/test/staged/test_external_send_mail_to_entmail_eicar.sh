#! /bin/bash
cd /vagrant/test/staged

test="Send MAIL from TEST to ENTSVR MAIL via DMZ with EICAR in message"
mailserver='10.10.3.4'
fromaddress='unittest@pub.test'
toaddress='user@example.net'
testphrase1='X5O!P%@AP[4\PZX54(P^)7CC)7}'
testphrase2='$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*'
( python send_email.py ${mailserver} ${fromaddress} ${toaddress} "${testphrase1}${testphrase2}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]	EMAIL FILTER	TEST	${test}	${0}"
else
        echo -e "[F]	EMAIL FILTER	TEST	${test}	${0}"
fi
