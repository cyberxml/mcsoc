#! /bin/bash

test="Block Web Request with CRS 30 HTTP Policy"
host="dmzweb.example.net"
port="80"
SHA1SUM="bac9e0eb1845c965e808a0385b53b4519f83ee90"
#RETSTR=$(curl --data "param1=value1&param2=value2" -s http://${host}:${port}/test/test.txt  | sha1sum | cut -d' ' -f1)
RETSTR=$(curl -X PUT --data "param1=value1&param2=value2" -s http://${host}:${port}/test/test.txt  | sha1sum | cut -d' ' -f1)
if [[ $RETSTR == $SHA1SUM ]]; then
	echo -e "[F]	WEB FILTER	TEST	${test}	${0}"
else
	echo -e "[P]	WEB FILTER	TEST	${test}	${0}"
fi
