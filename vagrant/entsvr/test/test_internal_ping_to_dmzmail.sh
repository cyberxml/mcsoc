#! /bin/bash

test="Allow ping from ENTSVR to DMZ MAIL"
host="10.10.3.4"
pre="ping -q -c 4 ${host}"
cmd="ping -q -c 1 ${host}"
${pre} > /dev/null 2>&1
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	ROUTING	ENTSVR	${test}	${0}"
else
	echo -e "[F]	ROUTING	ENTSVR	${test}	${0}"
fi
