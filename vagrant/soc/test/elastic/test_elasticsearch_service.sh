#! /bin/bash

test="Verify Elasticsearch Service is Up"
cmd="systemctl status elasticsearch"
${cmd} > /dev/null 2>&1
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[P]	SERVICE	ELASTIC	${test}	${0}"
else
	echo -e "[F]	SERVICE	ELASTIC	${test}	${0}"
fi
