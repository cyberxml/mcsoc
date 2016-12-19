#! /bin/bash

test="Block TCP ping from ENTWKS to ENTSVR FILE on Port 22"
host="10.10.8.15"
port="22"
cmd="nc -w 2 ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	ROUTING	ENTWKS	${test}	${0}"
else
	echo -e "[P]	ROUTING	ENTWKS	${test}	${0}"
fi
