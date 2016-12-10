#! /bin/bash

test="Allow TCP ping from DMZ to ENTSVR WEB on Port 443"
host="10.10.8.14"
port="443"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	DMZ	${test}	${0}"
else
	echo -e "[F]	DMZ	${test}	${0}"
fi
