#! /bin/bash

test="Block TCP ping from TEST to ENTSVR DNS on Port 53"
host="10.10.8.11"
port="53"
cmd="nc -w2 -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	ROUTING	TEST	${test}	${0}"
else
	echo -e "[P]	ROUTING	TEST	${test}	${0}"
fi
