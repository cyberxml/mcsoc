#! /bin/bash

test="Allow TCP ping from TEST to DMZ MAIL on Port 993"
host="10.10.3.4"
port="993"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ROUTING	TEST	${test}	${0}"
else
	echo -e "[F]	ROUTING	TEST	${test}	${0}"
fi
