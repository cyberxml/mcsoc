#! /bin/bash

test="Block ping from DMZ Hosts to ENTSVR Mail"
host="10.10.8.13"
pre="ping -q -c 4 ${host}"
cmd="ping -q -c 1 ${host}"
${pre} > /dev/null 2>&1
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	ROUTING	DMZ	${test}	${0}"
else
	echo -e "[p]	ROUTING	DMZ	${test}	${0}"
fi
