#! /bin/bash

test="Send MAIL from TEST to TEST MAIL"
mailserver='testmail.pub.test'
fromaddress='unittest@pub.test'
toaddress='postmaster@pub.test'
testphrase='Unittest TEST TO TEST'
( python send_email.py ${mailserver} ${fromaddress} ${toaddress} "${testphrase}" )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]	EMAIL	TEST     ${test}	${0}"
else
        echo -e "[F]	EMAIL	TEST     ${test}	${0}"
fi
