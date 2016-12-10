#! /bin/bash

test="Allow TCP ping from DMZ to TEST WEB on Port 3306"
host="10.10.1.114"
port="3306"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	DMZ	${test}	${0}"
else
	echo -e "[F]	DMZ	${test}	${0}"
fi
