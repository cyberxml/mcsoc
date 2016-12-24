#! /bin/bash

test="Block direct web access from ENTSVR to TEST Web on Port 80"
host="10.10.1.114"
port="80"
SHA1SUM="f09eefe9eacf911076ecaeeac71043e57b6b4d12"
RETSTR=$(curl -m 12 -s http://${host}:${port}/test/test.txt  | sha1sum | cut -d' ' -f1)
if [[ $RETSTR == $SHA1SUM ]]; then
	echo -e "[F]	ROUTING	ENTSVR	${test}	${0}"
else
	echo -e "[P]	ROUTING	ENTSVR	${test}	${0}"
fi
