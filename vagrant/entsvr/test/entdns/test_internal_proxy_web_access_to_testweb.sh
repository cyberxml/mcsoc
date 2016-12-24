#! /bin/bash

test="Allow proxied web access from ENTSVR to TEST Web on Port 80"
proxy_server="10.10.3.6"
proxy_port="3128"
host="10.10.1.114"
port="80"
SHA1SUM="f09eefe9eacf911076ecaeeac71043e57b6b4d12"
RETSTR=$(curl -m 12 -x http://${proxy_server}:${proxy_port} -s http://${host}:${port}/test/test.txt  | sha1sum | cut -d' ' -f1)
if [[ "$RETSTR" == "$SHA1SUM" ]]; then
	echo -e "[P]	PROXY	ENTSVR	${test}	${0}"
else
	echo -e "[F]	PROXY	ENTSVR	${test}	${0}"
fi
