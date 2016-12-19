#! /bin/bash

test="Allow TCP ping from TEST to TEST WEB on Port 443"
host="10.10.1.114"
port="443"
cmd="nc -w2 -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ROUTING	TEST	${test}	${0}"
else
	echo -e "[F]	ROUTING	TEST	${test}	${0}"
fi
