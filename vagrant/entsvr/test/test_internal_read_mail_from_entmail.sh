#! /bin/bash

test="Read MAIL in ENTSVR from DMZ MAIL"
cmd="python read_email.py"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
        echo -e "[P]    ENTSVR     ${test} ${0}"
else
        echo -e "[F]    ENTSVR     ${test} ${0}"
fi
