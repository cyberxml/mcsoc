#! /bin/bash

test="Block Web Request with Remote File Inclusion"
host="10.10.3.5"
( true )
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
	echo -e "[F]	WEB FILTER	TEST	${test}	${0}"
else
	echo -e "[P]	WEB FILTER	TEST	${test}	${0}"
fi
