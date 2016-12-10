#! /bin/bash

test="Send MAIL from ENTSVR to DMZ MAIL"
cmd="python send_email.py"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]    ENTSVR     ${test} ${0}"
else
        echo -e "[F]    ENTSVR     ${test} ${0}"
fi
