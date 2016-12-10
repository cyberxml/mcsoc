#! /bin/bash

test="Allow TCP ping from DMZ to ENTSVR MAIL on Port 143"
host="10.10.8.13"
port="143"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	DMZ	${test}	${0}"
else
	echo -e "[F]	DMZ	${test}	${0}"
fi