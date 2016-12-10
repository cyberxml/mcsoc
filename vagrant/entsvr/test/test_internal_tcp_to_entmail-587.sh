#! /bin/bash

test="Allow TCP ping from ENTSVR to ENTSVR Email on Port 587"
host="10.10.8.13"
port="587"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ENTSVR	${test}	${0}"
else
	echo -e "[F]	ENTSVR	${test}	${0}"
fi
