#! /bin/bash

test="Block TCP ping from ENTWKS to ENTWKS Email on Port 389"
host="10.10.8.13"
port="389"
cmd="nc -w 2 ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	ROUTING	ENTWKS	${test}	${0}"
else
	echo -e "[P]	ROUTING	ENTWKS	${test}	${0}"
fi
