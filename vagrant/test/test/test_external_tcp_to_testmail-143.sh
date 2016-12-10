#! /bin/bash

test="Allow TCP ping from TEST to TEST MAIL on Port 143"
host="10.10.1.113"
port="143"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	TEST	${test}	${0}"
else
	echo -e "[F]	TEST	${test}	${0}"
fi