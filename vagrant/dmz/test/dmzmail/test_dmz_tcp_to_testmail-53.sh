#! /bin/bash

test="Allow TCP ping from DMZ to TEST MAIL on Port 53"
host="10.10.1.113"
port="53"
cmd="nc -w2 -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ROUTING	DMZ	${test}	${0}"
else
	echo -e "[F]	ROUTING	DMZ	${test}	${0}"
fi
