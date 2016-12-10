#! /bin/bash

test="Block TCP ping from TEST to ENTSVR WEB on Port 80"
host="10.10.8.14"
port="80"
cmd="nc -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	TEST	${test}	${0}"
else
	echo -e "[P]	TEST	${test}	${0}"
fi
