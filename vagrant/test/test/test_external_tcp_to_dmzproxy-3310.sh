#! /bin/bash

test="Allow TCP ping from TEST to DMZ PROXY on Port 3310"
host="10.10.3.6"
port="3310"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ROUTING	TEST	${test}	${0}"
else
	echo -e "[F]	ROUTING	TEST	${test}	${0}"
fi
