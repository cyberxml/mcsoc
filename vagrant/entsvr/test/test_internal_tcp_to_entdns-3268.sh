#! /bin/bash

test="Allow TCP ping from ENTSVR to ENTSVR DNS on Port 3268"
host="10.10.8.11"
port="3268"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ROUTING	ENTSVR	${test}	${0}"
else
	echo -e "[F]	ROUTING	ENTSVR	${test}	${0}"
fi
