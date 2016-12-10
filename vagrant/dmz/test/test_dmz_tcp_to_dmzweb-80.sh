#! /bin/bash

test="Allow TCP ping from DMZ to DMZ WEB on Port 80"
host="10.10.3.5"
port="80"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	DMZ	${test}	${0}"
else
	echo -e "[F]	DMZ	${test}	${0}"
fi
