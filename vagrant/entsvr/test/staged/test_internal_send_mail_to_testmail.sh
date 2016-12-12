#! /bin/bash
cd /vagrant/test/staged

test="Send MAIL from ENTSVR to TEST via DMZMAIL"
mailserver='10.10.3.4'
fromaddress='unittest@example.net'
toaddress='postmaster@pub.test'
testphrase='Unittest ENTSVR TO TEST'
( python send_email.py ${mailserver} ${fromaddress} ${toaddress} "${testphrase}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]	EMAIL	ENTSVR	${test}	${0}"
else
        echo -e "[F]	EMAIL	ENTSVR	${test}	${0}"
fi
