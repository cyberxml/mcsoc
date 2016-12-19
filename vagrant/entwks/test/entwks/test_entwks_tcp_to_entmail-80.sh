#! /bin/bash

test="Allow TCP ping from ENTWKS to ENTSVR Email on Port 80"
host="10.10.8.13"
port="80"
cmd="nc -w 2 ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ROUTING	ENTWKS	${test}	${0}"
else
	echo -e "[F]	ROUTING	ENTWKS	${test}	${0}"
fi
