#! /bin/bash

test="Allow TCP ping from DMZ to DMZ PROXY on Port 3310"
host="10.10.3.6"
port="3310"
cmd="nc -w2 -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ROUTING	DMZ	${test}	${0}"
else
	echo -e "[F]	ROUTING	DMZ	${test}	${0}"
fi
