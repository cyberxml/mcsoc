#! /bin/bash

test="Block ping from External Hosts to Internal DNS"
host="10.10.8.11"
pre="ping -q -c 4 ${host}"
cmd="ping -q -c 1 ${host}"
${pre} > /dev/null 2>&1
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	TEST	${test}	${0}"
else
	echo -e "[P]	TEST	${test}	${0}"
fi
