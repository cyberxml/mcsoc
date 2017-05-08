#! /bin/bash

test="Allow TCP ping from DMZ to DMZ MAIL on Port 25"
host="10.10.3.4"
port="25"
cmd="echo | nc -w2 -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ROUTING	DMZ	${test}	${0}"
else
	echo -e "[F]	ROUTING	DMZ	${test}	${0}"
fi
