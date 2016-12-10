#! /bin/bash

test="Allow ping from TEST Hosts to TEST Web"
host="10.10.1.114"
pre="ping -q -c 4 ${host}"
cmd="ping -q -c 1 ${host}"
${pre} > /dev/null 2>&1
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	TEST	${test}	${0}"
else
	echo -e "[F]	TEST	${test}	${0}"
fi
