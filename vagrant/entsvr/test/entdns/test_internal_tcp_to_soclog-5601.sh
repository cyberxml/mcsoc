#! /bin/bash

test="Block TCP ping from ENTSVR to SOC LOGSVR on Port 5601"
host="10.10.4.4"
port="5601"
cmd="nc -w2 -c 'hostname' ${host} ${port}"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	ROUTING	ENTSVR	${test}	${0}"
else
	echo -e "[P]	ROUTING	ENTSVR	${test}	${0}"
fi
