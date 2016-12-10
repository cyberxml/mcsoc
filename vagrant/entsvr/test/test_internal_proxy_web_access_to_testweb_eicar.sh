#! /bin/bash

test="Block proxied web access to EICAR from ENTSVR to TEST Web on Port 80"
proxy_server="10.10.3.6"
proxy_port="3128"
host="10.10.1.114"
port="80"
SHA1SUM="3395856ce81f2b7382dee72602f798b642f14140"
RETSTR=$(curl -x http://${proxy_server}:${proxy_port} -s http://${host}:${port}/eicar/eicat.com.txt  | sha1sum | cut -d' ' -f1)
if [[ "$RETSTR" == "$SHA1SUM" ]]; then
	echo -e "[F]	ENTSVR	${test}	${0}"
else
	echo -e "[P]	ENTSVR	${test}	${0}"
fi
