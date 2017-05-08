#! /bin/bash

test="Block TCP ping from ENTSVR to ENTSVR Web on Port 3306"
host="10.10.8.14"
port="3306"
cmd="nc -w2 -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	ROUTING	ENTSVR	${test}	${0}"
else
	echo -e "[P]	ROUTING	ENTSVR	${test}	${0}"
fi
