#! /bin/bash

test="Allow direct web access from ENTWKS to ENTSVR Web on Port 80"
host="10.10.8.14"
port="80"
SHA1SUM="bac9e0eb1845c965e808a0385b53b4519f83ee90"
RETSTR=$(curl -m 12 -s http://${host}:${port}/test/test.txt  | sha1sum | cut -d' ' -f1)
if [[ $RETSTR == $SHA1SUM ]]; then
	echo -e "[P]	WEB	ENTWKS	${test}	${0}"
else
	echo -e "[F]	WEB	ENTWKS	${test}	${0}"
fi
