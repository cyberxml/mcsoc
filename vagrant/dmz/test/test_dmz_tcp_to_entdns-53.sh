#! /bin/bash

test="Block TCP ping from DMZ to ENTSVR DNS on Port 53"
host="10.10.8.11"
port="53"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	DMZ	${test}	${0}"
else
	echo -e "[P]	DMZ	${test}	${0}"
fi
