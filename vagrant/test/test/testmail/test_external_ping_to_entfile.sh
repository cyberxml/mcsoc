#! /bin/bash

test="Block ping from External Hosts to Internal Mail"
host="10.10.8.13"
pre="ping -q -c 4 ${host}"
cmd="ping -q -c 1 ${host}"
${pre} > /dev/null 2>&1
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	ROUTING	TEST	${test}	${0}"
else
	echo -e "[P]	ROUTING	TEST	${test}	${0}"
fi
