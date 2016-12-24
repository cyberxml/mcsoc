#! /bin/bash

test="Allow TCP ping from ENTSVR to ENTSVR DNS on Port 135"
host="10.10.8.11"
port="135"
cmd="nc -w2 -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ROUTING	ENTSVR	${test}	${0}"
else
	echo -e "[F]	ROUTING	ENTSVR	${test}	${0}"
fi
