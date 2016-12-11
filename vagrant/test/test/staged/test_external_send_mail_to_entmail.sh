#! /bin/bash
cd /vagrant/test/staged

test="Send MAIL from TEST to ENTSVR MAIL via DMZ"
mailserver='10.10.3.4'
fromaddress='unittest@pub.test'
toaddress='user@example.net'
testphrase='Unittest TEST TO ENTSVR'
( python send_email.py ${mailserver} ${fromaddress} ${toaddress} "${testphrase}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]    EMAIL	TEST     ${test} ${0}"
else
        echo -e "[F]    EMAIL	TEST     ${test} ${0}"
fi
