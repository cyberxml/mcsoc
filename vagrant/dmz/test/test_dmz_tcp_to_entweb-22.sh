#! /bin/bash

test="Block TCP ping from DMZ to ENTSVR WEB on Port 22"
host="10.10.8.14"
port="22"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	ROUTING	DMZ	${test}	${0}"
else
	echo -e "[P]	ROUTING	DMZ	${test}	${0}"
fi
